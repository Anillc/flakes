{ config, pkgs, lib, ... }: with lib; let
    cfg = config.services.go-cqhttp;
    yaml = pkgs.formats.yaml {};
    # server = types.oneOf [
    #     (types.submodule {
    #         options.http = {
    #             host = mkOption {
    #                 type = types.str;
    #                 default = "127.0.0.1";
    #                 description = "服务端监听地址";
    #             };
    #             port = mkOption {
    #                 type = types.int;
    #                 default = 5700;
    #                 description = "服务端监听端口";
    #             };
    #             timeout = mkOption {
    #                 type = types.int;
    #                 default = 5;
    #                 description = ''
    #                     反向 HTTP 超时时间, 单位秒
    #                     最小值为 5 ，小于 5 将会忽略本项设置
    #                 '';
    #             };
    #             post = mkOption {
    #                 type = types.nullOr types.listOf (types.submodule {
    #                     url = mkOption {
    #                         type = types.str;
    #                         description = "地址";
    #                     };
    #                     secret = mkOption {
    #                         type = types.str;
    #                         description = "密钥";
    #                     };
    #                 });
    #                 default = null;
    #                 description = "反向 HTTP POST 地址列表";
    #             };
    #             inherit middlewires;
    #         };
    #     })
    #     (types.submodule {
    #         options.ws = {
    #             host = mkOption {
    #                 type = types.str;
    #                 default = "127.0.0.1";
    #                 description = "正向 WS 服务器监听地址";
    #             };
    #             port = mkOption {
    #                 type = types.int;
    #                 default = 6700;
    #                 description = "正向 WS 服务器监听端口";
    #             };
    #             inherit middlewires;
    #         };
    #     })
    #     (types.submodule {
    #         options.ws-reverse = {
    #             universal = mkOption {
    #                 type = types.nullOr types.str;
    #                 default = null;
    #                 example = "ws://your_websocket_universal.server";
    #                 description = ''
    #                     反向WS Universal 地址
    #                     注意 设置了此项地址后 api 和 event 两项将会被忽略
    #                 '';
    #             };
    #             api = mkOption {
    #                 type = types.nullOr types.str;
    #                 default = null;
    #                 example = "ws://your_websocket_api.server";
    #                 description = "反向 WS API 地址";
    #             };
    #             event = mkOption {
    #                 type = types.nullOr types.str;
    #                 default = null;
    #                 example = "ws://your_websocket_event.server";
    #                 description = "反向 WS Event 地址";
    #             };
    #             reconnect-interval = mkOption {
    #                 type = types.int;
    #                 default = 3000;
    #                 description = "重连间隔 单位毫秒";
    #             };
    #             inherit middlewires;
    #         };
    #     })
    #     (types.submodule {
    #         options.pprof = {
    #             host = mkOption {
    #                 type = types.str;
    #                 default = "127.0.0.1";
    #                 description = "pprof 服务器监听地址";
    #             };
    #             port = mkOption {
    #                 type = types.int;
    #                 default = 7700;
    #                 description = "pprof 服务器监听端口";
    #             };
    #         };
    #     })
    #     (types.submodule {
    #         options.lambda = {
    #             type = mkOption {
    #                 type = types.enum [ "scf" "aws" ];
    #                 default = "scf";
    #                 description = "可用 scf,aws (aws未经过测试)";
    #             };
    #             inherit middlewires;
    #         };
    #     })
    # ];
    # middlewires = mkOption {
    #     type = types.attrsOf middlewire;
    #     default = {
    #         default-middlewares = {
    #             access-token = "";
    #             filter = "";
    #             rate-limit = {
    #                 enabled = false;
    #                 frequency = 1;
    #                 bucket = 1;
    #             };
    #         };
    #     };
    #     description = "middlewires";
    # };
    # middlewire = types.submodule {
    #     options = {
    #         access-token = mkOption {
    #             type = types.str;
    #             default = "";
    #             description = "访问密钥, 强烈推荐在公网的服务器设置";
    #         };
    #         filter = mkOption {
    #             type = types.str;
    #             default = "";
    #             description = "事件过滤器文件目录";
    #         };
    #         rate-limit = {
    #             enabled = mkOption {
    #                 type = types.bool;
    #                 default = false;
    #                 description = "是否启用限速";
    #             };
    #             frequency = mkOption {
    #                 type = types.int;
    #                 default = 1;
    #                 description = "令牌回复频率, 单位秒";
    #             };
    #             bucket = mkOption {
    #                 type = types.int;
    #                 default = 1;
    #                 description = "令牌桶大小";
    #             };
    #         };
    #     };
    # };
