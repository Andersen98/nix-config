{config, lib, ...}:
{
  home.file.".config/networkmanager-dmenu" = {
    source = ./networkmanager-dmenu;
    recursive = true;
    executable = false;
  };

  home.file.".config/xdg-desktop-portal/sway-portals.conf" = {
    source = ./sway-portals.conf;
    recursive = false;
    executable = false;
  };
    
  home.file.".config/wofi" = {
    source = ./wofi;
    recursive = true;
    executable = false;
  };
  home.file.".config/sway/config".text = (import ./config.nix) {inherit config; inherit lib;};
  home.file.".config/sway/config.d" = {
    source = ./config.d;
    recursive = true;
    executable = false;
  };
}
