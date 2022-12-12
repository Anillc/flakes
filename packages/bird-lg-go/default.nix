{ buildGoModule, fetchgit, ... }: buildGoModule {
    name = "bird-lg-go";
    vendorSha256 = "sha256-7LZeCY4xSxREsQ+Dc2XSpu2ZI8CLE0mz0yoThP7/OO4=";
    src = "${fetchgit {
        url = "https://github.com/xddxdd/bird-lg-go.git";
        rev = "348295b9aa954a92df2cf6b1179846a9486dafc0";
        sha256 = "sha256-2t8ZP9Uc0sJlqWiJMq3MVoARfMKsuTXJkuOid0oWgyY=";
    }}/proxy";
}