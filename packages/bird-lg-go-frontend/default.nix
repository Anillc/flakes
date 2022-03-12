{ pkgs, ... }: pkgs.buildGo117Module {
    name = "bird-lg-go";
    doCheck = false;
    vendorSha256 = "sha256-WKuVGiSV5LZrJ8/672TRN6tZNQxdCktHV6nx0ZxCP4A=";
    src = "${pkgs.fetchgit {
        url = "https://github.com/xddxdd/bird-lg-go.git";
        rev = "348295b9aa954a92df2cf6b1179846a9486dafc0";
        sha256 = "sha256-2t8ZP9Uc0sJlqWiJMq3MVoARfMKsuTXJkuOid0oWgyY=";
    }}/frontend";
}