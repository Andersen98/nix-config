{flake-self,flake-inputs}:
{pkgs,...}:
let
  inherit (flake-inputs) plasma-manager nix-colors home-manager agenix;
  in
  {
    imports = [ home-manager.nixosModules.home-manager agenix.nixosModules.default ];

    home-manager.sharedModules = [
      plasma-manager.homeManagerModules.plasma-manager
      nix-colors.homeManagerModules.default 
    ];

    environment.systemPackages = [ agenix.packages.${pkgs.system}.default ];
  }
