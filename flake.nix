{
  description = "NixOS configuration";

  inputs = {
    # helix editor, use master branch
    helix.url = "github:helix-editor/helix/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    ...
  } @ inputs:
  let
    inherit (self) outputs;
  in
  {
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    
    nixosConfigurations = {
      x570 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/x570

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {inherit inputs outputs;};
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.hannah = import ./home;
          }

        ];
      };

      lenovo-x270 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/lenovo-x270

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {inherit inputs outputs;};
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.hannah = import ./home;
          }
          #nix os hardware
          nixos-hardware.nixosModules.lenovo-thinkpad-x270
        ];
      };
    };
  };
}
