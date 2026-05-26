{config, pkgs, ... }: {
  imports = [
    ../modules/arch-fish.nix
    ../modules/kitty.nix
    ../modules/doomemacs.nix
    ../modules/sioyek.nix
  ];
  home.username = "easton";
  home.homeDirectory = "/home/easton";
  home.packages = [
  ];
}
