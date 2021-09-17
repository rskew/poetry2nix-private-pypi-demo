# nixpkgs latest version 2021-09-17
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/644e1ca5c55aa308716a2869f288803ae5d05383.tar.gz") {}
}:
let
  pythonEnv = pkgs.python38.withPackages(ps: with ps; [ 
    pypiserver 
    passlib
  ]);
in
pkgs.stdenv.mkDerivation {
  name = "pypi-server";

  buildInputs = [
    pythonEnv
    pkgs.apacheHttpd
    pkgs.poetry
  ];
}
