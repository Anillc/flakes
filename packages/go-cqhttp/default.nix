{ pkgs, ... }: pkgs.buildGo117Module {
    name = "go-cqhttp";
    vendorSha256 = "sha256-wCCR3x5icPW1TZpznU9tHN8raB2SIV7Zc0PN1K8ekzA=";
    src = fetchTarball {
        url = "https://github.com/Mrs4s/go-cqhttp/archive/refs/tags/v1.0.0-beta7-fix2.tar.gz";
        sha256 = "sha256:1g702xw3acpa2kaz0nzwq7kszwqqz7zrfmj9i4w9jnk1xhbwys62";
    };
    preBuild = ''
        substituteInPlace ./global/codec.go       --replace '"ffmpeg"' '"${pkgs.ffmpeg}/bin/ffmpeg"'
        substituteInPlace ./global/codec/codec.go --replace '"ffmpeg"' '"${pkgs.ffmpeg}/bin/ffmpeg"'
    '';
}