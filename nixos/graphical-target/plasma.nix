{pkgs,...}:
{

  services.desktopManager.plasma6.enable = true;
 

  environment.systemPackages = with pkgs; [
    kdePackages.plasma-pa
  ];

}
