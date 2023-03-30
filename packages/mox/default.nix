
{
fetchFromGitHub,
buildGoModule,
...
}:

buildGoModule {
  name = "mox";
  vendorSha256 = null;
  src = fetchFromGitHub {
    owner = "mjl-";
    repo = "mox";
    rev = "936a0d5afe16e1080ac55523fd87ae16b90d77c4";
    sha256 = "sha256-gpMgoFsRJkf8fDQEe0oPeHWzBo3io1QxKjemo+WBwXU=";
  };
}