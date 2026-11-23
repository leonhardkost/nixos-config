{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.nix-leonhard.graphical.enable {
    home.packages = [
      (pkgs.stdenvNoCC.mkDerivation rec {
        pname = "nordzy-cursors-default";
        version = "2.4.0";

        src = pkgs.fetchzip {
          url = "https://github.com/guillaumeboehm/Nordzy-cursors/releases/download/v${version}/Nordzy-cursors.tar.gz";
          hash = "sha256-9fVkYSU9twZoTgeRE/XSDP4Q/tQ6Ar+NnJ7jCxV16lw=";
          stripRoot = false;
        };

        dontBuild = true;

        installPhase = ''
          runHook preInstall
          mkdir -p $out/share/icons
          cp -r Nordzy-cursors $out/share/icons
          runHook postInstall
        '';
      })
    ];

    xdg.configFile."niri/config.kdl".source = ./config.kdl;

    wayland.windowManager.niri = {
      enable = true;
    };
  };
}
