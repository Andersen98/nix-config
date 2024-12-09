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
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";

    # Not officially in the specification
    XDG_BIN_HOME    = "$HOME/.local/bin";
    PATH = [ 
      "${XDG_BIN_HOME}"
    ];
    XDG_CURRENT_DESKTOP = "sway";
  };
  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs; [
    wofi
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    networkmanagerapplet 
    xdg-desktop-portal-wlr
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    pavucontrol
    networkmanager_dmenu
  ];
  security.polkit.enable = true;

  # My desktop environment does not have a bluetooth gui
  # so enable a gui here if we are using bluetooth
  services.blueman.enable = mkIf config.hardware.bluetooth.enable true;
}
