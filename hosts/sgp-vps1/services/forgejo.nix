{ lib, pkgs, config, ... }:
let
    cfg = config.services.forgejo;
    srv = cfg.settings.server;
    anubis = "127.0.0.1:8923";
in
{
    services.caddy = {
        enable = true;
        virtualHosts.${cfg.settings.server.DOMAIN}.extraConfig = ''
            reverse_proxy ${anubis}
        '';
    };

    services.anubis.instances.default.settings = {
        TARGET = "http://127.0.0.1:${toString srv.HTTP_PORT}";
        BIND = anubis;
        BIND_NETWORK = "tcp";
    };

    networking.firewall.allowedTCPPorts = [ 80 443 22 ];

    services.forgejo = {
        enable = true;
        database.type = "postgres";
        lfs.enable = true;
        settings = {
            DEFAULT = {
                APP_NAME = "Banana's Git";
                APP_SLOGAN = "Powered by Forgejo";
            };
            server = {
                DOMAIN = "git.potassium.sh";
                ROOT_URL = "https://${srv.DOMAIN}/"; 
                HTTP_ADDR = "127.0.0.1";
                HTTP_PORT = 3000;
                START_SSH_SERVER = true;
                SSH_LISTEN_HOST = "15.235.210.77";
            };
            repository = {
                USE_COMPAT_SSH_URI = false;
            };
            service = {
                DISABLE_REGISTRATION = true;
            };
        };
    };

    systemd.services.forgejo = {
        serviceConfig = {
            PrivateUsers = lib.mkForce false;
            AmbientCapabilities = lib.mkForce [ "CAP_NET_BIND_SERVICE" ];
            CapabilityBoundingSet = lib.mkForce [ "CAP_NET_BIND_SERVICE" ];
        };
    };
}
