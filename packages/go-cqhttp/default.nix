{ pkgs, ... }: pkgs.stdenv.mkDerivation {
    name = "go-cqhttp";
    src = fetchTarball {
        url = "https://github.com/Mrs4s/go-cqhttp/archive/refs/tags/v1.0.0-beta8-fix1.tar.gz";
        sha256 = "sha256:010q7ryvgjdc7a7rzplfbcyl54vn4f98yrlnqpn3w33ijw05yks2";
    };
    #vendorSha256 = "sha256-FOC1jkg3Iyi2b2WeiWf5KG9X6StaJHczp/F4WKADeB4="; 
    preBuildPhase = ''
        substituteInPlace ./global/codec.go       --replace '"ffmpeg"' '"${pkgs.ffmpeg}/bin/ffmpeg"'
        substituteInPlace ./global/codec/codec.go --replace '"ffmpeg"' '"${pkgs.ffmpeg}/bin/ffmpeg"'
    '';
    buildPhase = ''
        HOME=$TMPDIR
        ${pkgs.go_1_17}/bin/go build -o output/go-cqhttp .
    '';
    installPhase = ''
        mkdir -p $out/bin
        cp output/go-cqhttp $out/bin/go-cqhttp
    '';
}