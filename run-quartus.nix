{ writeShellScriptBin
, nix
}:

let
    run-quartus = writeShellScriptBin "run-quartus" ''
        if [ "$#" -ne 1 ]; then
            >&2 echo "Usage:    run-quartus <version>"
            >&2 echo ""
            >&2 echo "          version:    pro/std/lite"
        fi

        if [ "$1" = "pro" ]; then
            ${nix}/bin/nix shell .#quartus-prime-pro --command "quartus"
        fi

        if [ "$1" = "std" ]; then
            ${nix}/bin/nix shell .#quartus-prime-std --command "quartus"
        fi

        if [ "$1" = "lite" ]; then
            ${nix}/bin/nix shell .#quartus-prime-lite --command "quartus"
        fi
    '';
in
    run-quartus