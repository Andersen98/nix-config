{
  bluetooth = import ./bluetooth.nix;
  extra-hardware = import ./extra-hardware.nix;
  pipewire-pulse = import ./pipewire-pulse.nix;
  plasma6 = import ./plasma6.nix;
  system-programs = import ./system-programs.nix;
  fhs = import ./fhs.nix;
}
