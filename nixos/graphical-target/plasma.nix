{pkgs,...}:
{

  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
 

  environment.systemPackages = with pkgs; [
    kdePackages.plasma-pa
  ];

}
