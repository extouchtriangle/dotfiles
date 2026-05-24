{config, pkgs, ... }: {
  imports = [
    ../modules/arch-fish.nix
  ];
  home.username = "easton";
  home.homeDirectory = "/home/easton";
  home.packages = [
  ];
}
