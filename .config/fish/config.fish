# 定义环境变量 (使用 -gx 确保全局且导出)
# set -gx http_proxy http://127.0.0.1:7890
# set -gx https_proxy http://127.0.0.1:7890

# 定义 Alias
# alias with-proxy='env http_proxy=http://127.0.0.1:7890 https_proxy=http://127.0.0.1:7890 socks5_proxy=http://127.0.0.1:7890'

# 交互式会话专用配置
if status is-interactive
    alias dotgit 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    complete -c dotgit -w git
end

# XDG_RUNTIME_DIR 设置
if not set -q XDG_RUNTIME_DIR
    set -l user_id (id -u)
    set -gx XDG_RUNTIME_DIR "/run/user/$user_id"

    if not test -d $XDG_RUNTIME_DIR
        mkdir -p $XDG_RUNTIME_DIR
        chmod 0700 $XDG_RUNTIME_DIR
    end
end

# 加载私密变量
if test -f ~/.config/fish/secrets/api_keys
    source ~/.config/fish/secrets/api_keys
end

# 自动切换Node版本
fnm env --use-on-cd | source
