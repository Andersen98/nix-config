{config, pkgs, ...}:
{
  imports = [ ./components/uwsm.nix ];
  programs.uwsm = {
    waylandCompositors  = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
    };
  };
  programs.hyprland = {
    enable = true;
    package = config.dep-inject.flake-inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = config.dep-inject.flake-inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
}
