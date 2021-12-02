{ pkgs, ... }: pkgs.buildGo117Module {
    name = "go-cqhttp";
    vendorSha256 = "sha256-NV3IYgTFaSHxlKb17w4WzEhwX13MJIZX1vkBqdu/eOg=";
    src = pkgs.fetchgit {
        url = "https://github.com/Mrs4s/go-cqhttp.git";
        rev = "e990860632783ffd39f461c081a83922b6db438e";
        sha256 = "sha256-rbXPnJDjOAlaYm0T1PoPTA0jnYpzQhpZcTVLwGdLfeE=";
    };
    preBuild = ''
        substituteInPlace ./global/codec.go       --replace '"ffmpeg"' '"${pkgs.ffmpeg}/bin/ffmpeg"'
        substituteInPlace ./modules/silk/codec.go --replace '"ffmpeg"' '"${pkgs.ffmpeg}/bin/ffmpeg"'
    '';
}