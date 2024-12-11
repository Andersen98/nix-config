{
  imports = [ ./hyprland.nix ];
  xdg.configFile.uwsm-hyprland-env = {
    source = ./uwsm-env;
    target = "uwsm/env-hyprland";
  };
}

