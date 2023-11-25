{
stdenv,
cmake,
fetchFromGitHub,
...
}:

stdenv.mkDerivation {
  name = "libzt";
  src = fetchFromGitHub {
    owner = "zerotier";
    repo = "libzt";
    rev = "2f0f25a15870ac0ae52815558c539e63d656d506";
    fetchSubmodules = true;
    sha256 = "sha256-WELcpQRx1KTv5UhAgJ4k2wlm/OfmSNWb3GShLAD1USI=";
  };
  nativeBuildInputs = [ cmake ];
  buildInputs = [];
}
