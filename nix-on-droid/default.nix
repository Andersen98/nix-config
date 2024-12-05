{pkgs, ...}:
{
  environment.etcBackupExtension = ".bak";
  system.stateVersion = "24.05";

  environment.packages = with pkgs; [
    openssh
  ];
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  time.timeZone = "America/New_York";
}
