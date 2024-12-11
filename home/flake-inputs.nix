{flake-inputs}:
{config, pkgs, ...}:
{
  home.packages =  [
    flake-inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  
  ];
}
