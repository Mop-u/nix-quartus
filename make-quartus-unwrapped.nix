{ mkDerivation
, lib
, fetchurl
, unstick
}:

let
  mkQuartus = { source, extraArgs }:
    let
      installs = extraArgs.installs or source.defaultInstalls;
      devices  = extraArgs.devices or source.defaultDevices;

      allInstallers = lib.mapAttrsToList (n: v: n) source.installers;
      allDevices = lib.mapAttrsToList (n: v: n) source.devices;

      installList = lib.unique ([source.quartusInstaller] ++ installs);
      installPartList = lib.concatMap (id: (lib.mapAttrsToList (n: v: n) (source.installerParts.${id} or {}))) installList;

      # v21 and higher have Questa
      hasQuesta = lib.any (id: id == "QuestaSetup") allInstallers;
      withQuesta = lib.any (id: id == "QuestaSetup") installList;

      # v20 and lower have ModelSim
      hasModelSim = lib.any (id: id == "ModelSimSetup") allInstallers;
      withModelSim = lib.any (id: id == "ModelSimSetup") installList;

      selectedDevices = lib.intersectLists allDevices (lib.unique devices); # TODO: error if device not in list
      unselectedDevices = lib.subtractLists allDevices selectedDevices;

      installPartHashes = lib.mergeAttrsList (map (id: 
        source.installerParts.${id} or {}
      ) allInstallers);

      componentTree = lib.mapAttrs (n: v: 
        (if (lib.isString v) then { ${n} = v; } else v)
      ) source.devices;

      version = source.version;

      download = {name, hash}: fetchurl {
        inherit name hash;
        url = "${source.baseUrl}/${name}";
      };

      installers = map (id: download {
        name = "${id}-${version}-linux.run";
        hash = source.installers.${id};
      }) installList;

      components = lib.unique (
        (map (id: download {
          name = "${id}-${version}-linux.qdz";
          hash = installPartHashes.${id};
        }) installPartList)
      ++ 
        (lib.concatMap (dev: 
          (map (part: download {
            name = "${part}-${version}.qdz";
            hash = componentTree.${dev}.${part};
          }) (lib.mapAttrsToList (n: v: n) componentTree.${dev}))
        ) selectedDevices)
      );

    in mkDerivation {
      inherit version;
      pname = "quartus-prime-${source.variant}-unwrapped";

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
          ${if (source.variant!="pro") then ''
            substituteInPlace $out/quartus/adm/qenv.sh \
              --replace-fail 'grep sse /proc/cpuinfo > /dev/null 2>&1' ':'
          '' else ""}
        '';

      meta = {
        homepage = "https://fpgasoftware.intel.com";
        description = "FPGA design and simulation software";
        sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
        license = lib.licenses.unfree;
        platforms = [ "x86_64-linux" ];
        maintainers = with lib.maintainers; [ bjornfor kwohlfahrt ];
      };
    };
in
  mkQuartus
