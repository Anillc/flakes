{ buildGoModule, fetchurl }: buildGoModule {
    name = "go-cqhttp";
    version = "v1.0.0-beta7-fix2";
    src = fetchTarball {
        url = "https://github.com/Mrs4s/go-cqhttp/archive/refs/tags/v1.0.0-beta7-fix2.tar.gz";
        sha256 = "1g702xw3acpa2kaz0nzwq7kszwqqz7zrfmj9i4w9jnk1xhbwys62";
    };
    vendorSha256 = "sha256-SR18Ni8iVmD0zmjP1GKiJf5G2u6TKRANMfV0ezIO7y0=";
}