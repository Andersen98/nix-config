{pkgs,lib,...}:
{
  environment.systemPackages = with pkgs; [
    fnott
    wl-clipboard
    hyprpolkitagent
    hyprcursor
    hyprlock
    hyprpaper
    hyprshot
    xdg-desktop-portal-hyprland
    kdePackages.xdg-desktop-portal-kde
    xdg-desktop-portal-gtk
  ];
  security.pam.services.hyprlock = {};
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
