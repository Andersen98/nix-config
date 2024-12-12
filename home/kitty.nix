{config, pkgs, ...}:
{
  programs.kitty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.kitty;
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      foreground = "#${config.colorScheme.palette.base05}";
      background = "#${config.colorScheme.palette.base00}";
      selection_foreground = "#${config.colorScheme.palette.base05}";
      selection_background = "#${config.colorScheme.palette.base02}";
      disable_ligatures = "never";
      force_ltr = "no";
    };
    extraConfig = ''
      font_family      family='Fira Code' variable_name=FiraCodeRoman wght=304.2105263157895 features='+zero salt=1 +tnum +ss01 +ss02 +ss03 +ss04 +ss05 +ss06 +ss07 +ss08 +ss09 +ss10 +onum +ordn +sinf +hwid +calt'
      bold_font        auto
      italic_font      auto
      bold_italic_font auto
      '';
  };
}
