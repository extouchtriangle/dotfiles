{ config, pkgs, ... }:

{
  home.username = "easton";
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };
  home.homeDirectory = "/home/easton";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = [
    pkgs.fish
    pkgs.starship
    pkgs.nodejs
    pkgs.neovim
    pkgs.eza
    pkgs.bat
    pkgs.kitty
    pkgs.rustup
  ];
  targets.genericLinux.enable = true;
  home.file = {
    ".config/hypr".source = dotfiles/hypr;
    ".config/quickshell".source = dotfiles/quickshell;
    ".config/noctalia".source = dotfiles/noctalia;
  };

  home.sessionVariables = {
    EDITOR = "emacs";
    VISUAL = "emacs";
    CC = "/sbin/gcc";
    CXX = "/bin/g++";
    MAMBA_EXE = "/usr/bin/micromamba";
    MAMBA_ROOT_PREFIX = "/home/easton/.local/share/mamba";
  };
  home.sessionPath = [
    "/usr/condabin"
    "/sbin"
    "/bin"
    "/usr/bin"
    "/usr/local/bin"
    "/usr/local/sbin"
    "/var/lib/flatpak/exports/bin"
    "/usr/lib/jvm/default/bin"
    "/usr/bin/site_perl"
    "/usr/bin/vendor_perl"
    "/usr/bin/core_perl"
    "$HOME/.local/bin"
    "$HOME/.nix_profile/bin"
    "$HOME/.local/share/gem/ruby/3.2.0/bin"
    "$HOME/.py-prompts"
    "/root/.local/bin"
    "$HOME/.local/share/gem/ruby/3.3.0/bin"
    "$HOME/.gem/ruby/3.3.0/bin"
    "/var/lib/snapd/snap/bin"
    "$HOME/.lmstudio/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
