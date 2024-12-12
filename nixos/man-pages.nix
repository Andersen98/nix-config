{pkgs,...}:{
  environment.systemPackages = with pkgs; [
    qman
    man-pages 
    man-pages-posix
  ];
  documentation = {
    dev.enable = true;
    man = {
      generateCaches = true;
      man-db.enable = false;
      mandoc.enable = true;
    };
  };
}
