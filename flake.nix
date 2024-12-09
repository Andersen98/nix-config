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
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
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
      hyprland,
      nix-on-droid,
      plasma-manager,
      neovim-nightly-overlay,
      neorg-overlay,
      nix-colors,
      nixgl,
      agenix,
      nixpkgs-stable,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
      inherit (lib.modules) importApply;
    in
      utils.lib.mkFlake {
        inherit self inputs;
        channelsConfig.allowUnfree = true;
        channels.unstable.input = nixpkgs;
        channels.stable.input = nixpkgs-stable;


        sharedOverlays =  [
          self.overlays.additions
          self.overlays.modifications
          neovim-nightly-overlay.overlays.default
          neorg-overlay.overlays.default
          utils.overlay
          nixgl.overlay
        ]; 
       
        hostDefaults.channelName = "unstable";

        hostDefaults.modules = [
          (importApply ./nixos/flake-inputs.nix  { flake-inputs = inputs;} )
          ./nixos
          { home-manager.backupFileExtension = "hm-bak";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.hannah.imports = [
              ./home/e.nix 
              (importApply ./home/flake-inputs.nix  { flake-inputs = inputs;} )
              { colorScheme =  nix-colors.colorSchemes.pandora; }
            ]; 
          }
          (
            let 
              defaultDownloadBufferSize = 67108864;
            in 
            { 
              nix.settings = {
              experimental-features = "nix-command flakes";
              download-buffer-size = 10*defaultDownloadBufferSize;
              trusted-users = [ "hannah" ];
              };
            }
          )
        ];

        hosts.lenovo-x270.modules = [
          ./hosts/lenovo-x270
        ];

        hosts.x570.modules = [
          ./hosts/x570
        ];

        overlays = import ./overlays;
        outputsBuilder = (channels: {
          packages.nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
            modules = [
              {
                home-manager = {
                  config = ./home;
                  backupFileExtension = "hm-back";
                  useGlobalPkgs = true;
                  sharedModules = [
                    nix-colors.homeManagerModules.default 
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
    };
}
