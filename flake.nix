{
  description = "My Neovim Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    reactive-nvim = {
      url = "github:rasulomaroff/reactive.nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        config = pkgs.lib.cleanSource ./nvim;

        mkPlugin = name: src: pkgs.vimUtils.buildVimPlugin { inherit name src; };

        neovim = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
          autoconfigure = true;
          autowrapRuntimeDeps = true;

          wrapperArgs = [
            "--add-flags" "--cmd 'set runtimepath^=${config}'"
            "--add-flags" "--cmd 'set runtimepath^=${config}/after'"
            "--add-flags" "-u ${config}/init.lua"
          ];
          wrapRc = false;

          plugins = with pkgs.vimPlugins; [
            nvim-web-devicons
            kanagawa-nvim
            incline-nvim
            nvim-lspconfig
            indent-blankline-nvim
            gitsigns-nvim
            nvim-autopairs
            (mkPlugin "reactive-nvim" inputs.reactive-nvim)
          ];

          extraPackages = with pkgs; [
            lua-language-server
            rust-analyzer
            nil
          ];
        };
      in
      {
        packages.default = neovim;
	overlays.default = final: prev: {
	  nvim-custom = neovim;
	};
      }
    );
}
