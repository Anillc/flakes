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
  version = "v0.2.6.3.0";
  src = fetchurl {
    url = "https://github.com/banacorn/agda-language-server/releases/download/${version}/als-ubuntu.zip";
    sha256 = "sha256-1msmuC/zjSJ+gP9ed/Eh7D7rdKSoIfg8FlywSDbjvag=";
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