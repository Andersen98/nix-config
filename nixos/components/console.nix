{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    spleen
  ];

  console = {
    font = "${pkgs.spleen}/share/consolefonts/spleen-32x64.psfu";
  };
}
