{lib, pkgs, ...}:
{


  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      "$mod" = "SUPER";
      general = {
        allow_tearing = true;
      };
      windowrulev2 = [ "immediate, class:^(dolphin-emu)$" ];
      misc = {
        vrr = 2;
      };
      bind =
        [
          # Screenshot a window
          "$mod, PRINT, exec, uwsm-app -s a hyprshot -- -m window"
          ", PRINT, exec, uwsm-app -s a hyprshot -- -m output"
          "SUPER_SHIFT, PRINT, exec, uwsm-app -s a hyprshot -- -m region"


          # launch apps
          "$mod, F, exec, uwsm-app -s a -- firefox.desktop"
          "$mod, Return, exec, uwsm-app -s a -- ${pkgs.kitty}/bin/kitty"
          "$mod, S, exec, uwsm-app -s a -- firefox.desktop:new-window https://search.nixos.org/packages?channel=unstablesort=relevance&type=packages"
          "$mod, E, exec, uwsm-app -s a -- ${pkgs.kitty}/bin/kitty --directory ~/nix-config"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (i:
              let ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );

    };
    extraConfig = ''
      exec-once = uwsm-app -s b hyprpaper
      bind = $mod, R, submap, resize
      submap =  resize
      binde = , L, resizeactive, 20 0
      binde = , H, resizeactive, -20 0
      binde = , K, resizeactive, 0 20
      binde = , J, resizeactive, 0 -20
      bind = , escape, submap, reset
      '';
  };
}
