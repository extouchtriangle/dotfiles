if status is-interactive
    export PATH=/usr/local/texlive/2024/bin/x86_64-linux:/usr/local/texlive/2024/bin/x86_64-linux:/usr/condabin:/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/sbin:/opt/cuda/bin:/opt/cuda/nsight_compute:/opt/cuda/nsight_systems/bin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.local/bin:$HOME/.local/share/gem/ruby/3.2.0/bin:$HOME/.py-prompts:/root/.local/bin:$HOME/.local/share/gem/ruby/3.3.0/bin:$HOME/.gem/ruby/3.3.0/bin:/var/lib/snapd/snap/bin
    cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
end
export VISUAL=nvim
export TERMINAL=kitty
export TERM=kitty
export EDITOR="$VISUAL"
# Created by `pipx` on 2024-09-07 18:06:26
set PATH $PATH $HOME/.local/bin
set PATH $PATH $HOME/.local/share/gem/ruby/3.2.0/bin
# TokyoNight Color Palette
export CC=/sbin/gcc
export CXX=/sbin/g++

alias i3conf="nvim -c 'ChezmoiEdit ~/.config/i3/config'"
alias fishconf="nvim -c 'ChezmoiEdit ~/.config/fish/config.fish'"
alias kittyconf="nvim -c 'ChezmoiEdit ~/.config/kitty/kitty.conf'"
alias epddir="cd $HOME/Documents/EPD"
function zath
    zathura $argv -l error &
    disown %1
    sleep 0.2
    ydotool key 39:1 39:0
end
function ev
    evince $argv &
    disown %1
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
    export PF_INFO="ascii title os host kernel memory de shell palette"
    pfetch
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
abbr s yesman -S
abbr S pikaur -S
abbr t try-to-install
abbr syu yesman -Syu
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
alias codium="DONT_PROMPT_WSL_INSTALL=1 vscodium"
function wifi-on
    iwctl adapter phy0 set-property Powered on
    iwctl device wlan0 set-property Powered on
    rfkill unblock all
end
function try-to-install
    sudo pacman -S $argv
    pikaur -S $argv
    pikaur -S $argv"-git"
end
function otisweb
    awrit otis.evanchen.cc/dash/portal/1860
end
function classroom
    awrit classroom.google.com
end
function gmail
    awrit mail.google.com
end
function weather
    curl wttr.in
end
abbr otw otisweb
function ticonnect
    wine ~/.wine/drive_c/Program\ Files/TI\ Education/TI\ Connect\ CE/TI\ Connect\ CE.exe
end
function scan
    hp-scan --size letter --device hpaio:/net/DeskJet_2700_series?ip=192.168.1.154
end
function virenv
    source bin/activate.fish
end
alias su="sudo su" # so that i can use howdy

