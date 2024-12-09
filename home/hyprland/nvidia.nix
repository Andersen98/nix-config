{
  wayland.windowManager.hyprland.extraConfig = ''
    env = LIBVA_DRIVER_NAME,nvidia
    env = __GLX_VENDOR_LIBRARY_NAME,nvidia
    cursor {
        no_hardware_cursors = false
        allow_dumb_copy = true
    }
  '';

}
