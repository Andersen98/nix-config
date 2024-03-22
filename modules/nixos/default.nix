{
  bluetooth = import ./bluetooth.nix;
  extra-hardware = import ./extra-hardware.nix;
  pipewire-pulse = import ./pipewire-pulse.nix;
  plasma6 = import ./plasma6.nix;
  plasma5 = import ./plasma5.nix;
  system-programs = import ./system-programs.nix;
  fhs = import ./fhs.nix;
  helix = import ./helix.nix;
}
