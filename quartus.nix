{ pkgs
, source
, installs ? source.defaultInstalls
, devices ? source.defaultComponents
}:

  with pkgs; let


  allInstallers = lib.mapAttrsToList (name: value: name) source.installers;
  allDevices = lib.mapAttrsToList (name: value: name) source.deviceComponents;
  allExtras = lib.mapAttrsToList (name: value: name) source.extraComponents;
  allComponents = allDevices ++ allExtras;

  installList = lib.unique (source.mandatoryInstalls ++ installs);
  componentList = lib.unique (source.mandatoryComponents ++ devices);

  # v21 and higher have Questa
  hasQuesta = lib.any (id: id == "QuestaSetup") allInstallers;
  withQuesta = lib.any (id: id == "QuestaSetup") installList;

  # v20 and lower have ModelSim
  hasModelSim = lib.any (id: id == "ModelSimSetup") allInstallers;
  withModelSim = lib.any (id: id == "ModelSimSetup") installList;

  selectedDevices = lib.intersectLists allDevices componentList;
  unselectedDevices = lib.subtractLists allDevices selectedDevices;

  sourceHashes = (source.installers // source.deviceComponents // source.extraComponents);

  version = source.version;

  download = {name, hash}: fetchurl {
    inherit name hash;
    # e.g. "23.1std.0.991" -> "23.1std/921"
    url = "${source.baseUrl}/${name}";
  };

  installers = map (id: download {
    name = "${id}-${version}-linux.run";
    hash = lib.getAttr id sourceHashes;
  }) installList;

  components = map (id: download {
    name = "${id}-${version}.qdz";
    hash = lib.getAttr id sourceHashes;
  }) componentList;

in stdenv.mkDerivation {
  inherit version;
  pname = "quartus-prime-lite-unwrapped";

  nativeBuildInputs = [ unstick ];

  buildCommand = let
    copyInstaller = installer: ''
        # `$(cat $NIX_CC/nix-support/dynamic-linker) $src[0]` often segfaults, so cp + patchelf
        cp ${installer} $TEMP/${installer.name}
        chmod u+w,+x $TEMP/${installer.name}
        patchelf --interpreter $(cat $NIX_CC/nix-support/dynamic-linker) $TEMP/${installer.name}
      '';
    copyComponent = component: "cp ${component} $TEMP/${component.name}";
    # leaves enabled: quartus, devinfo
    disabledComponents = [
      "quartus_help"
      "quartus_update"
    ] ++ (if hasQuesta then (["questa_fe"] ++ (lib.optional (!withQuesta) "questa_fse")) else [])
      ++ (if hasModelSim then (["modelsim_ae"] ++ (lib.optional (!withModelSim) "modelsim_ase")) else [])
      ++ unselectedDevices;
  in ''
      echo "setting up installer..."
      ${lib.concatMapStringsSep "\n" copyInstaller installers}
      ${lib.concatMapStringsSep "\n" copyComponent components}

      echo "executing installer..."
      # "Could not load seccomp program: Invalid argument" might occur if unstick
      # itself is compiled for x86_64 instead of the non-x86 host. In that case,
      # override the input.
      unstick $TEMP/${(builtins.head installers).name} \
        --disable-components ${lib.concatStringsSep "," disabledComponents} \
        --mode unattended --installdir $out --accept_eula 1

      echo "cleaning up..."
      rm -r $out/uninstall $out/logs

      # replace /proc pentium check with a true statement. this allows usage under emulation.
      substituteInPlace $out/quartus/adm/qenv.sh \
        --replace-fail 'grep sse /proc/cpuinfo > /dev/null 2>&1' ':'
    '';

  meta = with lib; {
    homepage = "https://fpgasoftware.intel.com";
    description = "FPGA design and simulation software";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ bjornfor kwohlfahrt ];
  };
}
