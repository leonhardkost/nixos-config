{
  imports = [
    ./hardware-configuration.nix
  ];

  nix-leonhard.graphical.enable = true;
  nix-leonhard.neovim.enable = true;

  users.users = {
    leonhard = {
      initialPassword = "leonhard";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

  networking.hostName = "desktop";
}
