{pkgs,...}:
{

  imports = [
    ./components/hannah.nix
    ./components/fhs.nix
    ./components/mk-fish-default.nix
    ./components/kbd.nix
    ./components/pipewire-graphical.nix
    ./components/pipewire.nix
  ];
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    kdePackages.plasma-pa
  ];

}
