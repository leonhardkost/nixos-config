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
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.leonhard = ../home;
        }
      ];
    };
in
{
  desktop = mkNixosSystem [ ./desktop ];
  server = mkNixosSystem [
    ./server
    inputs.sops-nix.nixosModules.sops
  ];
}
