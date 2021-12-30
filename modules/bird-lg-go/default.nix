{ config, pkgs, lib, ... }: with lib; let
    cfg = config.services.bird-lg-go;
in {
    options.services.bird-lg-go = {
        enable = mkEnableOption "bird-lg-go";
        package = mkOption {
            type = types.package;
            default = pkgs.bird-lg-go;
            description = "bird-lg-go package";
        };
        allowed = mkOption {
            type = types.nullOr (types.listOf types.str);
            default = null;
            description = "IPs allowed to access this proxy, separated by commas. Don't set to allow all IPs. (default \"\")";
        };
        bird = mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "socket file for bird, set either in parameter or environment variable BIRD_SOCKET (default \"/var/run/bird/bird.ctl\")";
        };
        listen = mkOption {
            type = types.nullOr types.int;
            default = null;
            description = "listen address, set either in parameter or environment variable BIRDLG_PROXY_PORT(default \"8000\")";
        };
    };
    config = let
        allowed = optionalString (cfg.allowed != null) "--allowed \"${builtins.concatStringsSep "," cfg.allowed}\"";
        bird = optionalString (cfg.bird != null) "--bird ${cfg.bird}";
        listen = optionalString (cfg.listen != null) "--listen ${builtins.toString cfg.listen}";
    in mkIf cfg.enable {
        systemd.services.bird-lg-go = {
            description = "bird-lg-go";
            wantedBy = [ "multi-user.target" ];
            after = [ "network-online.target" ];
            script = "${cfg.package}/bin/proxy --traceroute_bin \"${pkgs.traceroute}/bin/traceroute\" ${allowed} ${bird} ${listen}";
        };
    };
}