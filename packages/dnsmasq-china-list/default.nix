{ lib, stdenv, fetchFromGitHub, ... }:

with builtins;
with lib;

stdenv.mkDerivation {
    name = "dnsmasq-china-list";
    src = fetchFromGitHub {
        owner = "felixonmars";
        repo = "dnsmasq-china-list";
        rev = "efc1171149fc9df0e0e50385bd019239fd90d28a";
        sha256 = "sha256-P1daglWwmbJ3h39v/frtrmz1FpsyF8gbk2CFkodAv7k=";
    };
    buildPhase = ''
        mkdir -p $out
        make SERVER=domestic smartdns
        cp *.smartdns.conf $out
    '';
}