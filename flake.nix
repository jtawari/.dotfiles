{
  # Description
  description = "NixOS Configuration";

  # Inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Outputs
  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    # System architecture
    system = "x86_64-linux";

    # User account name
    user = "me";
  in {
    # Formatter
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    # Set NixOS configuration for the host
    nixosConfigurations.home = nixpkgs.lib.nixosSystem {
      inherit system;

      # Special args to pass to the modules
      specialArgs = {inherit inputs system user;};

      # Modules
      modules = [
        ./system/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit inputs system user;};

            # Set Home Manager configuration for the user
            users.${user} = import ./user/home.nix;
          };
        }
      ];
    };
  };
}
