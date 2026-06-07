{ config, lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      icat = "kitten icat";
      yesman = "yes | sudo pacman";
      lgit = "lazygit";
      ssh = "kitten ssh"
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
    plugins = [
      {
        name = "bass";
        src = pkgs.fishPlugins.bass.src;
      }
    ];
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
}
