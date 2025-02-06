{ rustPlatform, fetchFromGitHub, ... }:

rustPlatform.buildRustPackage {
  name = "ctos";
  src = fetchFromGitHub {
    owner = "oluceps";
    repo = "clash2sing-box";
    rev = "cd11815ec8b04c62b0f03fc6c08d4794126f0f9b";
    sha256 = "sha256-RtXjMXybfna3wRDHmqd4RvBdA5pPo4Gza6ZxEt2S3uE=";
  };
  useFetchCargoVendor = true;
  cargoHash = "sha256-44HkoKEWqrR3020V/jqAIbrloT1hYbrEC6wDz1SLt4k=";
  RUSTC_BOOTSTRAP = 1;
}