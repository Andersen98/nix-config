{
  nvidia = import ./nvidia.nix;
  plasma6 = import ./plasma6.nix;
  plasma5 = import ./plasma5.nix;
  sway = import ./sway.nix;
  helix = import ./helix.nix;
  polkit = import ./polkit.nix;
  base = import ./base;
}
