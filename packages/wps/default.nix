{ pkgs, lib, ... }:

with builtins;
with lib;

pkgs.stdenv.mkDerivation {
    name = "wps";
    src = pkgs.fetchurl {
        url = "https://wps-linux-personal.wpscdn.cn/wps/download/ep/Linux2019/10976/wps-office_11.1.0.10976_amd64.deb";
        sha256 = "sha256-GndezCYqIdTRJ4TV5CS5JP9HX+xjpDNeuZjENJLs0g0=";
    };
    unpackCmd = "${pkgs.dpkg}/bin/dpkg -x $src .";
    sourceRoot = ".";
    nativeBuildInputs = with pkgs; [ qt5.wrapQtAppsHook autoPatchelfHook ];
    buildInputs = with pkgs; [
        fontconfig
        zlib
        libGL
        pango
        systemdMinimal
        xorg.libxcb
        xorg.libXdamage
        xorg.libICE
        xorg.libXrandr
        xorg.libXv
        xorg.libXtst
        xorg.libXScrnSaver
        qt5.qtbase
        qt4
        gtk3
        atk
        alsa-oss
        libtool
        nspr
    ];
    installPhase = ''
        mkdir -p $out/{etc,opt,bin,share}
        cp -r etc opt usr/bin usr/share $out
        substituteInPlace $out/bin/et     --replace /opt $out/opt
        substituteInPlace $out/bin/wpp    --replace /opt $out/opt
        substituteInPlace $out/bin/wps    --replace /opt $out/opt
        substituteInPlace $out/bin/wpspdf --replace /opt $out/opt
    '';
}