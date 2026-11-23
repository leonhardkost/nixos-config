{
  description = "leonhard's nix config";

  inputs = {
    systems.url = "github:nix-systems/default";

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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs =
    {
      self,
      systems,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs (import systems);
      pkgsFor =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

    in
    {
      nixosConfigurations = import ./hosts { inherit self inputs; };

      # i. e. homeConfigurations.leonhard@x86_64-linux etc.
      homeConfigurations = builtins.listToAttrs (
        map (system: {
          name = "leonhard@${system}";
          value = import ./standalone {
            pkgs = pkgsFor system;
            inherit self inputs;
          };
        }) (import systems)
      );

      packages = forAllSystems (
        system:
        import ./pkgs {
          pkgs = pkgsFor system;
          inherit inputs;
        }
      );
    };
}
