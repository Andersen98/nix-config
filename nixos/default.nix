{pkgs,...}:{
  imports = [
    ./fhs.nix
    ./fonts.nix
    ./hannah.nix
    ./kbd.nix
    ./dbus.nix
    ./mk-fish-default.nix
    ./pipewire-graphical.nix
    ./pipewire.nix
    ./plymouth.nix
    ./ssh.nix
    ./intel-usb-rw.nix
    ./console.nix
    ./zen-kernel.nix
    ./gaming-performance-tweaks.nix
    ./wine.nix
    ./qemu.nix
    ./graphical-target
  ];
  environment.systemPackages = with pkgs; [
    fatcat
  ];
}
