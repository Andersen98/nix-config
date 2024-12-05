{ config, lib, pkgs,  ... }:
{
  #nixGL.packages = config.dep-inject.flake-inputs.nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  nixGL.offloadWrapper = "nvidiaPrime";
  nixGL.installScripts = [ "mesa" "nvidiaPrime" ];

  programs.mpv = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.mpv;
  };

  home.packages = [
    #(config.lib.nixGL.wrapOffload pkgs.freecad)
    #(config.lib.nixGL.wrappers.nvidiaPrime pkgs.xonotic)
    (config.lib.nixGL.wrap pkgs.dolphin-emu)
    (config.lib.nixGL.wrap pkgs.blender)
  ];
}

