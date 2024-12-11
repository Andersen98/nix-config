{
  pkgs,
  ...
}:
{
  imports = [
    ./man.nix
    ./kitty.nix
    ./nixgl.nix 
    ./tofi.nix
    ./plasma
    ./sway
    ./hyprland
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

