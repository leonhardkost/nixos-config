{
  config,
  ...
}:
let
  domain = config.kekleo.domain;
  gitDomain = "git.${domain}";
in
{
  services.gitea = {
    enable = true;
    settings.server.ROOT_URL = "https://${gitDomain}";
    settings.server.SSH_PORT = builtins.elemAt config.services.openssh.ports 0;
    settings.service.DISABLE_REGISTRATION = true;
    settings.log.LEVEL = "Critical";
  };

  security.acme.certs.${domain}.extraDomainNames = [
    gitDomain
  ];

  services.nginx = {
    enable = true;

    virtualHosts.${gitDomain} = {
      forceSSL = true;
      useACMEHost = config.kekleo.domain;
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.gitea.settings.server.HTTP_PORT}";
        proxyWebsockets = true;
      };
    };
  };
}
