{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "ddeb28a7b6a1f0ec6dae40c636e5ca4908ad160a";
          sha256 = "0c5i7sdrsp0q3vbziqzdyqn4fmp235ax4mn4zslrswvn8g3fvdyh";
        };
      }
    ];
    shellAbbrs = {
      nrs = "nixos-rebuild switch";
    };
    shellAliases = {
      g = "git";
      "..." = "cd ../../";
    };
    functions = {
      fish_user_key_bindings = {
        body = ''
          bind \cl forward-char
          bind \ch backward-char
          bind \cj down-or-search
          bind \ck up-or-search
          bind \cw forward-word
          bind \cb backward-word
        '';
      };
      develope = {
        wraps = "nix develop";
        body = "env ANY_NIX_SHELL_PKGS=(basename (pwd))\"#\"(git describe --tags --dirty) (type -P nix) develop --command fish";
        description = "Wrap nix develop to run with fish";
      };
      "todays-playground" = {
        description = "Make a playground directory and cd to it";
        body = ''
          set -f today (date +%B-%d-%Y | tr '[:upper:]' '[:lower:]')
          if test -d ~/playground/$today
              cd ~/playground/$today
          else
              mkdir -p ~/playground/$today
              cd  ~/playground/$today
          end
        '';
      };
    };
  };
}
