{
  config,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./secrets
    ./dyndns
    ./gitea.nix
    ./vaultwarden.nix
  ];

  options.nix-leonhard.domain =
    with lib.types;
    lib.mkOption {
      type = str;
      default = "";
      description = "Domain of the device.";
    };

  nix-leonhard.graphical = false;

  users.users.leonhard = {
    initialPassword = "leonhard";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = config.nix-leonhard.publicKeys;
  };

  networking = {
    hostName = "server";
    firewall.enable = false;
    interfaces.eno1 = {
      ipv4.addresses = [
        {
          address = "192.168.178.210";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = {
      address = "192.168.178.1";
      interface = "eno1";
    };
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };

  services.openssh = {
    enable = true;
    ports = [ 5432 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "admin@${config.nix-leonhard.domain}";
    defaults.webroot = "/var/lib/acme/acme-challenge/";
    certs.${config.nix-leonhard.domain} = {
      group = config.services.nginx.group;
    };
  };

  services.nginx = {
    enable = true;

    virtualHosts.${config.nix-leonhard.domain} = {
      forceSSL = true;
      useACMEHost = config.nix-leonhard.domain;
      locations."/.well-known/".root = config.security.acme.defaults.webroot;
    };
  };
}