complete -c eww -n __fish_use_subcommand -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n __fish_use_subcommand -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n __fish_use_subcommand -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n __fish_use_subcommand -l logs -d 'Watch the log output after executing the command'
complete -c eww -n __fish_use_subcommand -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n __fish_use_subcommand -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n __fish_use_subcommand -s h -l help -d 'Print help'
complete -c eww -n __fish_use_subcommand -s V -l version -d 'Print version'
complete -c eww -n __fish_use_subcommand -f -a shell-completions -d 'Generate a shell completion script'
complete -c eww -n __fish_use_subcommand -f -a daemon -d 'Start the Eww daemon'
complete -c eww -n __fish_use_subcommand -f -a logs -d 'Print and watch the eww logs'
complete -c eww -n __fish_use_subcommand -f -a ping -d 'Ping the eww server, checking if it is reachable'
complete -c eww -n __fish_use_subcommand -f -a update -d 'Update the value of a variable, in a running eww instance'
complete -c eww -n __fish_use_subcommand -f -a inspector -d 'Open the GTK debugger'
complete -c eww -n __fish_use_subcommand -f -a open -d 'Open a window'
complete -c eww -n __fish_use_subcommand -f -a open-many -d 'Open multiple windows at once. NOTE: This will in the future be part of eww open, and will then be removed'
complete -c eww -n __fish_use_subcommand -f -a close -d 'Close the given windows'
complete -c eww -n __fish_use_subcommand -f -a reload -d 'Reload the configuration'
complete -c eww -n __fish_use_subcommand -f -a kill -d 'Kill the eww daemon'
complete -c eww -n __fish_use_subcommand -f -a close-all -d 'Close all windows, without killing the daemon'
complete -c eww -n __fish_use_subcommand -f -a state -d 'Prints the variables used in all currently open window'
complete -c eww -n __fish_use_subcommand -f -a get -d 'Get the value of a variable if defined'
complete -c eww -n __fish_use_subcommand -f -a list-windows -d 'List the names of active windows'
complete -c eww -n __fish_use_subcommand -f -a active-windows -d 'Show active window IDs, formatted linewise `<window_id>: <window_name>`'
complete -c eww -n __fish_use_subcommand -f -a debug -d 'Print out the widget structure as seen by eww'
complete -c eww -n __fish_use_subcommand -f -a graph -d 'Print out the scope graph structure in graphviz dot format'
complete -c eww -n __fish_use_subcommand -f -a help -d 'Print this message or the help of the given subcommand(s)'
complete -c eww -n "__fish_seen_subcommand_from shell-completions" -s s -l shell -r -f -a "{bash	'',elvish	'',fish	'',powershell	'',zsh	''}"
complete -c eww -n "__fish_seen_subcommand_from shell-completions" -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n "__fish_seen_subcommand_from shell-completions" -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n "__fish_seen_subcommand_from shell-completions" -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n "__fish_seen_subcommand_from shell-completions" -l logs -d 'Watch the log output after executing the command'
complete -c eww -n "__fish_seen_subcommand_from shell-completions" -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n "__fish_seen_subcommand_from shell-completions" -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n "__fish_seen_subcommand_from shell-completions" -s h -l help -d 'Print help'
complete -c eww -n "__fish_seen_subcommand_from daemon" -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n "__fish_seen_subcommand_from daemon" -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n "__fish_seen_subcommand_from daemon" -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n "__fish_seen_subcommand_from daemon" -l logs -d 'Watch the log output after executing the command'
complete -c eww -n "__fish_seen_subcommand_from daemon" -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n "__fish_seen_subcommand_from daemon" -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n "__fish_seen_subcommand_from daemon" -s h -l help -d 'Print help'
complete -c eww -n "__fish_seen_subcommand_from logs" -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n "__fish_seen_subcommand_from logs" -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n "__fish_seen_subcommand_from logs" -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n "__fish_seen_subcommand_from logs" -l logs -d 'Watch the log output after executing the command'
complete -c eww -n "__fish_seen_subcommand_from logs" -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n "__fish_seen_subcommand_from logs" -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n "__fish_seen_subcommand_from logs" -s h -l help -d 'Print help'
complete -c eww -n "__fish_seen_subcommand_from ping" -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n "__fish_seen_subcommand_from ping" -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n "__fish_seen_subcommand_from ping" -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n "__fish_seen_subcommand_from ping" -l logs -d 'Watch the log output after executing the command'
complete -c eww -n "__fish_seen_subcommand_from ping" -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n "__fish_seen_subcommand_from ping" -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n "__fish_seen_subcommand_from ping" -s h -l help -d 'Print help'
complete -c eww -n "__fish_seen_subcommand_from update" -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n "__fish_seen_subcommand_from update" -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n "__fish_seen_subcommand_from update" -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n "__fish_seen_subcommand_from update" -l logs -d 'Watch the log output after executing the command'
complete -c eww -n "__fish_seen_subcommand_from update" -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n "__fish_seen_subcommand_from update" -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n "__fish_seen_subcommand_from update" -s h -l help -d 'Print help'
complete -c eww -n "__fish_seen_subcommand_from inspector" -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n "__fish_seen_subcommand_from inspector" -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n "__fish_seen_subcommand_from inspector" -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n "__fish_seen_subcommand_from inspector" -l logs -d 'Watch the log output after executing the command'
complete -c eww -n "__fish_seen_subcommand_from inspector" -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n "__fish_seen_subcommand_from inspector" -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n "__fish_seen_subcommand_from inspector" -s h -l help -d 'Print help'
complete -c eww -n "__fish_seen_subcommand_from open" -l id -r
complete -c eww -n "__fish_seen_subcommand_from open" -l screen -d 'The identifier of the monitor the window should open on' -r
complete -c eww -n "__fish_seen_subcommand_from open" -s p -l pos -d 'The position of the window, where it should open. (i.e.: 200x100)' -r
complete -c eww -n "__fish_seen_subcommand_from open" -s s -l size -d 'The size of the window to open (i.e.: 200x100)' -r
complete -c eww -n "__fish_seen_subcommand_from open" -s a -l anchor -d 'Sidepoint of the window, formatted like "top right"' -r
complete -c eww -n "__fish_seen_subcommand_from open" -l duration -d 'Automatically close the window after a specified amount of time, i.e.: 1s' -r
complete -c eww -n "__fish_seen_subcommand_from open" -l arg -d 'Define a variable for the window, i.e.: `--arg "var_name=value"`' -r
complete -c eww -n "__fish_seen_subcommand_from open" -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n "__fish_seen_subcommand_from open" -l toggle -d 'If the window is already open, close it instead'
complete -c eww -n "__fish_seen_subcommand_from open" -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n "__fish_seen_subcommand_from open" -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n "__fish_seen_subcommand_from open" -l logs -d 'Watch the log output after executing the command'
complete -c eww -n "__fish_seen_subcommand_from open" -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n "__fish_seen_subcommand_from open" -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n "__fish_seen_subcommand_from open" -s h -l help -d 'Print help'
complete -c eww -n "__fish_seen_subcommand_from open-many" -l arg -d 'Define a variable for the window, i.e.: `--arg "window_id:var_name=value"`' -r
complete -c eww -n "__fish_seen_subcommand_from open-many" -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n "__fish_seen_subcommand_from open-many" -l toggle -d 'If a window is already open, close it instead'
complete -c eww -n "__fish_seen_subcommand_from open-many" -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n "__fish_seen_subcommand_from open-many" -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n "__fish_seen_subcommand_from open-many" -l logs -d 'Watch the log output after executing the command'
complete -c eww -n "__fish_seen_subcommand_from open-many" -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n "__fish_seen_subcommand_from open-many" -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n "__fish_seen_subcommand_from open-many" -s h -l help -d 'Print help'
complete -c eww -n "__fish_seen_subcommand_from close" -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n "__fish_seen_subcommand_from close" -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n "__fish_seen_subcommand_from close" -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n "__fish_seen_subcommand_from close" -l logs -d 'Watch the log output after executing the command'
complete -c eww -n "__fish_seen_subcommand_from close" -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n "__fish_seen_subcommand_from close" -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n "__fish_seen_subcommand_from close" -s h -l help -d 'Print help'
complete -c eww -n "__fish_seen_subcommand_from reload" -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n "__fish_seen_subcommand_from reload" -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n "__fish_seen_subcommand_from reload" -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n "__fish_seen_subcommand_from reload" -l logs -d 'Watch the log output after executing the command'
complete -c eww -n "__fish_seen_subcommand_from reload" -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n "__fish_seen_subcommand_from reload" -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n "__fish_seen_subcommand_from reload" -s h -l help -d 'Print help'
complete -c eww -n "__fish_seen_subcommand_from kill" -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n "__fish_seen_subcommand_from kill" -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n "__fish_seen_subcommand_from kill" -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n "__fish_seen_subcommand_from kill" -l logs -d 'Watch the log output after executing the command'
complete -c eww -n "__fish_seen_subcommand_from kill" -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n "__fish_seen_subcommand_from kill" -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n "__fish_seen_subcommand_from kill" -s h -l help -d 'Print help'
complete -c eww -n "__fish_seen_subcommand_from close-all" -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n "__fish_seen_subcommand_from close-all" -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n "__fish_seen_subcommand_from close-all" -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n "__fish_seen_subcommand_from close-all" -l logs -d 'Watch the log output after executing the command'
complete -c eww -n "__fish_seen_subcommand_from close-all" -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n "__fish_seen_subcommand_from close-all" -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n "__fish_seen_subcommand_from close-all" -s h -l help -d 'Print help'
complete -c eww -n "__fish_seen_subcommand_from state" -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n "__fish_seen_subcommand_from state" -s a -l all -d 'Shows all variables, including not currently used ones'
complete -c eww -n "__fish_seen_subcommand_from state" -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n "__fish_seen_subcommand_from state" -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n "__fish_seen_subcommand_from state" -l logs -d 'Watch the log output after executing the command'
complete -c eww -n "__fish_seen_subcommand_from state" -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n "__fish_seen_subcommand_from state" -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n "__fish_seen_subcommand_from state" -s h -l help -d 'Print help'
complete -c eww -n "__fish_seen_subcommand_from get" -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n "__fish_seen_subcommand_from get" -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n "__fish_seen_subcommand_from get" -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n "__fish_seen_subcommand_from get" -l logs -d 'Watch the log output after executing the command'
complete -c eww -n "__fish_seen_subcommand_from get" -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n "__fish_seen_subcommand_from get" -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n "__fish_seen_subcommand_from get" -s h -l help -d 'Print help'
complete -c eww -n "__fish_seen_subcommand_from list-windows" -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n "__fish_seen_subcommand_from list-windows" -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n "__fish_seen_subcommand_from list-windows" -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n "__fish_seen_subcommand_from list-windows" -l logs -d 'Watch the log output after executing the command'
complete -c eww -n "__fish_seen_subcommand_from list-windows" -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n "__fish_seen_subcommand_from list-windows" -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n "__fish_seen_subcommand_from list-windows" -s h -l help -d 'Print help'
complete -c eww -n "__fish_seen_subcommand_from active-windows" -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n "__fish_seen_subcommand_from active-windows" -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n "__fish_seen_subcommand_from active-windows" -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n "__fish_seen_subcommand_from active-windows" -l logs -d 'Watch the log output after executing the command'
complete -c eww -n "__fish_seen_subcommand_from active-windows" -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n "__fish_seen_subcommand_from active-windows" -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n "__fish_seen_subcommand_from active-windows" -s h -l help -d 'Print help'
complete -c eww -n "__fish_seen_subcommand_from debug" -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n "__fish_seen_subcommand_from debug" -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n "__fish_seen_subcommand_from debug" -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n "__fish_seen_subcommand_from debug" -l logs -d 'Watch the log output after executing the command'
complete -c eww -n "__fish_seen_subcommand_from debug" -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n "__fish_seen_subcommand_from debug" -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n "__fish_seen_subcommand_from debug" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c eww -n "__fish_seen_subcommand_from graph" -s c -l config -d 'override path to configuration directory (directory that contains eww.yuck and eww.(s)css)' -r -F
complete -c eww -n "__fish_seen_subcommand_from graph" -l debug -d 'Write out debug logs. (To read the logs, run `eww logs`)'
complete -c eww -n "__fish_seen_subcommand_from graph" -l force-wayland -d 'Force eww to use wayland. This is a no-op if eww was compiled without wayland support'
complete -c eww -n "__fish_seen_subcommand_from graph" -l logs -d 'Watch the log output after executing the command'
complete -c eww -n "__fish_seen_subcommand_from graph" -l no-daemonize -d 'Avoid daemonizing eww'
complete -c eww -n "__fish_seen_subcommand_from graph" -l restart -d 'Restart the daemon completely before running the command'
complete -c eww -n "__fish_seen_subcommand_from graph" -s h -l help -d 'Print help'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a shell-completions -d 'Generate a shell completion script'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a daemon -d 'Start the Eww daemon'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a logs -d 'Print and watch the eww logs'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a ping -d 'Ping the eww server, checking if it is reachable'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a update -d 'Update the value of a variable, in a running eww instance'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a inspector -d 'Open the GTK debugger'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a open -d 'Open a window'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a open-many -d 'Open multiple windows at once. NOTE: This will in the future be part of eww open, and will then be removed'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a close -d 'Close the given windows'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a reload -d 'Reload the configuration'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a kill -d 'Kill the eww daemon'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a close-all -d 'Close all windows, without killing the daemon'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a state -d 'Prints the variables used in all currently open window'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a get -d 'Get the value of a variable if defined'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a list-windows -d 'List the names of active windows'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a active-windows -d 'Show active window IDs, formatted linewise `<window_id>: <window_name>`'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a debug -d 'Print out the widget structure as seen by eww'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a graph -d 'Print out the scope graph structure in graphviz dot format'
complete -c eww -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from shell-completions; and not __fish_seen_subcommand_from daemon; and not __fish_seen_subcommand_from logs; and not __fish_seen_subcommand_from ping; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from inspector; and not __fish_seen_subcommand_from open; and not __fish_seen_subcommand_from open-many; and not __fish_seen_subcommand_from close; and not __fish_seen_subcommand_from reload; and not __fish_seen_subcommand_from kill; and not __fish_seen_subcommand_from close-all; and not __fish_seen_subcommand_from state; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from list-windows; and not __fish_seen_subcommand_from active-windows; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from graph; and not __fish_seen_subcommand_from help" -f -a help -d 'Print this message or the help of the given subcommand(s)'
alias ts="task sync"
