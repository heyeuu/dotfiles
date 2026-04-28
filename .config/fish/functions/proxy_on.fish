function proxy_on
    set -gx https_proxy http://127.0.0.1:6454
    set -gx http_proxy http://127.0.0.1:6454
    set -gx all_proxy socks5://127.0.0.1:6454
    set -gx NO_PROXY "localhost,127.0.0.1,::1"
    echo "📡 Terminal Proxy: ON (127.0.0.1:6454)"
end
