{pkgs,...}:
{ 
  services.displayManager.environment = {
    UWSM_USE_SESSION_SLICE="true";
  };
  programs.fish.loginShellInit = ''
    if uwsm check may-start && uwsm select;
      	exec systemd-cat -t uwsm_start uwsm start default
    end
    '';
  programs.bash.loginShellInit = ''
    if uwsm check may-start && uwsm select; then
      	exec systemd-cat -t uwsm_start uwsm start default
    fi
    '';
  programs.zsh.loginShellInit = ''
    if uwsm check may-start && uwsm select; then
      	exec systemd-cat -t uwsm_start uwsm start default
    fi
    '';
  environment.systemPackages = with pkgs; [
    newt
    libnotify
  ];
  programs.uwsm = {
    enable = true;
  };
}
