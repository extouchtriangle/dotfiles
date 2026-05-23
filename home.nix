{ config, pkgs, ... }:

{
  home.username = "easton";
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
    pkgs.emacs-pgtk
  ];
  targets.genericLinux.enable = true;
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/hypr".source = dotfiles/hypr;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/easton/etc/profile.d/hm-session-vars.sh
  #
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
  programs.fish = {
    enable = true;
    shellAliases = {
      icat = "kitten icat";
      yesman = "yes | sudo pacman";
      lgit = "lazygit";
    };
    shellAbbrs = {
      s = "yesman -S";
      S = "yay -S";
      syu = "yesman -Syu";
      r = "sudo pacman -R";
      pvc = "latexmk -pvc -cd";
      pv = "laxexmk -pv cd";
      nv = "nvim";
      ka = "killall";
    };
    functions = {
      zath = ''
        zathura $argv -l error &
        disown %1
        sleep 0.2
        ydotool key 39:1 39:0
        '';
      fish_greeting = ''
        export PF_INFO="ascii title os host kernel memory de shell palette"
        pfetch
        '';
      compile_vrs = ''
        g++ FilterCopySamples.cpp -o FilterCopySamples \
            -L/usr/local/lib \
            -I/usr/local/include \
            # VRS Libraries (from most dependent to least, or internal dependencies last)
            -lvrs_utils \
            -lvrs_utils_converters \
            -lvrs_utils_cli \
            -lvrs_helpers \
            # Libraries that define functions used by the above, and also by vrslib
            -lvrslib \
            -lvrs_os \
            -lvrs_logging \
            -lvrs_utils_xxhash \
            # External Libraries (order generally less critical, but still good to put providers later)
            -llz4 \
            -lzstd \
            -lboost_filesystem \
            -lboost_system \
            -lxxhash \
            -lfmt \
            -lpthread
        '';
        ros = ''
        micromamba activate ros_env
        set TERM kitty
        bass source ~/.conda/envs/ros_env/setup.bash
        '';
        fish_user_key_bindings = ''
        set -g fish_key_bindings fish_vi_key_bindings
        bind -M insert right complete
        bind -M insert \t accept-autosuggestion
        bind -M normal right complete
        '';
    };
    interactiveShellInit = ''
     rbenv init - --no-rehash fish | source
     $MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
     bass source /etc/profile
     starship init fish | source
    '';
  };
  programs.kitty = {
    enable = true;
    font = {
      name = "GeistMono Nerd Font";
      size = 12;
    };
    settings = {
      scrollback_lines = 20000;
      touch_scroll_multiplier = 5.0;
      allow_remote_control = "yes";
      cursor_shape = "beam";
      cursor_trail = 3;
      confirm_os_window_close = 0;
      copy_on_select = "yes";
      background = "#1a1d21";
      foreground = "#e0dcd4";
      cursor = "#DBCDB3";

      selection_foreground = "#e0dcd4";
      selection_background = "#3d424a";

      color0 = "#1a1d21";
      color8 = "#515761";

      color1 = "#CDACAC";
      color9 = "#c8beb8";

      color2 = "#b8c4b8";
      color10 = "#b4beb4";

      color3 = "#DBCDB3";
      color11 = "#ccc4b0";

      color4 = "#b4bcc4";
      color12 = "#b4bcc4";

      color5 = "#c0b8bc";
      color13 = "#c4beb8";

      color6 = "#b0bcc8";
      color14 = "#b0c0b8";

      color7 = "#c0bdb8";
      color15 = "#e0dcd4";
      linux_display_server = "wayland";
    };
    extraConfig = ''
    mouse_hide_wait 2.0
    background_tint 0.9
    kitty_mod ctrl+shift
    background_opacity 0.92
    map ctrl+shift+l next_tab
    map ctrl+shift+h previous_tab

    map kitty_mod+t new_tab_with_cwd

    tab_bar_min_tabs 1
    tab_bar_edge bottom
    tab_bar_style powerline
    tab_powerline_style slanted

    map ctrl+c copy_or_interrupt

    map page_up scroll_page_up
    map page_down scroll_page_down

    map ctrl+plus change_font_size all +1
    map ctrl+equal change_font_size all +1
    map ctrl+kp_add change_font_size all +1
    map ctrl+minus change_font_size all -1
    map ctrl+underscore change_font_size all -1
    map ctrl+kp_subtract change_font_size all -1
    map ctrl+0 change_font_size all 0
    map ctrl+kp_0 change_font_size all 0
    '';
  };

}
