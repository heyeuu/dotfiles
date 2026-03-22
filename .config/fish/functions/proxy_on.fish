function proxy_on
    set -gx https_proxy http://127.0.0.1:7890
    set -gx http_proxy http://127.0.0.1:7890
    set -gx all_proxy socks5://127.0.0.1:7890
    set -gx NO_PROXY "localhost,127.0.0.1,::1,v2-as.pincc.ai"
    echo "📡 Terminal Proxy: ON (127.0.0.1:7890)"
end
