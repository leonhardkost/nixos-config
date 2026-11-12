{
  lib,
  ...
}:
{
  options.nix-leonhard = with lib.types; {
    graphical = lib.mkOption {
      type = bool;
      default = true;
      description = "Whether to enable GUI features and programs.";
    };
  };
}
