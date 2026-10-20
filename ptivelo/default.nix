
{ pkgs ? import <nixpkgs> {} }:

let
  ghc = pkgs.haskellPackages;
  # ghc = pkgs.haskell.packages.ghc910;

in ghc.developPackage {
  root = ./.;
  withHoogle = false;

  modifier = drv:
    pkgs.haskell.lib.dontHaddock (
      pkgs.haskell.lib.addBuildTools drv (with ghc; [
        cabal-install
        haskell-language-server
    ]));
}

