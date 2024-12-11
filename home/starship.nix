{
  config,
  lib,
  ...
}:
{
  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    # custom settings
    settings = {
      format = lib.concatStrings [
        "[](#33658A)"
        "$username"
        "[](bg:#86BBD8 fg:#33658A)"
        "$directory"
        "[](fg:#86BBD8 bg:#FCA17D)"
        "$git_branch"
        "$git_status"
        "[](fg:#FCA17D bg:#86BBD8)"
        "$nix_shell"
        "[](fg:#86BBD8 bg:#06969A)"
        "$line_break"
        "[🙜 🩷🙟   󱍢 ](#${config.colorScheme.palette.base05})"
      ];
      username = {
        show_always = true;
        style_user = "bg:#33658A";
        style_root = "bg:#33658A";
        format = "[♥ $user ♥]($style)";
        disabled = false;
      };
      directory = {
        style = "bg:#86BBD8";
        format = "[ $path ]($style)";
        truncation_length = 2;
        truncation_symbol = "…/";
      };
      directory.substitutions = {
        "Documents" = "󰈙 ";
        "Downloads" = " ";
        "Music" = " ";
        "Pictures" = " ";
        "~" = " ";
      };
      nix_shell = {
        style = "bg:#86BBD8";
      };
      git_branch = {
        style = "bg:#FCA17D";
        symbol = "";
        format = "[$symbol $branch]($style)";
      };
      git_status = {
        style = "bg:#FCA17D";
        format = "[$symbol $all_status$ahead_behind ]($style)";
      };
    };
  };
}
