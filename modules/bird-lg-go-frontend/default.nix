
{ config, pkgs, lib, ... }: with lib; let
    cfg = config.services.bird-lg-go-frontend;
in {
    options.services.bird-lg-go-frontend = {
        enable = mkEnableOption "bird-lg-go-frontend";
        package = mkOption {
            type = types.package;
            default = pkgs.bird-lg-go-frontend;
            description = "bird-lg-go-frontend package";
        };
        servers = mkOption {
            type = types.nullOr (types.listOf types.str);
            default = null;
            description = "server name prefixes";
        };
        domain = mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "server name domain suffixes";
        };
        listen = mkOption {
            type = types.nullOr types.int;
            default = null;
            description = "address bird-lg is listening on (default \"5000\")";
        };
        proxy-port = mkOption {
            type = types.nullOr types.int;
            default = null;
            description = "port bird-lgproxy is running on (default 8000)";
        };
        whois = mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "whois server for queries (default \"whois.verisign-grs.com\")";
        };
        dns-interface = mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "dns zone to query ASN information (default \"asn.cymru.com\")";
        };
        bgpmap-info = mkOption {
            type = types.nullOr (types.listOf types.str);
            default = null;
            description = "the infos displayed in bgpmap (default \"asn,as-name,ASName,descr\")";
        };
        title-brand = mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "prefix of page titles in browser tabs (default \"Bird-lg Go\")";
        };
        navbar-brand = mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "brand to show in the navigation bar (default \"Bird-lg Go\")";
        };
        navbar-brand-url = mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "the url of the brand to show in the navigation bar (default \"/\")";
        };
        navbar-all-servers = mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "the text of \"All servers\" button in the navigation bar (default \"ALL Servers\")";
        };
        navbar-all-url = mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "the URL of \"All servers\" button (default \"all\")";
        };
        net-specific-mode = mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "apply network-specific changes for some networks, use \"dn42\" for BIRD in dn42 network";
        };
        protocol-filter = mkOption {
            type = types.nullOr (types.listOf types.str);
            default = null;
            description = "protocol types to show in summary tables. defaults to all if not set";
        };
    };
    config = let
        servers =            optionalString (cfg.servers            != null) "--servers ${concatStringsSep "," cfg.servers}";
        domain =             optionalString (cfg.domain             != null) "--domain ${cfg.domain}";
        listen =             optionalString (cfg.listen             != null) "--listen ${builtins.toString cfg.listen}";
        proxy-port =         optionalString (cfg.proxy-port         != null) "--proxy-port ${builtins.toString cfg.proxy-port}";
        whois =              optionalString (cfg.whois              != null) "--whois ${cfg.whois}";
        dns-interface =      optionalString (cfg.dns-interface      != null) "--dns-interface ${cfg.dns-interface}";
        bgpmap-info =        optionalString (cfg.bgpmap-info        != null) "--bgpmap-into ${concatStringsSep "," cfg.bgpmap-info}";
        title-brand =        optionalString (cfg.title-brand        != null) "--title-brand ${cfg.title-brand}";
        navbar-brand =       optionalString (cfg.navbar-brand       != null) "--navbar-brand ${cfg.navbar-brand}";
        navbar-brand-url =   optionalString (cfg.navbar-brand-url   != null) "--navbar-brand-url ${cfg.navbar-brand-url}";
        navbar-all-servers = optionalString (cfg.navbar-all-servers != null) "--navbar-all-servers ${cfg.navbar-all-servers}";
        navbar-all-url =     optionalString (cfg.navbar-all-url     != null) "--navbar-all-servers-url ${cfg.navbar-all-url}";
        net-specific-mode =  optionalString (cfg.net-specific-mode  != null) "--net-specific-mode ${cfg.net-specific-mode}";
        protocol-filter =    optionalString (cfg.protocol-filter    != null) "--protocol-filter ${concatStringsSep "," cfg.protocol-filter}";
    in mkIf cfg.enable {
        systemd.services.bird-lg-go-frontend = {
            description = "bird-lg-go-frontend";
            wantedBy = [ "multi-user.target" ];
            after = [ "network-online.target" ];
            script = "${cfg.package}/bin/frontend ${servers} ${domain} ${listen} ${proxy-port} ${whois} ${dns-interface} ${bgpmap-info} ${title-brand} ${navbar-brand} ${navbar-brand-url} ${navbar-all-servers} ${navbar-all-url} ${net-specific-mode} ${protocol-filter}";
        };
    };
}