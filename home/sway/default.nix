{config, lib, ...}:
{
  xdg.configFile.uwsm-sway-env ={
    source = ./env-sway-uwsm;
    target = "uwsm/env-sway-uwsm";
  };

  home.file.".config/sway/config".text = (import ./config.nix) {inherit config; inherit lib;};
  home.file.".config/sway/config.d" = {
    source = ./config.d;
    recursive = true;
    executable = false;
  };
}
