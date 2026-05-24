{ config, lib, pkgs, ... }:

{
  home.file = {
    ".config/doom".source = ../dotfiles/doom;
  };
}
