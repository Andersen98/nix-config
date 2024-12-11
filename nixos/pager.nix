{pkgs,...}:
{
  environment.systemPackages = with pkgs; [
    moar
  ];
  environment.variables = {
    PAGER = "moar";
  };
}
