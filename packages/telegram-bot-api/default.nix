{ pkgs, ... }: pkgs.stdenv.mkDerivation {
    name = "telegram-bot-api";
    src = pkgs.fetchgit {
        url = "https://github.com/tdlib/telegram-bot-api.git";
        rev = "c57b04c4c8c4e8d8bb6fdd0bd3bfb5b93b9d8f05";
        sha256 = "sha256-WetzX8GBdwQAnnZjek+W4v+QN1aUFdlvs+Jv6n1B+eY=";
    };
    nativeBuildInputs = with pkgs; [ cmake gperf ];
    buildInputs = with pkgs; [ openssl zlib ];
}