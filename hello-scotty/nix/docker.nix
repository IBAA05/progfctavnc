{ pkgs ? import <nixpkgs> {} }:

let

  app = import ./release.nix;

  entrypoint = pkgs.writeScript "entrypoint.sh" ''
    #!${pkgs.stdenv.shell}
    $@
  '';

in

  pkgs.dockerTools.buildImage {
    name = "hello-scotty";
    tag = "latest";
    created = "now";
    config = {
      WorkingDir = "${app}";
      Entrypoint = [ entrypoint ];
      Cmd = [ "${app}/bin/hello-scotty" ];
    };
  }

