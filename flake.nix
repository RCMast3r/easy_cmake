{
  description = "a set of macros to make cmake easier";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }:
    let
      cmake_overlay = final: prev: {
        cmake_macros = final.callPackage ./default.nix { };
      };
      my_overlays = [ cmake_overlay ];
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ self.overlays.default ];
      };
    in
    {
      overlays.default = nixpkgs.lib.composeManyExtensions my_overlays;

      packages.x86_64-linux =
        rec {
          cmake_macros = pkgs.cmake_macros;
          default = cmake_macros;
        };

  devShells.x86_64-linux.default =
    pkgs.mkShell rec {
      # Update the name to something that suites your project.
      name = "nix-devshell";
      packages = with pkgs; [
        # Development Tools
        cmake
      ];

      # Setting up the environment variables you need during
      # development.
      shellHook =
        let
          icon = "f121";
        in
        ''
          export PS1="$(echo -e '\u${icon}') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
        '';
    };

};
}
