{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/x86_64-linux";

    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "systems";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; }; #nixpkgs.legacyPackages.${system};

    sources = import ./sources.nix {};
    buildQuartus = import ./package.nix;

  in {
    packages = rec {
      mkQuartus = conf: buildQuartus rec {
        inherit pkgs;
        source = sources."v${builtins.toString conf.version}".${conf.edition};
        installs = conf.installs or source.defaultInstalls;
        devices = conf.devices or source.defaultDevices;
      };
      
      # Aliases to latest versions
      quartus-prime-lite = conf: mkQuartus ({
        version = conf.version or 23;
        edition = "lite";
        installs = conf.installs or {};
        devices = conf.devices or {};
      });
      quartus-prime-standard = conf: mkQuartus ({
        version = conf.version or 23;
        edition = "standard";
        installs = conf.installs or {};
        devices = conf.devices or {};
      });
      quartus-prime-pro = conf: mkQuartus ({
        version = conf.version or 24;
        edition = "pro";
        installs = conf.installs or {};
        devices = conf.devices or {};
      });
    };
  });
}