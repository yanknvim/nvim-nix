{ inputs }:
  pkgs:
    let
      config = pkgs.lib.cleanSource ../nvim;
      mkPlugin = name: src: pkgs.vimUtils.buildVimPlugin { inherit name src; };
    in
      pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
        autoconfigure = true;
        autowrapRuntimeDeps = true;

        wrapperArgs = [
          "--add-flags" "--cmd 'set runtimepath^=${config}'"
          "--add-flags" "--cmd 'set runtimepath^=${config}/after'"
          "--add-flags" "--cmd 'let g:skk_jisyo = \"${pkgs.skkDictionaries.l}/share/skk/SKK-JISYO.L\"'"
          "--add-flags" "-u ${config}/init.lua"
        ];
        wrapRc = false;

        plugins = with pkgs.vimPlugins; [
          denops-vim
          nvim-web-devicons
          kanagawa-nvim
          incline-nvim
          nvim-lspconfig
          indent-blankline-nvim
          gitsigns-nvim
          nvim-autopairs
          flash-nvim
          snacks-nvim
          (mkPlugin "reactive-nvim" inputs.reactive-nvim)
          (mkPlugin "skkeleton" inputs.skkeleton)
        ];

        extraPackages = with pkgs; [
          lua-language-server
          rust-analyzer
          nil
          rg
          fd
          skkDictionaries.l
        ];
      }
