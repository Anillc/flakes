{ pkgs, ... }: pkgs.buildGo117Module {
    name = "go-cqhttp";
    vendorSha256 = "sha256-9RJTl5GZAiLY1vqhxxO6XIFxKD+1QyoMBxhzceHzelg=";
    src = fetchTarball {
        url = "https://github.com/Mrs4s/go-cqhttp/archive/refs/tags/v1.0.0-rc1.tar.gz";
        sha256 = "sha256:1w1l5lryg7m1y3dbcjh3b8j93imr21m5hxmlzcjkx9sd14w4jzsv";
    };
    preBuild = ''
        substituteInPlace ./global/codec.go       --replace '"ffmpeg"' '"${pkgs.ffmpeg}/bin/ffmpeg"'
        substituteInPlace ./modules/silk/codec.go --replace '"ffmpeg"' '"${pkgs.ffmpeg}/bin/ffmpeg"'
    '';
}