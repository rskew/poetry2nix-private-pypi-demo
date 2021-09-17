# nixpkgs latest version 2021-09-17
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/644e1ca5c55aa308716a2869f288803ae5d05383.tar.gz") {}
}:
let
  poetry2nix = import ../poetry2nix { inherit pkgs; poetry = pkgs.poetry; };
  pythonEnv = poetry2nix.mkPoetryEnv {
    projectDir = ./.;
    pyproject = ./pyproject.toml;
    poetrylock = ./poetry.lock;
    repositoryCredentialsFile = ./repository-credentials.json;
  };
in
pkgs.stdenv.mkDerivation {
  name = "user_project";

  buildInputs = [
    pythonEnv
  ];
}
