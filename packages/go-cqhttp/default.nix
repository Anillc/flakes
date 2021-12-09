{ pkgs, ... }: pkgs.buildGo117Module {
    name = "go-cqhttp";
    vendorSha256 = "sha256-YHF4dNuCcfYlRm4rP1SlZsIpvS9/REWQDcv7BvcNq54=";
    src = fetchTarball {
        url = "https://github.com/Mrs4s/go-cqhttp/archive/refs/tags/v1.0.0-beta8-fix2.tar.gz";
        sha256 = "sha256:0nsdq31c69qcgbx3qmbbrkp558s67ysrn93x1arzcrvcs1bwxqag";
    };
    preBuild = ''
        substituteInPlace ./global/codec.go       --replace '"ffmpeg"' '"${pkgs.ffmpeg}/bin/ffmpeg"'
        substituteInPlace ./modules/silk/codec.go --replace '"ffmpeg"' '"${pkgs.ffmpeg}/bin/ffmpeg"'
    '';
}