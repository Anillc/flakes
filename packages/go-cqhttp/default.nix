{ pkgs, ... }: pkgs.buildGo117Module {
    name = "go-cqhttp";
    vendorSha256 = "sha256-tL/U8JYe57FahjxwgR8Bz2u+UOeguUKCv0F9Sv1BO8Q=";
    src = fetchTarball {
        url = "https://github.com/Mrs4s/go-cqhttp/archive/refs/tags/v1.0.0-beta8-fix1.tar.gz";
        sha256 = "sha256:010q7ryvgjdc7a7rzplfbcyl54vn4f98yrlnqpn3w33ijw05yks2";
    };
    preBuild = ''
        substituteInPlace ./global/codec.go       --replace '"ffmpeg"' '"${pkgs.ffmpeg}/bin/ffmpeg"'
        substituteInPlace ./modules/silk/codec.go --replace '"ffmpeg"' '"${pkgs.ffmpeg}/bin/ffmpeg"'
    '';
}