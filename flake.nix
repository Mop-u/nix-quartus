{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs, flake-utils, ... }:
    let
        system = "x86_64-linux";

        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };

        sources = import ./sources.nix {};

        mkQuartusUnwrapped = pkgs.callPackage ./make-quartus-unwrapped.nix {
            inherit (pkgs.stdenv) mkDerivation;
        };

        mkQuartus = pkgs.callPackage ./make-quartus.nix {
            inherit mkQuartusUnwrapped;
        };

        mkVersion = import ./make-version.nix {
            inherit pkgs mkQuartus;
            quartus-sources = sources;
        };

        all-quartuses = import ./all-versions.nix {
            inherit pkgs mkVersion;
        };

        run-quartus = pkgs.callPackage ./run-quartus.nix {};

        latestVer = {
            lite = 23;
            standard = 23;
            pro = 24;
        };
    in
        {
            apps.${system}.default = {
                type = "app";
                program = "${run-quartus}/bin/${run-quartus.pname or run-quartus.name}";
            };

            packages.${system} = {
                inherit mkVersion;
                inherit (all-quartuses)
                    quartus-prime-lite
                    quartus-prime-standard
                    quartus-prime-pro;

                quartus-multi = args: let 
                    editions = (builtins.mapAttrs (name: value: (
                        mkVersion {
                            edition = name; # lite/standard/pro
                            version = value.version or latestVer.${name};
                            extraArgs.devices = value.devices or [];
                            extraArgs.installs = value.installs or [];
                        }
                    )) args);
                    #builtins.attrValues
                    runners = with builtins; attrValues (mapAttrs (name: value: (
                        pkgs.writeShellScriptBin "quartus-${name}" ''
                            ${pkgs.nix}/bin/nix shell "${value}" --command "quartus"
                        ''
                    )) editions);
                in pkgs.stdenvNoCC.mkDerivation {
                    inherit system;
                    version = "0.1";
                    name = "quartus-multi-runner";
                    phases = [ "installPhase" ];
                    installPhase = ''
                        mkdir -p $out/bin
                        ${builtins.concatStringsSep "\n" (builtins.map (x: "cp -r ${x}/* $out/") runners)}
                    '';
                };
            };
        };
}