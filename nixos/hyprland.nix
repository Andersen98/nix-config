{config, pkgs, ...}:
{
  programs.hyprland = {
    enable = true;
    package = config.dep-inject.flake-inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackages = config.dep-inject.flake-inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
}
