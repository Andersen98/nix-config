{
  config,
  pkgs,
  lib,
  ...
}:
{
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
    };
    aggregatedIcons = pkgs.buildEnv {
      name = "system-icons";
      paths = with pkgs; [
        nixos-icons
        papirus-icon-theme
        #epapirus-icon-theme
        #        kdePackages.breeze-icons
        #        kdePackages.breeze-gtk
        #gnome-themes-extra
      ];
      pathsToLink = [ "/share/icons" ];
    };
    aggregatedFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.packages;
      pathsToLink = [ "/share/fonts" ];
    };
  in {
    "/usr/share/icons" = mkRoSymBind "${aggregatedIcons}/share/icons";
    "/usr/local/share/fonts" = mkRoSymBind "${aggregatedFonts}/share/fonts";
  };
  fonts= {
    fontDir = {
      decompressFonts = true;
    };
    fontconfig = {
      defaultFonts = {
        monospace = [ "Victor Mono" "Symbols Nerd Font Mono" ];
        emoji = [ "Symbols Nerd Font Mono" "Noto Color Emoji" ]; 
      };
      hinting = {
        style = "none";
      };
      subpixel = {
        lcdfilter = "none";
        };
      allowBitmaps = false;
    };
    packages = with pkgs; [
      nerd-fonts.symbols-only
      victor-mono
      fleuron-font
      fira-code
      rakkas-font
      vollkorn-font
    ];
  };
}
