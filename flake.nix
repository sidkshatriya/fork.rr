{
  description = "rr debugger";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "i686-linux" "x86_64-linux" "aarch64-linux" ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        let
          rr = pkgs.rr.overrideAttrs (_prev: {
            version = "5.7.0-master";
            src = ./.;
          });
        in
        {
          packages.default = rr;
          packages.rr = rr;
          packages.rr-no-tests = rr.overrideAttrs (prev: {
            cmakeFlags = prev.cmakeFlags ++ [
              "-DBUILD_TESTS=OFF"
            ];
          });
        };
    };
}
