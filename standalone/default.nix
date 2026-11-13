{
  pkgs,
  self,
  inputs,
  ...
}:
let
  inherit (inputs.home-manager.lib) homeManagerConfiguration;

  extraSpecialArgs = { inherit self inputs; };
in
homeManagerConfiguration {
  inherit pkgs extraSpecialArgs;
  modules = [
    ./base.nix
    ../home
    {
      nix-leonhard.neovim.enable = true;
    }
  ];
}
