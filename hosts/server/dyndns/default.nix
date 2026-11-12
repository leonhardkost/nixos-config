{
  config,
  pkgs,
  ...
}:
let
  pyenv = pkgs.python3.withPackages (ps: with ps; [ nc-dnsapi ]);
in
{
  users.groups.dyndns = { };
  users.users.dyndns = {
    isSystemUser = true;
    group = "dyndns";
    description = "DynDNS service user";
  };

  systemd.timers."dyndns" = {
    requires = [ "network-online.target" ];
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "5m";
      Unit = "dyndns.service";
    };
  };

  systemd.services."dyndns" = {
    serviceConfig = {
      Type = "oneshot";
      User = "dyndns";
      ExecStart = "${pyenv.interpreter} ${./dyndns.py}";
      EnvironmentFile = config.sops.secrets.dyndns.path;
    };
  };
}
