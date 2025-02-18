# nix-quartus
Nix Flake for Altera(Intel) Quartus.

These expressions are based on the expressions for Quartus found in Bjørn
Forsman's [nixos-config repository](https://github.com/bjornfor/nixos-config)

This has only been tested on x86_64 Linux.

## Building

Add this repo as an input to your flake

`flake.nix`
```nix
inputs = {
    # ...
    quartus.url = "github:Mop-u/nix-quartus";
    # ...
};
```

Then add the package as normal for the desired Quartus version. For
example, to install the Lite Edition of Quartus Prime 23 with support for Cyclone V devices & Questa:

`configuration.nix`

```nix
environment.systemPackages = [
    # ...
    (inputs.quartus.packages.${pkgs.system}.mkQuartus {
        edition = "lite";
        version = 23;
        installs = [ "QuestaSetup" ];
        devices = [ "cyclonev" ];
    })
    # ...
];
```
