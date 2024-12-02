{ pkgs,lib, config, ... }:
{
  imports = [
    ./plugins/telescope.nix
    ./plugins/lspconfig.nix
    ./plugins/which-key.nix
    ./plugins/base16-nvim.nix
  ];
  
  programs.neovim =  {
    viAlias = true;
    vimAlias = true;
    enable = true;
    defaultEditor = true;
    extraLuaConfig = builtins.readFile ./extra-config.lua;
    package = config.dep-inject.flake-inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraLuaPackages = (ps: with ps; [ luarocks rocks-nvim ]);
    extraPackages = with pkgs; [
      gcc
      cabal
      gnutar
      luajit
      curl
      git
      gnumake
    ];
    extraWrapperArgs = [
      "--prefix"
      "PATH"
      ":"
      "${lib.makeBinPath [ 
        pkgs.luajit
        pkgs.luajitPackages.luarocks
        pkgs.luajitPackages.rocks-nvim
      ]}"
    ];
    plugins = with pkgs.vimPlugins; [
      #      { plugin = mini-nvim;
      #        type = "lua";
      #        config = "require('mini.icons').setup()";
      #      }
      {
        plugin = nvim-luadev;
        type = "lua";
        config = ''
          vim.api.nvim_set_keymap('n', '<leader>lg', '<Plug>(Luadev-RunLine)', {noremap = false,})
        '';
      }
      neorg-telescope
      {
        plugin = neorg;
        config = builtins.readFile ./plugins/neorg.lua;
        type = "lua";
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        config = ''
          require("nvim-treesitter.configs").setup {
            highlight = {
              enable = true,
            },
            indent = {
              enable = true,
            }
          }
        '';
        type = "lua";
      }
    ];
  };
}
