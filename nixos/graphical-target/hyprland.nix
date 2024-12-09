{lib,config, pkgs, ...}:
{
  options = { };
  config = {
    programs.hyprland ={
      enable = true;
      withUWSM = true;
    };

    programs.uwsm.waylandCompositors = {
      hyprland = {
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "/run/current-system/sw/bin/Hyprland";
    };
  };
};

}
