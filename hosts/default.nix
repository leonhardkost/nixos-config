{
  self,
  inputs,
  ...
}:
let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  specialArgs = { inherit inputs self; };

  mkNixosSystem =
    modules:
    nixosSystem {
      inherit specialArgs;
      modules = modules ++ [
        ../system
        ../options.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.leonhard = ../home/default.nix;
        }
      ];
    };
in
{
  desktop = mkNixosSystem [ ./desktop ];
  server = mkNixosSystem [ ./server ];
}
