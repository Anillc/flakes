{ pkgs, lib, ... }:

with builtins;
with lib;

pkgs.appimageTools.wrapType2 {
    name = "icalingua";
    src = pkgs.fetchurl {
        url = "https://github.com/Icalingua-plus-plus/Icalingua-plus-plus/releases/download/v2.6.1/Icalingua++-2.6.1.AppImage";
        sha256 = "sha256-2YaoNLmck6xEayHQYIYD/4Z4S98o7/lXoUUiDkXp0ek=";
    };
}