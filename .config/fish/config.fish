if status is-interactive
    # Commands to run in interactive sessions can go here
    neofetch
set -gx GTK_IM_MODULE fcitx
set -gx QT_IM_MODULE fcitx
set -gx XMODIFIERS @im=fcitx
set -gx SDL_IM_MODULE fcitx
set -gx CLUTTER_IM_MODULE fcitx

alias with-proxy='env http_proxy=http://127.0.0.1:7890 https_proxy=http://127.0.0.1:7890 socks5_proxy=http://127.0.0.1:7890'

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

end

