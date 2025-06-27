{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    devenv.url = "github:cachix/devenv";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.devenv.flakeModule ];
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        with pkgs.lib;
        let
          godot = pkgs.godot_4_4;
          gdtoolkit = pkgs.gdtoolkit_4;
        in
        {
          devenv.shells.default = {
            packages = filter (package: builtins.elem system package.meta.platforms) [
              gdtoolkit
              godot
            ];
          };
        };
    };
}
