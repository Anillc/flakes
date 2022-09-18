{
  rustPlatform,
  fetchFromGitHub,
  ...
}:

rustPlatform.buildRustPackage {
  name = "http-proxy-ipv6-pool";
  cargoSha256 = "sha256-1jaq6WQ5+994R6NPAKS0uPczqWNoQyBI7hrfZIJ2UzU=";
  src = fetchFromGitHub {
    owner = "zu1k";
    repo = "http-proxy-ipv6-pool";
    rev = "f8a433c88bc95f54172fbb226e839d22c8c9dac2";
    sha256 = "sha256-2GC8vdv2EKzgYnfvOJxfALc5NRglTrQ4kJ/VI6+M32s=";
  };
}