{config, pkgs, inputs, outputs, ...}:

{
  imports = with outputs.nixosModules [
    # Import results from hardware scan
    ../hardware-configuration.nix
    nvidia
    base
  ];
  
security.polkit.enable = true;















  # Set number of cores for builds
  environment.sessionVariables.NIX_BUILD_CORE = "32";

  networking.hostName = "x570-sway"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?




}
