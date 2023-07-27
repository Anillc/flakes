{
gmp,
zlib,
icu66,
unzip,
stdenv,
ncurses,
fetchurl,
autoPatchelfHook,
...
}:

stdenv.mkDerivation rec {
  pname = "als";
  version = "v0.2.2";
  src = fetchurl {
    url = "https://github.com/banacorn/agda-language-server/releases/download/${version}/als-ubuntu.zip";
    sha256 = "sha256-jy70ugI/8YJYpVca8/u2adrmwQPdtNrKbxedgw6v76g=";
  };
  nativeBuildInputs = [ autoPatchelfHook unzip ];
  buildInputs = [ zlib icu66 ncurses gmp ];
  unpackCmd = "unzip $src -d root";
  installPhase = ''
    mkdir -p $out/bin
    cp als $out/bin 
    cp -r data $out
    chmod +x $out/bin/als
  '';
}