{
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="8087", MODE="0666"
    SUBSYSTEM=="usb_device", ATTRS{idVendor}=="8087", MODE="0666"
  '';
}
