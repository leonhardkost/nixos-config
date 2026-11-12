{
  pkgs,
  inputs,
  ...
}:
let
  inherit (inputs.home-manager.lib) homeManagerConfiguration;

  extraSpecialArgs = { inherit inputs; };
in
{
  leonhard = homeManagerConfiguration {
    inherit pkgs extraSpecialArgs;
    modules = [
      ./base.nix
      ../home
      ../options.nix
      {
        nix-leonhard.graphical = false;
        nix-leonhard.neovim.enable = true;
        nix-leonhard.neovim.typst.enable = true;
      }
    ];
  };
}
