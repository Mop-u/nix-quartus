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
                default = 24;
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
                    (optional cfg.lite.enable (pkgs.writeShellScriptBin "quartus-lite" ''
                        ${pkgs.nix}/bin/nix shell "${mkVersion {
                            edition = "lite";
                            version = cfg.lite.version;
                            extraArgs.devices = cfg.lite.devices;
                            extraArgs.installs = cfg.lite.installs;
                        }}" --command "quartus"
                    '')) ++
                    (optional cfg.standard.enable (pkgs.writeShellScriptBin "quartus-standard" ''
                        ${pkgs.nix}/bin/nix shell "${mkVersion {
                            edition = "standard";
                            version = cfg.standard.version;
                            extraArgs.devices = cfg.standard.devices;
                            extraArgs.installs = cfg.standard.installs;
                        }}" --command "quartus"
                    '')) ++
                    (optional cfg.pro.enable (pkgs.writeShellScriptBin "quartus-pro" ''
                        ${pkgs.nix}/bin/nix shell "${mkVersion {
                            edition = "pro";
                            version = cfg.pro.version;
                            extraArgs.devices = cfg.pro.devices;
                            extraArgs.installs = cfg.pro.installs;
                        }}" --command "quartus"
                    ''))
                ))}
            '';
        })];
    };
}