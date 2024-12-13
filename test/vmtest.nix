{ nixos-generators }:

{modulesPath,lib,config,...}:
{
  imports = [
        (modulesPath + "/profiles/qemu-guest.nix")
    (modulesPath + "/virtualisation/qemu-vm.nix")
    nixos-generators.nixosModules.all-formats
  ];
  systemd.services.hyprpaper.enable = true;
  networking.hostName = "vmtest";


     security.sudo = {
     enable = true;
     wheelNeedsPassword = false;
   };
 
   # Enable your new service!
   services =  {
     hyprpaper = {
       enable = true;
     };
   };


    services.displayManager = {
      autoLogin.user = "fake";
      autoLogin.enable = true;
    };

    system.stateVersion = "24.05";


  
    # You need to configure a root filesytem
   fileSystems."/".label = "vmdisk";
    virtualisation = {
    diskSize = 40960;
    forwardPorts = [
          {
            from = "host";
            host.port = 2222;
            guest.port = 22;
          }
        ];
    };
users.groups.fake = {};
    users.users.fake = {
      createHome = true;
      isNormalUser = true;
      password = "fake";
      group = "fake";
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "video" # the below i got off github/akirak/homelab/blob/master/machines/li/default.nix#L85
      "audio"
      "disk"
      "networkmanager"
      "systemd-journal"
    ];
    
    };

}
