{config, pkgs, ...}:
{
  programs.bash.profileExtra =
    ''
      if uwsm check may-start; then
          exec uwsm start hyprland.desktop
      fi
    '';
  wayland.windowManager.hyprland = {
    enable = true;
    package = config.dep-inject.flake-inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    systemd.enable = false;
    settings = {
      "$mod" = "SUPER";
      bind =
        [
          "$mod, F, exec, uwsm app -- firefox.desktop"
          "$mod, Return, exec, uwsm app -- kitty.desktop"
          
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
  };
}
