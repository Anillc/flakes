{ pkgs, ... }: pkgs.buildGo117Module {
    name = "bird-lg-go";
    vendorSha256 = "sha256-7LZeCY4xSxREsQ+Dc2XSpu2ZI8CLE0mz0yoThP7/OO4=";
    src = "${pkgs.fetchgit {
        url = "https://github.com/xddxdd/bird-lg-go.git";
        rev = "af5b653326936ede439380d1a88b5ed96e4e7e8c";
        sha256 = "sha256-NURyhXYZjBxzrxGNc2RmWu9s/K5WFXSyRZoiEYhqnqs=";
    }}/proxy";
}