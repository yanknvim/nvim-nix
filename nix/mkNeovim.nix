{ inputs }:
  pkgs:
    let
      packDir = pkgs.vimUtils.packDir {
        neovimPackages = {
          start = with pkgs.vimPlugins; [
            denops-vim
            nvim-web-devicons
            kanagawa-nvim
            nvim-autopairs
            snacks-nvim
            nvim-lspconfig
            (mkPlugin "reactive-nvim" inputs.reactive-nvim)
            (mkPlugin "skkeleton" inputs.skkeleton)
          ];
          opt = with pkgs.vimPlugins; [
            gitsigns-nvim
            incline-nvim
            indent-blankline-nvim
            flash-nvim
          ];
        };
      };


      config = pkgs.lib.cleanSource ../nvim;
      mkPlugin = name: src: pkgs.vimUtils.buildVimPlugin { inherit name src; };

      extraTools = with pkgs; [
        lua-language-server
        rust-analyzer
        nil
        ripgrep
        fd
        skkDictionaries.l
      ];
    in
      pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
        autoconfigure = false;
        autowrapRuntimeDeps = true;

        wrapperArgs = [
          "--prefix" "PATH" ":" "${pkgs.lib.makeBinPath extraTools}"
          "--add-flags" "--cmd 'set packpath^=${packDir}'"
          "--add-flags" "--cmd 'set runtimepath^=${config}'"
          "--add-flags" "--cmd 'set runtimepath+=${config}/after'"
          "--add-flags" "--cmd 'let g:skk_jisyo = \"${pkgs.skkDictionaries.l}/share/skk/SKK-JISYO.L\"'"
          "--add-flags" "-u ${config}/init.lua"
        ];
        wrapRc = false;

        plugins = [];
      }
