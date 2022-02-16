{ config, pkgs, lib, ... }: with lib; let
    cfg = config.services.babelweb2;
in {
    options.services.babelweb2 = {
        enable = mkEnableOption "enable babelweb2";
        nodes = mkOption {
            type = types.listOf types.str;
            description = "nodes";
            default = [];
        };
        address = mkOption {
            type = types.str;
            description = "web server address (default :8080)";
            default = ":8080";
        };
    };
    config = mkIf cfg.enable {
        systemd.services.babelweb2 = let
            nodesParam = pkgs.lib.strings.concatStringsSep " " (builtins.map (x: "-node=" + x) cfg.nodes);
        in {
            wantedBy = [ "multi-user.target" ];
            script = "${pkgs.babelweb2}/bin/babelweb2 -static ${pkgs.babelweb2-static} -http ${cfg.address} ${nodesParam}";
        };
    };
}