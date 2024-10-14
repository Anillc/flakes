{
gmp,
zlib,
icu70,
unzip,
stdenv,
ncurses,
fetchurl,
autoPatchelfHook,
...
}:

stdenv.mkDerivation rec {
  pname = "als";
  version = "v0.2.6.4.0.3";
  src = fetchurl {
    url = "https://github.com/banacorn/agda-language-server/releases/download/${version}/als-ubuntu.zip";
    sha256 = "sha256-nyQSbNxCloaV2TX3dR7DVfL56wVeCkRpq4zHFZpsg+o=";
  };
  nativeBuildInputs = [ autoPatchelfHook unzip ];
  buildInputs = [ zlib icu70 ncurses gmp ];
  unpackCmd = "unzip $src -d root";
  installPhase = ''
    mkdir -p $out/bin
    cp als $out/bin 
    cp -r data $out
    chmod +x $out/bin/als
  '';
}