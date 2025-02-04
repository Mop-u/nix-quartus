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

    legacySources = with pkgs; import ./legacySources.nix { inherit fetchurl requireFile; };
    buildLegacyQuartus = import ./legacyPackage.nix { inherit pkgs; };

    mkLegacyQuartus = legacySource: buildLegacyQuartus {
      inherit (legacySource) baseName prettyName;
      version = legacySource.version;
      components = with legacySource.components; [
        quartus # TODO: expose component selection to flake
      ];
      #updateComponents = with legacySource.updates.components; [
      #  quartus
      #];
    };

    mkQuartus = source: buildQuartus {
      inherit pkgs source;
    };

  in {
    packages = rec {

      quartus-ii-subscription-13 =
        mkLegacyQuartus legacySources.v13.subscription_edition;

      quartus-ii-web-14 =
        mkLegacyQuartus legacySources.v14.web_edition;

      quartus-ii-subscription-14 =
        mkLegacyQuartus legacySources.v14.subscription_edition;

      quartus-prime-lite-15 =
        mkLegacyQuartus legacySources.v15.lite;

      quartus-prime-standard-15 =
        mkLegacyQuartus legacySources.v15.standard;

      quartus-prime-lite-16 =
        mkLegacyQuartus legacySources.v16.lite;

      quartus-prime-standard-16 =
        mkLegacyQuartus legacySources.v16.standard;

      quartus-prime-lite-17 =
        mkLegacyQuartus legacySources.v17.lite;

      quartus-prime-standard-17 =
        mkLegacyQuartus legacySources.v17.standard;

      quartus-prime-lite-18 =
        mkLegacyQuartus legacySources.v18.lite;

      quartus-prime-standard-18 =
        mkLegacyQuartus legacySources.v18.standard;

      # mkLegacyQuartus crashes from v19 onwards with:
      #   Error changing permissions to 042750 in /nix/store/w49zcrkmcx8lyclbwsxkz0y45y7ys8ka-altera-quartus-prime-lite-unwrapped-19.1.0.670/ip/altera/mentor_vip_ae/axi3
      quartus-prime-lite-19 = 
        mkQuartus sources.v19.lite;
        
      quartus-prime-standard-19 = 
        mkQuartus sources.v19.standard;

      quartus-prime-lite-20 = 
        mkQuartus sources.v20.lite;

      quartus-prime-standard-20 = 
        mkQuartus sources.v20.standard;

      quartus-prime-lite-21 = 
        mkQuartus sources.v21.lite;

      quartus-prime-lite-22 = 
        mkQuartus sources.v22.lite;
        
      quartus-prime-lite-23 = 
        mkQuartus sources.v23.lite;

      quartus-prime-standard-23 = 
        mkQuartus sources.v23.standard;

      quartus-prime-pro-23 = 
        mkQuartus sources.v23.pro;

      quartus-prime-pro-24 = 
        mkQuartus sources.v24.pro;

      # Aliases to latest versions
      quartus-prime-lite = quartus-prime-lite-23;
      quartus-prime-standard = quartus-prime-standard-23;
      quartus-prime-pro = quartus-prime-pro-24;
    };
  });
}