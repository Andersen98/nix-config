{pkgs,...}:
{ 
  environment.systemPackages = with pkgs; [
    fuzzel
    libnotify
  ];
  programs.uwsm = {
    enable = true;
  };
}
