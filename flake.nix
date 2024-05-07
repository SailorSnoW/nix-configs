{
  description = "SnoW Darwin system flake";

  inputs = {
    # Theming
    catppuccin.url = "github:catppuccin/nix";

    # Darwin packages sources
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    home-manager-darwin.url = "github:nix-community/home-manager";

    # NixOS packages sources
    nixpkgs-nixos.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager-nixos.url = "github:nix-community/home-manager";

    # Channels
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";
    home-manager-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";
    nixpkgs-nixos.follows = "nixos-unstable";
    home-manager-nixos.inputs.nixpkgs.follows = "nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs-darwin, 
    home-manager-darwin, 
    nix-darwin, 
    nixos-unstable, 
    home-manager-nixos,
    catppuccin,
    ... 
  } @ inputs: let
    inherit (self) outputs;
  in {
    darwinConfigurations = {
      darwin-snowos = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/darwin-snowos/configuration.nix
          home-manager-darwin.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.snow = {
              imports = [
                ./home/snow/home.nix
                catppuccin.homeManagerModules.catppuccin
              ];
            };
            home-manager.backupFileExtension = "backup";

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };

    nixosConfigurations = {
      nixos-snowos = nixos-unstable.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/nixos-snowos/configuration.nix
          catppuccin.nixosModules.catppuccin
          home-manager-nixos.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.snow = {
              imports = [
                ./home/nixos-snow/home.nix
                catppuccin.homeManagerModules.catppuccin
              ];
            };
            home-manager.backupFileExtension = "backup";

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
  };
}
