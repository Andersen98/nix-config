{pkgs,...}:
{
  environment.systemPackages = with pkgs; [
    fnott
    hyprpolkitagent
    hyprcursor
  ];
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

}