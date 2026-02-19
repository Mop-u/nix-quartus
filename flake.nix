{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        moppkgs.url = "github:Mop-u/moppkgs";
    };

    outputs =
        {
            self,
            nixpkgs,
            moppkgs,
            flake-utils,
            ...
        }:
        let
            system = "x86_64-linux";

            pkgs =
                (import nixpkgs {
                    inherit system;
                    config.allowUnfree = true;
                }).extend
                    moppkgs.overlays.quartus;

            mkVersion =
                {
                    version,
                    edition,
                    extraArgs ? null,
                }:
                let
                    quartusSource = (import ./sources.nix { })."v${builtins.toString version}".${edition};
                in
                pkgs.quartus-prime-pro.override (
                    {
                        inherit quartusSource;
                    }
                    // (
                        if extraArgs != null then
                            { quartusOptions = extraArgs; }
                        else
                            {
                                quartusOptions = {
                                    devices = quartusSource.defaultDevices;
                                    installs = quartusSource.defaultInstalls;
                                };
                            }
                    )
                );

        in
        {
            nixosModules.quartus = import ./module.nix { inherit mkVersion; };

            packages.${system} = { inherit mkVersion; };
        };
}
