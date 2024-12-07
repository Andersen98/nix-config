{pkgs,lib, ...}:
lib.mkIf (pkgs.system == "x86_64-linux") {
  environment.systemPackages = with pkgs; [
    numen
  ];
  services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
  '';
  users.users.hannah = {
    extraGroups = [
      "input"
    ];
  };
}
