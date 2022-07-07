{ config, pkgs, lib, ... }:

with builtins;
with lib;

let
    cfg = config.services.zinc;
in {
    options.services.zinc = {
        enable = mkEnableOption "zinc";
        package = mkOption {
            type = types.package;
            default = pkgs.zinc;
            description = "zinc package";
        };
        environmentFile = mkOption {
            type = types.nullOr types.path;
            default = null;
            description = "zinc environment file";
        };
    };
    config = mkIf cfg.enable {
        systemd.services.zinc = {
            description = "zinc";
            wantedBy = [ "multi-user.target" ];
            after = [ "network-online.target" ];
            restartIfChanged = true;
            path = [ cfg.package ];
            serviceConfig.EnvironmentFile = mkIf (cfg.environmentFile != null) cfg.environmentFile;
            script = ''
                mkdir -p /var/lib/zinc && cd /var/lib/zinc
                zinc
            '';
        };
    };
}