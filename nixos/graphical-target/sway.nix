{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  imports = [
    ./uwsm.nix
  ];

    programs.uwsm.waylandCompositors = {
    sway = {
      prettyName = "Sway";
      comment = "Sway compositor managed by UWSM";
      binPath = "/run/current-system/sw/bin/sway";
    };
  };

  services.passSecretService.enable = true;
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

  # My desktop environment does not have a bluetooth gui
  # so enable a gui here if we are using bluetooth
  services.blueman.enable = mkIf config.hardware.bluetooth.enable true;
}
