{
  description = "Succoria's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix/release-24.11";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    stylix,
    ...
  }: {
    nixosConfigurations = {
      dungeon = let
        username = "succoria"; # another username for this machine
        specialArgs = {inherit username;};
      in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = "x86_64-linux";

          modules = [
            ./hosts/dungeon

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              # To stop getting annoying existing file errors
              # TODO: I HATE THIS. NEED TO MANUALLY DELETE /home/succoria/.gtkrc-2.0.backup
              home-manager.backupFileExtension = "backup";

              home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.users.${username} = import ./home/home.nix;
            }

            stylix.nixosModules.stylix
            {
              stylix.enable = true;
              stylix.image = ./homutan_1.jpg;
              stylix.polarity = "dark";
            }
          ];
        };
    };
  };
}
