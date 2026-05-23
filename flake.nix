{
  description = "My Multi-Device Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    homeConfigurations = {

      # Device 1: Your main Linux Desktop
      "evermore" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./home.nix          # Shared configuration
          ./hosts/laptop.nix # Laptop-specific configuration
        ];
      };
    };
  };
}
