{pkgs,lib, config,...}:
 
 let
   cfg = config.services.hyprpaper;
 in
 
 with lib; 
 {
   options = {
     services.hyprpaper= {
       enable = mkOption {
         default = false;
         type = with types; bool;
         description = ''
           Start hyprpaper
         '';
       };
     };
   };
 
   config = mkIf cfg.enable {

    systemd.services.hyprpaper = {
      after=[ ''wayland-session@hyprland\\x2duwsm.desktop.target'' ];
      before = ["wayland-session-shutdown.target" "shutdown.target" ''wayland-session-xdg-autostart@hyprland\\x2duwsm.desktop.target'' ];
      description = "Start hyprpaper for hyprland-uwsm  session.";
      wantedBy = [ ''wayland-session-xdg-autostart@hyprland\\x2duwsm.desktop.target'' ];
      serviceConfig = {
        Type = "simple";
        Restart= "on-failure";
        ExecStart = "{ path=${pkgs.uwsm}/bin/uwsm-app ; argv[]= -s b -t service -- ${pkgs.hyprpaper}/bin/hyprpaper }";
      };
    };
  };
}
 

