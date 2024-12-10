{pkgs,...}:
{ 
  environment.variables = {
    UWSM_USE_SESSION_SLICE="true";
  };
  environment.systemPackages = with pkgs; [
    newt
    tofi
    libnotify
  ];
  programs.uwsm = {
    enable = true;
  };
}
