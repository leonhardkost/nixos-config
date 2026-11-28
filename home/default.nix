{
  lib,
  config,
  osConfig ? null,
  ...
}:
let
  mkDefaultSharedAttrs =
    base: defaults: lib.mapAttrs (_: v: lib.mkDefault v) (lib.filterAttrs (k: _: base ? ${k}) defaults);
in
{
  imports = [
    ../options.nix

    ./git.nix
    ./fish.nix
    ./firefox.nix
    ./nixvim.nix
    ./niri
    ./kitty.nix
    ./rofi
  ];

  home = {
    username = "leonhard";
    homeDirectory = "/home/leonhard";
  };

  xdg.enable = true;
  xdg.configFile."nixpkgs/config.nix".text = "{ allowUnfree = true; }";

  nix-leonhard = lib.mkIf (osConfig != null) (
    mkDefaultSharedAttrs config.nix-leonhard (osConfig.nix-leonhard or { })
  );

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "26.11";
}
