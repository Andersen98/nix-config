{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
    programs.uwsm.waylandCompositors = {
    sway = {
      prettyName = "Sway";
      comment = "Sway compositor managed by UWSM";
      binPath = "/run/current-system/sw/bin/sway";
    };
  };

  environment.systemPackages = with pkgs; [
    sway
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    networkmanagerapplet 
    xdg-desktop-portal-wlr
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    pavucontrol
    polkit
  ];
}
