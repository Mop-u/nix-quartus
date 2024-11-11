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

        sources = with pkgs; import ./sources.nix { inherit fetchurl requireFile; };

        buildQuartus = import ./generic.nix { inherit pkgs; };

        mkCommonQuartus = srcAttrs: buildQuartus {
            inherit (srcAttrs) baseName prettyName;
            version = srcAttrs.version;
            components = with srcAttrs.components; [
                quartus cyclone cyclonev # TODO: expose component selection to flake
            ];
            #updateComponents = with srcAttrs.updates.components; [
            #  quartus
            #];
        };
    in {
        packages = rec {

          quartus-ii-subscription-13 =
            mkCommonQuartus sources.v13.subscription_edition;

          quartus-ii-web-14 =
            mkCommonQuartus sources.v14.web_edition;

          quartus-ii-subscription-14 =
            mkCommonQuartus sources.v14.subscription_edition;

          quartus-prime-lite-15 =
            mkCommonQuartus sources.v15.lite_edition;

          quartus-prime-standard-15 =
            mkCommonQuartus sources.v15.standard_edition;

          quartus-prime-lite-16 =
            mkCommonQuartus sources.v16.lite_edition;

          quartus-prime-standard-16 =
            mkCommonQuartus sources.v16.standard_edition;

          quartus-prime-lite-17 =
            mkCommonQuartus sources.v17.lite_edition;

          quartus-prime-standard-17 =
            mkCommonQuartus sources.v17.standard_edition;

          quartus-prime-lite-18 =
            mkCommonQuartus sources.v18.lite_edition;

          quartus-prime-standard-18 =
            mkCommonQuartus sources.v17.standard_edition;

          # Aliases to latest versions
          quartus-prime-lite = quartus-prime-lite-18;
          quartus-prime-standard = quartus-prime-standard-18;
          quartus-prime-pro = quartus-prime-standard;
        };
    });
}