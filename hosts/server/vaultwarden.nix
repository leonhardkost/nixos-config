{
  config,
  ...
}:
let
  domain = config.nix-leonhard.domain;
  vaultDomain = "bitwarden.${domain}";
in
{
  services.vaultwarden = {
    enable = true;
    domain = vaultDomain;
    environmentFile = config.sops.secrets.vaultwarden.path;
    config = {
      SIGNUPS_ALLOWED = false;

      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      ROCKET_LOG = "critical";
    };
  };

  security.acme.certs.${domain}.extraDomainNames = [
    vaultDomain
  ];

  services.nginx = {
    enable = true;

    virtualHosts.${vaultDomain} = {
      forceSSL = true;
      useACMEHost = config.nix-leonhard.domain;
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
        proxyWebsockets = true;
      };
    };
  };
}
