{
  pkgs,
  ...
}:
{
  imports = [
    ./b.nix
    ./man.nix
    ./kitty.nix
    ./nixgl.nix 
    ./tofi.nix
    ./plasma
    ./sway
    ./hyprland
    ./uwsm
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    # internet
    firefox

    # media
    vlc

    # xorg
    xclip
  ];
}

