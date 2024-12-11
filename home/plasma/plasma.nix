{pkgs,...}:{

  home.packages = with pkgs; [
    papirus-icon-theme
  ];
  home.file.".local/share/icons/Papirus" = {
    source = "${pkgs.papirus-icon-theme}/share/icons/Papirus";
    force = true;
  };

  programs.plasma = {
    enable = true;
    overrideConfig = true;
    immutableByDefault = true;
    shortcuts = {
      "kitty.desktop" = {
        "_launch" = "Meta+Return";
      };
      "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = [ ];
      "KDE Keyboard Layout Switcher"."Switch to Last-Used Keyboard Layout" = [ ];
      "kaccess"."Toggle Screen Reader On and Off" = [ ];
      "ksmserver"."Lock Session" = [ ];
      "ksmserver"."Log Out" = [ ];
      "ksmserver"."Log Out Without Confirmation" = [ ];
      "ksmserver"."LogOut" = [ ];
      "ksmserver"."Reboot" = [ ];
      "ksmserver"."Reboot Without Confirmation" = [ ];
      "ksmserver"."Shut Down" = [ ];
      "plasmashell"."activate application launcher" = "Meta+D";
      "plasmashell"."activate task manager entry 10" = [ ];
      "plasmashell"."activate task manager entry 1" = [ ];
      "plasmashell"."activate task manager entry 2" = [ ];
      "plasmashell"."activate task manager entry 3" = [ ];
      "plasmashell"."activate task manager entry 4" = [ ];
      "plasmashell"."activate task manager entry 5" = [ ];
      "plasmashell"."activate task manager entry 6" = [ ];
      "plasmashell"."activate task manager entry 7" = [ ];
      "plasmashell"."activate task manager entry 8" = [ ];
      "plasmashell"."activate task manager entry 9" = [ ];
      "plasmashell"."clear-history" = [ ];
      "plasmashell"."clipboard_action" = "Meta+Ctrl+X";
      "plasmashell"."cycle-panels" = "Meta+Alt+P";
      "plasmashell"."cycleNextAction" = [ ];
      "plasmashell"."cyclePrevAction" = [ ];
      "plasmashell"."manage activities" = [ ]; 
      "plasmashell"."next activity" = [ ];
      "plasmashell"."previous activity" = [ ];
      "plasmashell"."repeat_action" = [ ];
      "plasmashell"."show dashboard" = "Meta+`";
      "plasmashell"."show-barcode" = [ ];
      "plasmashell"."show-on-mouse-pos" = [ ];
      "plasmashell"."stop current activity" = [ ];
      "plasmashell"."switch to next activity" = [ ];
      "plasmashell"."switch to previous activity" = [ ];
      "plasmashell"."toggle do not disturb" = [ ];


      "kwin"."Activate Window Demanding Attention" = [ ];
      "kwin"."Cycle Overview" = [ ];
      "kwin"."Cycle Overview Opposite" = [ ];
      "kwin"."Decrease Opacity" = [ ];
      "kwin"."Edit Tiles" = "Meta+Shift+T";
      "kwin"."Expose" = "Ctrl+F9";
      "kwin"."ExposeAll" = [ ];
      "kwin"."ExposeClass" = [ ];
      "kwin"."ExposeClassCurrentDesktop" = [ ];
      "kwin"."Grid View" = [ ];
      "kwin"."Increase Opacity" = [ ];
      "kwin"."Kill Window" = "Meta+Q"; 
      "kwin"."Move Tablet to Next Output" = [ ];
      "kwin"."MoveMouseToCenter" = [ ];
      "kwin"."MoveMouseToFocus" = [ ];
      "kwin"."MoveZoomDown" = [ ];
      "kwin"."MoveZoomLeft" = [ ];
      "kwin"."MoveZoomRight" = [ ];
      "kwin"."MoveZoomUp" = [ ];
      "kwin"."Overview" = [ ];


      "kwin"."PoloniumCycleEngine" = "Meta+|,none,Polonium: Cycle Engine";
      "kwin"."PoloniumFocusAbove" = "Meta+K,none,Polonium: Focus Above";
      "kwin"."PoloniumFocusBelow" = "Meta+J,none,Polonium: Focus Below";
      "kwin"."PoloniumFocusLeft" = "Meta+H,none,Polonium: Focus Left";
      "kwin"."PoloniumFocusRight" = "Meta+L,none,Polonium: Focus Right";
      "kwin"."PoloniumInsertAbove" = "Meta+Shift+K,none,Polonium: Insert Above";
      "kwin"."PoloniumInsertBelow" = "Meta+Shift+J,none,Polonium: Insert Below";
      "kwin"."PoloniumInsertLeft" = "Meta+Shift+H,none,Polonium: Insert Left";
      "kwin"."PoloniumInsertRight" = "Meta+Shift+L,none,Polonium: Insert Right";
      "kwin"."PoloniumOpenSettings" = "Meta+Ctrl+Shift+C,none,Polonium: Open Settings Dialog";
       
      "kwin"."PoloniumResizeAbove" = "Meta+Ctrl+K,none,Polonium: Resize Above";
      "kwin"."PoloniumResizeBelow" = "Meta+Ctrl+J,none,Polonium: Resize Below";
      "kwin"."PoloniumResizeLeft" = "Meta+Ctrl+H,none,Polonium: Resize Left";
      "kwin"."PoloniumResizeRight" = "Meta+Ctrl+L,none,Polonium: Resize Right";
      "kwin"."PoloniumRetileWindow" = "Meta+Shift+Space,none,Polonium: Retile Window";
      "kwin"."PoloniumSwitchBTree" = "Meta+Q,none,Polonium: Use Binary Tree Engine";
      "kwin"."PoloniumSwitchHalf" = "Meta+W,none,Polonium: Use Half Engine";
      "kwin"."PoloniumSwitchKwin" = "Meta+E,none,Polonium: Use KWin Engine";
      "kwin"."PoloniumSwitchMonocle" = "Meta+R,none,Polonium: Use Monocle Engine";
      "kwin"."PoloniumSwitchThreeColumn" = "Meta+T,none,Polonium: Use Three Column Engine";

    };

    krunner = {
      historyBehavior = "enableAutoComplete";
      position = "center";
    };


    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 32;
      };
      iconTheme = "Papirus";
      wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/SafeLanding/contents/images/5120x2880.jpg";
    };

    fonts = {
      general = {
        family = "JetBrains Mono";
        pointSize = 12;
      };
    };

    panels = [
      # Windows-like panel at the bottom
      {
        location = "top";
        widgets = [
          {
            kickoff = {
              sortAlphabetically = true;
              icon = "nix-snowflake-white";
            };
          }
          # Adding configuration to the widgets can also for example be used to
          # pin apps to the task-manager, which this example illustrates by
          # pinning dolphin and konsole to the task-manager by default with widget-specific options.
          {
            iconTasks = {
              launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:kitty.desktop"
              ];
            };
          }
          "org.kde.plasma.marginsseparator"
          {
            systemTray.items = {
              # We explicitly show bluetooth and battery
              shown = [
                "org.kde.plasma.battery"
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.volume"
              ];
            };
          }
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.showdesktop"
        ];
      }
    ];

    powerdevil = {
      AC = {
        powerButtonAction = "lockScreen";
        autoSuspend = {
          action = "shutDown";
          idleTimeout = 1000;
        };
        turnOffDisplay = {
          idleTimeout = 1000;
          idleTimeoutWhenLocked = "immediately";
        };
      };
      battery = {
        powerButtonAction = "sleep";
        whenSleepingEnter = "standbyThenHibernate";
      };
      lowBattery = {
        whenLaptopLidClosed = "hibernate";
      };
    };

    kwin = {
      titlebarButtons.left = [
        "on-all-desktops"
        "keep-above-windows"
      ];
      scripts.polonium = {
        enable = true;
        settings.enableDebug = true;
        settings.borderVisibility = "noBorderAll";

      };

    };

    kscreenlocker = {
      appearance.wallpaperPictureOfTheDay.provider = "simonstalenhag";
      lockOnResume = true;
      passwordRequiredDelay = 60;
      timeout = 120;
    };

# Some low-level settings:
    #
    configFile = {
      baloofilerc."Basic Settings"."Indexing-Enabled" = false;
      kwinrc.Desktops.Number = {
        value = 10;
        # Forces kde to not change this value (even through the settings app).
        immutable = true;
      };
      kscreenlockerrc = {
        Greeter.WallpaperPlugin = "org.kde.potd";
      };
    };
  };
}
