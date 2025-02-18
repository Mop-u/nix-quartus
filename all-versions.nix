{ pkgs
, mkVersion
, ...
}:

let
    mkLite = { version ? 23, ... } @ args:
        mkVersion {
            inherit version;
            edition = "lite";
            extraArgs = args;
        };

    mkPro = { version ? 24, ... } @ args:
        mkVersion {
            inherit version;
            edition = "pro";
            extraArgs = args;
        };
in
    {
        quartus-prime-lite = mkLite {};
        quartus-prime-pro  = mkPro  {};
    }