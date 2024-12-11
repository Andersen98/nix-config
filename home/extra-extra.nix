{ 
  pkgs,
  ...
}:
{

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # internet
    discord

    # media
    obs-studio
    inkscape
  ];
}

