{ config, lib, pkgs, ... }:

{
  home.file = {
    ".config/sioyek".source = ../dotfiles/sioyek;
  };
}
