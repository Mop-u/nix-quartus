{ pkgs
, mkQuartus
, quartus-sources
, ...
}:

let
    mkVersion = { version, edition, extraArgs }:
        let
            source = quartus-sources."v${builtins.toString version}".${edition};
        in
            mkQuartus {
                inherit source extraArgs;
            };
in
    mkVersion