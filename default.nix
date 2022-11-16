{ pkgs, lib, ... }:

{
  imports = [ ./cesm-lab.nix ];
  environment.systemPackages = with pkgs; [
    tree
    subversion
    unzip
    valgrind
  ];

  programs = {
    zsh.enable = true;
    command-not-found.enable = true;

    vim.defaultEditor = true;

    tmux.enable = true;
  };

  services.lorri.enable = true;
}
