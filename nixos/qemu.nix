
{pkgs,...}:{
  virtualisation.spiceUSBRedirection.enable = true;
  environment.systemPackages = with pkgs; [
    quickemu
    qemu
      (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        qemu-system-x86_64 \
          -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
          "$@"
      '')
  ];
}
