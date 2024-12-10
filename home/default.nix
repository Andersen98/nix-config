{
  imports = [ ./a.nix ];

  xdg.configFile.uwsm = {
    source = ./uwsm;
    recursive = true;
  };

}
