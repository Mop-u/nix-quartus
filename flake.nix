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
                    quartus-prime-std
                    quartus-prime-pro;
            };
        };
}