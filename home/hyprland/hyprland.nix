{config, pkgs, ...}:
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
          "$mod, F, exec, uwsm app -- firefox.desktop"
          "$mod, Return, exec, uwsm app -- kitty.desktop"
          "$mod, S, exec, uwsm app -s a -- firefox.desktop:new-window https://search.nixos.org/packages?channel=unstablesort=relevance&type=packages"
          "$mod, E, exec, uwsm app -s a -- kitty-open.desktop ~/nix-config"
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
      exec-once = uwsm app -s b -t service hyprpaper
      '';
  };
}
