function proxy_off
    set -e https_proxy
    set -e http_proxy
    set -e all_proxy
    echo "🚫 Terminal Proxy: OFF"
end
