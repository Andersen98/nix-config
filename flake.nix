{
  description = "NixOS configuration";

  inputs = {
    # helix editor, use master branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable"; 
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
    abstractConfiguration = {
    extraNixosModules ? [ ],
    extraHomeManagerModules ? [ ]
    }: (nixpkgs.lib.nixosSystem) {
      system = "x86_64-linux";
      specialArgs = {inherit (self) inputs outputs;};
        modules = extraNixosModules ++ [ 
          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit inputs outputs extraHomeManagerModules;};
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.hannah = ./home;
          }

        ];
      };
  in
  {
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    
    nixosConfigurations = with outputs.nixosModules; {
      x570 = abstractConfiguration {
        extraNixosModules = [ ./hosts/x570 plasma5  ];
      };
      lenovo-x270 = abstractConfiguration {
        extraNixosModules = [ ./hosts/lenovo-x270 plasma5 ];
        extraHomeManagerModules = [ 
          outputs.homeManagerModules.texlive
        ];
      };
      lenovo-x270-sway = abstractConfiguration { 
        extraNixosModules = [ ./hosts/lenovo-x270 sway ];
      };
    };
  };
}
