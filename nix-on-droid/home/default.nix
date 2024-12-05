{ lib, ...}:
{
  home.stateVersion = "24.05";
  home.username = lib.mkForce "nix-on-droid";
  home.homeDirectory = lib.mkForce "/data/data/com.termux.nix/files/home";
  imports = [
    ./nix-config.nix
    ../../home/b.nix 
  ];

}
