{
  environment.etcBackupExtension = ".bak";
  system.stateVersion = "23.11";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  time.timeZone = "America/New_York";
  home-manager = {
    config = ./home.nix;
    backupFileExtension = "hm-back";
    useGlobalPkgs = true;
  };
}
