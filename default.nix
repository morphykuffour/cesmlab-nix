{pkgs ? import <nixpkgs> {}}:
with pkgs;
  mkShell {
    imports = [./cesmlab-docker.nix];

    # nativeBuildInputs = [
    #   pkg-config
    # ];

    buildInputs = [
      subversion
    ];
  }
