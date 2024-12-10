{pkgs,...}:
{
  programs.tofi = {

    enable = true;
    settings = {
    terminal = "uwsm-app --";

    font = builtins.toPath "${pkgs.rakkas-font}/share/fonts/opentype/Rakkas/Rakkas-Regular.otf";
    font-size = 64;
    hint-font = false;

    outline-width = 0;
    border-width = 0;
    padding-left = "4%";
    padding-top = "2%";
    padding-right = 0;
    padding-bottom = 0;

    background-color = "#FFFEFA";
    text-color = "#272727";
    selection-color = "#272727";

    width = "100%";
    height = "100%";

    hide-cursor = true;
    };
  };
}
