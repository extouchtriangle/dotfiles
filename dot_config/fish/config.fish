if status is-interactive
    # Commands to run in interactive sessions can go here
    alias chktex="chktex -n1"
    alias gitpush="git add . && git commit -a && git push --force origin main"
    # make sure environment variables are correct (especially locales)
    export PATH=/usr/local/texlive/2024/bin/x86_64-linux:/usr/local/texlive/2024/bin/x86_64-linux:/usr/condabin:/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/sbin:/opt/cuda/bin:/opt/cuda/nsight_compute:/opt/cuda/nsight_systems/bin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.local/bin:$HOME/.local/share/gem/ruby/3.2.0/bin:$HOME/.py-prompts:/root/.local/bin:$HOME/.local/share/gem/ruby/3.3.0/bin:$HOME/.gem/ruby/3.3.0/bin
end
export VISUAL=nvim
export EDITOR="$VISUAL"
# Created by `pipx` on 2024-09-07 18:06:26
set PATH $PATH $HOME/.local/bin
set PATH $PATH $HOME/.local/share/gem/ruby/3.2.0/bin
# TokyoNight Color Palette

alias i3conf="nvim -c 'ChezmoiEdit ~/.config/i3/config'"
alias fishconf="nvim -c 'ChezmoiEdit ~/.config/fish/config.fish'"
alias kittyconf="nvim -c 'ChezmoiEdit ~/.config/kitty/kitty.conf'"
alias epddir="cd $HOME/Documents/EPD"
function zath
    zathura $argv -l error &
    disown %1
    sleep 0.2
    xdotool key s
end
function fish_prompt
    set last_status $status
    if set -q SUDO_USER
        or set -q SSH_TTY
        set_color --italics $yellow
        printf (prompt_pwd)
    else
        set_color --italics b4befe
        printf (prompt_pwd)
    end
    set_color normal
    if not test $last_status -eq 0
        set_color $fish_color_error
        printf ' ['
        printf $last_status
        printf ']'
    end
    if set -q SUDO_USER
        or set -q SSH_TTY
        printf ' '
        set_color -b blue yellow --bold
        printf '('
        printf $USER
        printf ')'
        set_color normal
        printf ' '
    else
        set_color --bold $fish_color_arrows
        printf ' >> '
    end
    set_color normal
end
function fish_right_prompt
    set_color normal
    if set -q VIRTUAL_ENV
        echo -n -s (set_color -b blue white) (basename "$VIRTUAL_ENV" | string sub -l 2) "🐍" (set_color normal)
    end
    if set -q nvm_current_version
        echo -n -s (set_color -b blue white) (string sub -l 3 "$nvm_current_version") "☕" (set_color normal)
    end
    set_color normal
    printf '%s ' (__fish_git_prompt)
    set_color normal
    set_color $fish_color_date
    printf "["
    printf (date +'%R')
    printf "]"
end

function fish_greeting
    set_color --italics $fish_color_greeting
    printf "Hello "
    set_color --italics $fish_color_name
    printf $USER
    set_color normal
    set_color --italics $fish_color_host
    printf @
    printf (hostname)
    printf ".\n"
    set_color normal
    if test (pwd) = "$HOME"
        if test $hostname = ArchEmerald
            archey3 --color=green --config="$HOME/archey3.cfg"
        else
            archey3
        end
    end
end
alias poes "poetry shell"
alias wikipedia="wikicurses"
alias aopswiki="wikicurses --wiki https://aops.com/wiki/api.php"
alias poole="$HOME/poole/poole.py"
alias killlock="killall xss-lock"
function countdown
    echo 'TIMER:' $argv
    read -P 'Press enter to start... '
    notify-send -i ~/Pictures/timer.png Countdown 'Timer started.'
    termdown $argv[..] -b -t END --exec-cmd \"
    if [ '{0}' == 60 ]
        then notify-send -i ~/Pictures/timer.png Countdown 'Timer ends in 1 minute.'
    end
    if [ '{0}' == 1 ]
        then notify-send -i ~/Pictures/timer.png Countdown 'Timer ended!'
        fi \" && exit
    end
end
function nvid
    daemonize -c $PWD /usr/bin/neovide $argv && exit
end
alias pip='~/.local/bin/pip'
alias icat='kitten icat'

# Added by `rbenv init` on Tue Dec 24 10:17:51 AM EST 2024
status --is-interactive; and rbenv init - --no-rehash fish | source
alias epd='python -m epd'
function venhance
    xdg-open https://github.com/venhance/dotfiles/blob/main/$argv
end
function ecc
    g++ $argv && ./a.out
end
alias aoeu='echo "I see you type in Dvorak."'
alias asdf='echo "Eww!!! QWERTY! Switching to DVORAK." && bash ~/sh-scripts/keymaps.sh'
alias trash='gio trash'
alias yesman='yes | sudo pacman'
alias lgit='lazygit'
alias egmo='zath ~/otis/EGMO.pdf'
alias otispath='cd $OTIS_PATH'
alias journal='nvim -c Journal'

# Added by LM Studio CLI (lms)
set -gx PATH $PATH $HOME/.lmstudio/bin
# Abbreviations
abbr s sudo pacman -S
abbr S pikaur -S
abbr syu sudo pacman -Syu
abbr Syu pikaur -Syu
abbr pvc latexmk -pvc -cd
abbr pv latexmk -pv -cd
abbr nv nvim
abbr pii pip install
abbr npi npm install
abbr sctle systemctl enable
abbr sctls systemctl start
abbr fc fishconf
abbr dv dvorak
abbr ttp ttyper
abbr ka killall
abbr r sudo pacman -R
abbr ch chezmoi
abbr ot otispath

# Keybinds
bind -M insert right complete
bind -M insert tab accept-autosuggestion
bind -M normal right complete
set -x ROS_PACKAGE_PATH {$ROS_PACKAGE_PATH},:/tmp/orb_slam3/Examples/ROS
set -U fish_prompt_pwd_dir_length 2
function ros-start
    docker run -it --env="DISPLAY" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" -v /home/$(whoami)/ros:/ros --device /dev/video0 --device /dev/dri osrf/ros:kinetic-desktop-full bash -c "cp /ros/.bashrc /root/.bashrc && bash"
end

function ros-connect
    docker exec -ti $(docker ps -aq --filter ancestor=osrf/ros:kinetic-desktop-full --filter status=running) bash
end

function ros-clean
    docker rm $(docker ps -aq --filter ancestor=osrf/ros:kinetic-desktop-full --filter status=exited)
end
alias nvchad="NVIM_APPNAME=nvchad nvim"
alias pdf="zath *.pdf"
set -g fish_key_bindings fish_vi_key_bindings
starship init fish | source
alias dotfiles="tmux attach -t dotfiles"
alias otis="tmux attach -t otis"
alias orb="tmux attach -t orbslam"
