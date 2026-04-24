{
  description = "My Neovim Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    reactive-nvim = {
      url = "github:rasulomaroff/reactive.nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
      ];

      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];

      perSystem = { pkgs, system, ... }: 
      let
        neovim = import ./nix/mkNeovim.nix { inherit inputs; } pkgs;
      in
      {
        overlayAttrs = {
          nvim-custom = neovim;
        };
	
        packages.default = neovim;
      };
    };
}
