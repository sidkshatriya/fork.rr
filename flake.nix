{
  description = "rr debugger";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        with pkgs;
        let
          rr = (callPackage ./default.nix { }).overrideAttrs (_prev: {
            version = "5.7.0-master";
            src = ./.;
          });
        in
        {
          packages.default = rr;
        };
    };
}
