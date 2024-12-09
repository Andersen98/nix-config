{flake-inputs}:
{config, pkgs, ...}:
{
  wayland.windowManager.hyprland = {
    package = flake-inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
}
