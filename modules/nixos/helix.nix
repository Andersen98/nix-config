{ pkgs, inputs, ...}:

{
  environment.systemPackages = with pkgs; [ 
  inputs.helix.packages."${pkgs.system}".helix
  ];
}
