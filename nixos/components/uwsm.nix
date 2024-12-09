{pkgs,...}:
{ 
  systemd.defaultUnit = "graphical.target";
  environment.variables = {
    UWSM_USE_SESSION_SLICE="true";
  };
  environment.systemPackages = with pkgs; [
    fuzzel
    libnotify
  ];
  programs.uwsm = {
    enable = true;
  };
}
