{
  rustPlatform,
  fetchFromGitHub,
  ...
}:

rustPlatform.buildRustPackage {
  name = "http-proxy-ipv6-pool";
  cargoSha256 = "sha256-1jaq6WQ5+994R6NPAKS0uPczqWNoQyBI7hrfZIJ2UzU=";
  src = fetchFromGitHub {
    owner = "Anillc";
    repo = "http-proxy-ipv6-pool";
    rev = "b366b0d3d6385905ca3acd5f8dab0362cd8a42d3";
    sha256 = "sha256-iwF6ZSThXJiKjNBFwrei8SYZ68vpihXbPjS36d5r9q8=";
  };
}