{pkgs, lib, ...}:
{


  imports = [
    ./neovim
    ./bash.nix
    ./fish.nix
  ];
  
  # This config was copied and modified from the following
  # nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager
  home.username = lib.mkDefault "hannah";
  home.homeDirectory = lib.mkDefault "/home/hannah";
  home.file."config/cabal" = {
    source = ./cabal;
    recursive = true;
    executable = false;
  };


  home.packages = with pkgs; [
    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    # unbuffer nix-build |& nom
    # unbuffer nixos-rebuild |& nom
    nix-output-monitor
    expect
    #flake-utils-plus fup-repl
    fup-repl


    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    # devenv https://devenv.sh
    devenv
    neofetch

    # internet
    lynx

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    curl
    git
    gh
    ripgrep # recursively searches directories for a regex pattern
    fzf # A command-line fuzzy finder
    just # A a command runner

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # misc
    kittysay
    cowsay
    fortune
    lolcat
    file
    which
    tree
    gnused
    gnutar
    gawk
    gnupg


    # productivity
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];


  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = lib.mkDefault "25.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
