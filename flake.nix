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

        mkVersion = { version, edition, extraArgs }: let
            source = sources."v${builtins.toString version}".${edition};
        in mkQuartus { inherit source extraArgs; };
        
    in {

        nixosModules.quartus = import ./module.nix {inherit mkVersion;};

        packages.${system} = {inherit mkVersion;};
    };
}