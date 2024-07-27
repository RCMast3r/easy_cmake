{
  description = "a set of macros to make cmake easier";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = { self, nixpkgs, flake-parts }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; }
      {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];
        imports = [
          inputs.flake-parts.flakeModules.easyOverlay
        ];
        perSystem = { config, pkgs, system, ... }:
          let
            easy_cmake = pkgs.callPackage ./default.nix { };
          in
          {
            _module.args.pkgs = import inputs.nixpkgs {
              inherit system;
              config = { };
            };
            packages.default = easy_cmake;
            overlayAttrs = {
              inherit (config.packages) default;
            };
            legacyPackages =
              import nixpkgs {
                inherit system;
                overlays = [ (final: _: { inherit easy_cmake; }) ];
              };

          };
      };
}
