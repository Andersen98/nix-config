{
  description = "Hannah's NixOS config";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://vulkan-haskell.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "vulkan-haskell.cachix.org-1:byNXKoGxhPa/IOR+pwNhV2nHV67ML8sXsWPfRIqzNUU="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-on-droid = {
      url = "github:t184256/nix-on-droid/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixfmt.url = "github:NixOS/nixfmt";
    nix-colors.url = "github:misterio77/nix-colors";
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      utils,
      nix-on-droid,
      plasma-manager,
      neovim-nightly-overlay,
      neorg-overlay,
      nix-colors,
      ...
    }@inputs:
    let
      depInject = { pkgs, lib, ... }: {
        options.dep-inject = lib.mkOption {
          type = with lib.types; attrsOf unspecified;
          default = { };
        };
        config.dep-inject = {
          flake-inputs = inputs;
        };
      };
    in
      utils.lib.mkFlake {
        inherit self inputs;
        channelsConfig.allowUnfree = true;
        channels.unstable.input = nixpkgs;

        sharedOverlays =  [
          self.overlays.additions
          self.overlays.modifications
          neovim-nightly-overlay.overlays.default
          neorg-overlay.overlays.default
          utils.overlay
        ]; 
        
        hostDefaults.modules = [
          home-manager.nixosModules.home-manager
          depInject 
          ./nixos/components/plymouth.nix
          { nix.settings.trusted-users = [ "hannah" ]; }
          {
            home-manager.backupFileExtension = "hm-bak";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [
              plasma-manager.homeManagerModules.plasma-manager
              nix-colors.homeManagerModules.default 
              depInject
            ];
          }
        ];
        hostDefaults.channelName = "unstable";
        hosts.x570-plasma-e.modules = [
          ./hosts/x570
          ./nixos/plasma.nix
          { home-manager.users.hannah = import ./home/e.nix; }
        ];

        hosts.x570-plasma5-d.modules = [
          ./hosts/x570
          ./nixos/plasma5.nix
          { home-manager.users.hannah = import ./home/d.nix; }
        ];
        hosts.lenovo-x270-sway-e.modules = [
          ./hosts/lenovo-x270
          ./nixos/sway.nix
          { home-manager.users.hannah = import ./home/e.nix; }
        ];
        hosts.lenovo-x270-plasma-e.modules = [
          ./hosts/lenovo-x270
          ./nixos/plasma.nix
          { home-manager.users.hannah = import ./home/e.nix; }
        ];
        hosts.pink-pc.modules = [
          ./hosts/pink-pc
          ./nixos/sway.nix
          { home-manager.users.hannah = import ./home/e.nix; }
        ];
        hosts.nix-on-droid.modules = [
          { home-manager-path = home-manager.outPath; }
          ./nix-on-droid
        ];
        hosts.nix-on-droid.output = "nixOnDroidConfigurations";
        hosts.nix-on-droid.builder = nix-on-droid.lib.nixOnDroidConfiguration;
        hosts.nix-on-droid.system = "aarch64-linux";
        
        overlays = import ./overlays;
      } // utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        homeConfigurations = {
          a = home-manager.lib.homeManagerConfiguration {
            modules = [
              ./home/a.nix
            ];
            inherit pkgs;
          };
          b = home-manager.lib.homeManagerConfiguration {
            modules = [
              ./home/b.nix
            ];
            inherit pkgs;
          };
          c = home-manager.lib.homeManagerConfiguration {
            modules = [
              ./home/c.nix
            ];
            inherit pkgs;
          };
          d = home-manager.lib.homeManagerConfiguration {
            modules = [
              ./home/d.nix
            ];
            inherit pkgs;
          };
          e = home-manager.lib.homeManagerConfiguration {
            modules = [
              ./home/e.nix
            ];
            inherit pkgs;
          };
        };
        # Formatter for your nix files, available through 'nix fmt'
        formatter = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
      });
}
