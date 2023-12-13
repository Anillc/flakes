{
stdenv,
fetchFromGitHub,
cmake,
...
}:

stdenv.mkDerivation {
  name = "espresso";
  src = fetchFromGitHub {
    owner = "chipsalliance";
    repo = "espresso";
    rev = "v2.4";
    sha256 = "sha256-z5By57VbmIt4sgRgvECnLbZklnDDWUA6fyvWVyXUzsI=";
  };
  nativeBuildInputs = [ cmake ];
}