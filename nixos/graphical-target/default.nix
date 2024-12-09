{lib,...}:
{

  imports = [
    ./sway.nix
    ./hyprland.nix 
    ./plasma.nix
    ./uwsm.nix ];

           services.displayManager = {
              defaultSession = lib.mkForce null;
  };
            
}
