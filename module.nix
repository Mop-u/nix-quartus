{mkVersion}: {config, lib, pkgs, ... }: let
    cfg = config.programs.quartus;

in {
    options.programs.quartus = with lib; {
        enable = mkEnableOption "Enables the quartus runner";
        lite = {
            enable = mkEnableOption "Enable Quartus Prime Lite edition";
            version = mkOption {
                description = "Major version number";
                type = with types; int;
                default = 23;
            };
            devices = mkOption {
                description = "Device support (see sources.nix devices)";
                type = with types; listOf str;
                default = [];
            };
            installs = mkOption {
                description = "Additional components to install (see sources.nix installers)";
                type = with types; listOf str;
                default = [];
            };
        };
        standard = {
            enable = mkEnableOption "Enable Quartus Prime Standard edition";
            version = mkOption {
                description = "Major version number";
                type = with types; int;
                default = 23;
            };
            devices = mkOption {
                description = "Device support (see sources.nix devices)";
                type = with types; listOf str;
                default = [];
            };
            installs = mkOption {
                description = "Additional components to install (see sources.nix installers)";
                type = with types; listOf str;
                default = [];
            };
        };
        pro = {
            enable = mkEnableOption "Enable Quartus Prime Pro edition";
            version = mkOption {
                description = "Major version number";
                type = with types; int;
                default = 25;
            };
            devices = mkOption {
                description = "Device support (see sources.nix devices)";
                type = with types; listOf str;
                default = [];
            };
            installs = mkOption {
                description = "Additional components to install (see sources.nix installers)";
                type = with types; listOf str;
                default = [];
            };
        };
    };
    config = with lib; mkIf cfg.enable {
        environment.systemPackages = [(pkgs.stdenvNoCC.mkDerivation {
            version = "0.1";
            name = "quartus-multi-runner";
            phases = [ "installPhase" ];
            installPhase = ''
                mkdir -p $out/bin
                ${builtins.concatStringsSep "\n" (builtins.map (x: "cp -r ${x}/* $out/") (
                    builtins.concatMap (
                        edition: optional cfg.${edition}.enable (pkgs.writeShellScriptBin "quartus-${edition}" ''
                            ${pkgs.nix}/bin/nix shell "${mkVersion {
                                inherit edition;
                                version = cfg.${edition}.version;
                                extraArgs.devices = cfg.${edition}.devices;
                                extraArgs.installs = cfg.${edition}.installs;
                            }}" --command "quartus"
                        ''
                    )) ["lite" "standard" "pro"])
                )}
            '';
        })];
    };
}