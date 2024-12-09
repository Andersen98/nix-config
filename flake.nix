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
      url = "github:t184256/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
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
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    # optional, not necessary for the module
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    # optionally choose not to download darwin deps (saves some resources on Linux)
    agenix.inputs.darwin.follows = "";
    hyprland.url = "github:hyprwm/Hyprland";
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
      nixgl,
      agenix,
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
          nixgl.overlay
        ]; 
        
        hostDefaults.modules = [
          home-manager.nixosModules.home-manager
          depInject 
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

        hosts.x570-hyprland-c.modules = [
          ./hosts/x570
          ./nixos/hyprland.nix
          ./nixos/components
          { home-manager.users.hannah = {
              imports = [ ./home/c.nix ./home/hyprland ./home/hyprland/nvidia.nix ];
            };
          }
          agenix.nixosModules.default
          { environment.systemPackages = [ agenix.packages.x86_64-linux.default ]; }
        ];
        hosts.x570-sway-c.modules = [
          ./hosts/x570
          ./nixos/sway.nix
          ./nixos/components
          { home-manager.users.hannah = {
              imports = [ ./home/c.nix ./home/sway ];
            };
          }
          agenix.nixosModules.default
          { environment.systemPackages = [ agenix.packages.x86_64-linux.default ]; }
        ];
        hosts.x570-plasma-c.modules = [
          ./hosts/x570
          ./nixos/plasma.nix
          ./nixos/components
          { home-manager.users.hannah = {
              imports = [ ./home/c.nix ./home/plasma ];
            };
          }
          agenix.nixosModules.default
          { environment.systemPackages = [ agenix.packages.x86_64-linux.default ]; }
        ];

        hosts.lenovo-x270-plasma-c.modules = [
          ./hosts/lenovo-x270
          ./nixos/plasma.nix
          ./nixos/components
          { home-manager.users.hannah = {
              imports = [ ./home/c.nix ./home/plasma ];
            };
          }
          agenix.nixosModules.default
          { environment.systemPackages = [ agenix.packages.x86_64-linux.default ]; }
        ];

        hosts.lenovo-x270-sway-c.modules = [
          ./hosts/lenovo-x270
          ./nixos/sway.nix
          ./nixos/components
          { home-manager.users.hannah = {
              imports = [ ./home/c.nix ./home/sway ];
            };
          }
          agenix.nixosModules.default
          { environment.systemPackages = [ agenix.packages.x86_64-linux.default ]; }
        ];
        
        
        hosts.lenovo-x270-hyprland-c.modules = [
          ./hosts/lenovo-x270
          ./nixos/hyprland.nix
          ./nixos/components
          { home-manager.users.hannah = {
              imports = [ ./home/c.nix ./home/hyprland ];
            };
          }
          agenix.nixosModules.default
          { environment.systemPackages = [ agenix.packages.x86_64-linux.default ]; }
        ];
        overlays = import ./overlays;
        outputsBuilder = (channels: {
          packages.nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
            modules = [
              depInject
              {
                home-manager = {
                  config = ./home;
                  backupFileExtension = "hm-back";
                  useGlobalPkgs = true;
                  sharedModules = [
                    nix-colors.homeManagerModules.default 
                    depInject
                  ];
                };
              }
              ./nix-on-droid
            ];
            pkgs = import nixpkgs {
              system = "aarch64-linux";
              overlays = [
                nix-on-droid.overlays.default
                neorg-overlay.overlays.default
                utils.overlay
              ];
            };
            home-manager-path = home-manager.outPath;
        };
      });
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
