{
  description = "leonhard's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      sops-nix,
      nixvim,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      homeImports = [
        ./options.nix
        nixvim.homeModules.nixvim
        ./home-manager/base
      ];

      mkNixosConfig = name: modules: {
        "${name}" = nixpkgs.lib.nixosSystem {
          modules = modules ++ [
            ./nixos/base
            ./options.nix
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            {
              home-manager = {
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit inputs outputs; };
                users.leonhard.imports = homeImports ++ [
                  ./home-manager/leonhard
                ];
              };
            }
          ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      mkHomeConfig = name: modules: {
        "${name}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = modules ++ homeImports;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    in
    {
      nixosConfigurations =
        (mkNixosConfig "desktop" [ ./nixos/desktop ]) // (mkNixosConfig "server" [ ./nixos/server ]);

      homeConfigurations = mkHomeConfig "leonhard" [ ./home-manager/leonhard ];
    };
}
