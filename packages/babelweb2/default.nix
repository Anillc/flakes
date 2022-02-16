{ pkgs, ... }: pkgs.buildGoModule {
    name = "babelweb2";
    vendorSha256 = "sha256-b3Ee2GMa8fhvDBBJtd03oNml6HyOj51iLS68eh8uDv0=";
    src = pkgs.fetchgit {
        url = "https://github.com/Anillc/babelweb2.git";
        rev = "ea898cf65663c61166df9e4caf6d9b1542cefc84";
        sha256 = "sha256-sLDgI9DJS5FopfRL7tu86nhTRqpy8XeY3FTpAVGMi1o=";
    };
}