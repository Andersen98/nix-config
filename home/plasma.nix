
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
    #
    # Some high-level settings:
    #
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
      scripts.polonium.enable = true;
    };

    kscreenlocker = {
      lockOnResume = true;
      timeout = 10;
    };

    # Some low-level settings:
    #
    configFile = {
      baloofilerc."Basic Settings"."Indexing-Enabled" = false;
      kwinrc."org.kde.kdecoration2".ButtonsOnLeft = "SF";
      kwinrc.Desktops.Number = {
        value = 8;
        # Forces kde to not change this value (even through the settings app).
        immutable = true;
      };
      kscreenlockerrc = {
        Greeter.WallpaperPlugin = "org.kde.potd";
        # To use nested groups use / as a separator. In the below example,
        # Provider will be added to [Greeter][Wallpaper][org.kde.potd][General].
        "Greeter/Wallpaper/org.kde.potd/General".Provider = "bing";
      };
      "kwinrulesrc"."2fbccd80-eb63-4fa0-b6b0-5036f392dae0"."Description" = "Window settings for dolphin-emu renderer";
      "kwinrulesrc"."2fbccd80-eb63-4fa0-b6b0-5036f392dae0"."clientmachine" = "localhost";
      "kwinrulesrc"."2fbccd80-eb63-4fa0-b6b0-5036f392dae0"."desktops" = "71eaa85e-e76b-47fb-b2b7-67d067a067c0";
      "kwinrulesrc"."2fbccd80-eb63-4fa0-b6b0-5036f392dae0"."desktopsrule" = 2;
      "kwinrulesrc"."2fbccd80-eb63-4fa0-b6b0-5036f392dae0"."fpplevel" = 4;
      "kwinrulesrc"."2fbccd80-eb63-4fa0-b6b0-5036f392dae0"."fpplevelrule" = 2;
      "kwinrulesrc"."2fbccd80-eb63-4fa0-b6b0-5036f392dae0"."fsplevel" = 4;
      "kwinrulesrc"."2fbccd80-eb63-4fa0-b6b0-5036f392dae0"."fsplevelrule" = 2;
      "kwinrulesrc"."2fbccd80-eb63-4fa0-b6b0-5036f392dae0"."fullscreen" = true;
      "kwinrulesrc"."2fbccd80-eb63-4fa0-b6b0-5036f392dae0"."fullscreenrule" = 2;
      "kwinrulesrc"."2fbccd80-eb63-4fa0-b6b0-5036f392dae0"."layer" = "fullscreen";
      "kwinrulesrc"."2fbccd80-eb63-4fa0-b6b0-5036f392dae0"."layerrule" = 2;
      "kwinrulesrc"."2fbccd80-eb63-4fa0-b6b0-5036f392dae0"."title" = "^Dolphin \\[\\w+\\] \\w+ \\|.*$";
      "kwinrulesrc"."2fbccd80-eb63-4fa0-b6b0-5036f392dae0"."titlematch" = 3;
      "kwinrulesrc"."2fbccd80-eb63-4fa0-b6b0-5036f392dae0"."wmclass" = "dolphin-emu";
      "kwinrulesrc"."2fbccd80-eb63-4fa0-b6b0-5036f392dae0"."wmclassmatch" = 1;
      "kwinrulesrc"."4e1e6154-7bb7-499a-a88b-b521214a3595"."Description" = "Dolphin Emulator Launch Window";
      "kwinrulesrc"."4e1e6154-7bb7-499a-a88b-b521214a3595"."desktops" = "1b5e78fa-e983-4e42-98aa-2eb1cf52719b";
      "kwinrulesrc"."4e1e6154-7bb7-499a-a88b-b521214a3595"."desktopsrule" = 3;
      "kwinrulesrc"."4e1e6154-7bb7-499a-a88b-b521214a3595"."title" = "^Dolphin \\[\\w+\\] \\w+$";
      "kwinrulesrc"."4e1e6154-7bb7-499a-a88b-b521214a3595"."titlematch" = 3;
      "kwinrulesrc"."4e1e6154-7bb7-499a-a88b-b521214a3595"."wmclass" = "dolphin-emu";
      "kwinrulesrc"."4e1e6154-7bb7-499a-a88b-b521214a3595"."wmclassmatch" = 1;
      "kwinrulesrc"."General"."count" = 2;
      "kwinrulesrc"."General"."rules" = "2fbccd80-eb63-4fa0-b6b0-5036f392dae0,4e1e6154-7bb7-499a-a88b-b521214a3595";
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."Description" = "Window settings for dolphin-emu";
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."belowrule" = 3;
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."clientmachine" = "localhost";
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."desktops" = "71eaa85e-e76b-47fb-b2b7-67d067a067c0";
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."desktopsrule" = 3;
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."fpplevel" = 4;
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."fpplevelrule" = 2;
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."fullscreen" = true;
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."fullscreenrule" = 3;
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."layer" = "overlay";
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."layerrule" = 2;
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."noborder" = true;
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."noborderrule" = 3;
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."shaderule" = 3;
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."tearingrule" = 2;
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."types" = 1;
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."windowrole" = "renderer";
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."windowrolematch" = 1;
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."wmclass" = "dolphin-emu";
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."wmclasscomplete" = true;
      "kwinrulesrc"."a0f4dd90-7c6c-4af1-a9bf-4efc02ee4dc3"."wmclassmatch" = 1;
    };
  };
}
