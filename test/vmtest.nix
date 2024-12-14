{ nixos-generators }:

{modulesPath,lib,config,...}:
{
  imports = [
        (modulesPath + "/profiles/qemu-guest.nix")
    (modulesPath + "/virtualisation/qemu-vm.nix")
    nixos-generators.nixosModules.all-formats
  ];
  networking.hostName = "vmtest";

    fileSystems."/" = {
      device = "/dev/sdb2";
      fsType = "ext4";
      autoResize = true;
    };

  virtualisation = {
    memorySize = 32000;
  };
    boot = {
      growPartition = true;
      loader.timeout = 5;
      kernelParams = [
        "console=ttyS0"
        "boot.shell_on_fail"
      ];
    };

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
    virtualisation = {
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
