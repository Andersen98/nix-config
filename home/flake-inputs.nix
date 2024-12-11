{flake-self,flake-inputs}:
{config, pkgs, ...}:
{
  home.packages =  [
    flake-inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  
  ];

  xdg.configFile."hypr/hypr_nix_store_path.conf".text = ''
    $HYPR_NIX_STORE_PATH = ${flake-self}/home/hypr
  '';

  
}