in {
    options.services.go-cqhttp = {
        enable = mkEnableOption "go-cqhttp";
        config = {
            account = {
                encrypt = mkOption {
                    type = types.bool;
                    default = false;
                    description = "是否开启密码加密";
                };
                status = mkOption {
                    type = types.int;
                    default = 0;
                    description = "在线状态 请参考 https://docs.go-cqhttp.org/guide/config.html#在线状态";
                };
                relogin = {
                    delay = mkOption {
                        type = types.int;
                        default = 3;
                        description = "首次重连延迟, 单位秒";
                    };
                    interval = mkOption {
                        type = types.int;
                        default = 3;
                        description = "重连间隔";
                    };
                    max-times = mkOption {
                        type = types.int;
                        default = 0;
                        description = "最大重连次数, 0为无限制";
                    };
                };
                use-sso-address = mkOption {
                    type = types.bool;
                    default = true;
                    description = ''
                        是否使用服务器下发的新地址进行重连
                        注意, 此设置可能导致在海外服务器上连接情况更差
                    '';
                };
                uin = mkOption {
                    type = types.nullOr types.str;
                    default = null;
                    description = "QQ 账号";
                };
                password = mkOption {
                    type = types.nullOr types.str;
                    default = null;
                    description = "密码 (为空时使用扫码登录)";
                };
            };
            heartbeat = {
                interval = mkOption {
                    type = types.int;
                    default = 3;
                    description = ''
                        心跳频率, 单位秒
                        -1 为关闭心跳
                    '';
                };
            };
            message = {
                post-format = mkOption {
                    type = types.enum [ "string" "array" ];
                    default = "string";
                    description = ''
                        上报数据类型
                        可选: string,array
                    '';
                };
                ignore-invalid-cqcode = mkOption {
                    type = types.bool;
                    default = false;
                    description = "是否忽略无效的CQ码, 如果为假将原样发送";
                };
                force-fragment = mkOption {
                    type = types.bool;
                    default = false;
                    description = ''
                        是否强制分片发送消息
                        分片发送将会带来更快的速度
                        但是兼容性会有些问题
                    '';
                };
                fix-url = mkOption {
                    type = types.bool;
                    default = false;
                    description = "是否将url分片发送";
                };
                proxy-rewrite = mkOption {
                    type = types.str;
                    default = "";
                    description = "下载图片等请求网络代理";
                };
                report-self-message = mkOption {
                    type = types.bool;
                    default = false;
                    description = "是否上报自身消息";
                };
                remove-reply-at = mkOption {
                    type = types.bool;
                    default = false;
                    description = "移除服务端的Reply附带的At";
                };
                extra-reply-data = mkOption {
                    type = types.bool;
                    default = false;
                    description = "为Reply附加更多信息";
                };
                skip-mime-scan = mkOption {
                    type = types.bool;
                    default = false;
                    description = "跳过 Mime 扫描, 忽略错误数据";
                };
            };
            output = {
                log-level = mkOption {
                    type = types.enum [ "trace" "debug" "info" "warn" "error" ];
                    default = "warn";
                    description = "日志等级 trace,debug,info,warn,error";
                };
                log-aging = mkOption {
                    type = types.int;
                    default = 15;
                    description = "日志时效 单位天. 超过这个时间之前的日志将会被自动删除. 设置为 0 表示永久保留";
                };
                log-force-new = mkOption {
                    type = types.bool;
                    default = true;
                    description = "是否在每次启动时强制创建全新的文件储存日志. 为 false 的情况下将会在上次启动时创建的日志文件续写";
                };
                debug = mkOption {
                    type = types.bool;
                    default = false;
                    description = "是否启用 DEBUG";
                };
            };
            database.leveldb.enable = mkOption {
                type = types.bool;
                default = true;
                description = ''
                    是否启用内置leveldb数据库
                    启用将会增加10-20MB的内存占用和一定的磁盘空间
                    关闭将无法使用 撤回 回复 get_msg 等上下文相关功能
                '';
            };
            database.cache = {
                image = mkOption {
                    type = types.nullOr types.str;
                    default = "data/image.db";
                    description = "";
                };
                video = mkOption {
                    type = types.nullOr types.str;
                    default = "data/video.db";
                    description = "";
                };
            };
            servers = mkOption {
                # type = types.listOf server; # the value from submodule.check is always true
                type = types.listOf types.anything;
                default = [{
                    ws = {
                        host = "127.0.0.1";
                        port = 6700;
                        middlewires = {
                            default-middlewares = {
                                access-token = "";
                                filter = "";
                                rate-limit = {
                                    enabled = false;
                                    frequency = 1;
                                    bucket = 1;
                                };
                            };
                        };
                    };
                }];
                example = literalExpression ''
                    [{
                        ws = {
                            host = "127.0.0.1";
                            port = 6700;
                            middlewires = {
                                default-middlewares = {
                                    access-token = "";
                                    filter = "";
                                    rate-limit = {
                                        enabled = false;
                                        frequency = 1;
                                        bucket = 1;
                                    };
                                };
                            };
                        };
                    }]
                '';
                description = "https://docs.go-cqhttp.org/guide/config.html#%E9%85%8D%E7%BD%AE%E4%BF%A1%E6%81%AF";
            };
        };
        device = mkOption {
            type = types.str;
            description = "设备信息文件";
        };
        package = mkOption {
            default = pkgs.go-cqhttp;
            type = types.package;
            description = "go-cqhttp package";
        };
    };
    config = mkIf cfg.enable {
        environment.etc."go-cqhttp/device.json".source = cfg.device;
        environment.etc."go-cqhttp/config.yml".source = yaml.generate "config.yml" cfg.config;
        systemd.services.go-cqhttp = {
            description = "go-cqhttp";
            wantedBy = [ "multi-user.target" ];
            after = [ "network.target" ];
            script = "${cfg.package}/bin/go-cqhttp";
            serviceConfig = {
                WorkingDirectory = "/etc/go-cqhttp";
                Restart = "always";
                RestartSec = 1;
            };
        };
    };
}