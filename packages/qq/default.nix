{ appimageTools, lib, fetchurl, electron, makeWrapper, libsecret, ... }:

let
  pname = "qq";
  version = "2.0.1-429";
  name = "Tencent-QQ-${version}";

  src = fetchurl {
    url = "https://dldir1.qq.com/qqfile/qq/QQNT/c005c911/linuxqq_3.0.0-571_x86_64.AppImage";
    sha256 = "sha256-gKmk2m8pt2ygaHdFCWGo7+ZiQQ67VAvKH4o5OlwwPuE=";
  };

  appimageContents = appimageTools.extract { inherit name src; };

in appimageTools.wrapType2 {
  inherit version name src;

  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${pname}
    install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  passthru.version = version;

  extraPkgs = pkgs: with pkgs; [
    libsecret
    libappindicator-gtk3
  ];
}