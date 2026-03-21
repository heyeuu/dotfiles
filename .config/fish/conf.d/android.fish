# --- Android SDK & Flutter 自动化环境管理 ---

# 1. 定义 SDK 根路径
set -l android_sdk_path /opt/android-sdk

if test -d $android_sdk_path
    # 2. 导出核心全局变量
    set -gx ANDROID_HOME $android_sdk_path
    set -gx ANDROID_SDK_ROOT $android_sdk_path

    # 3. 将基础工具加入 PATH (fish_add_path 会自动去重)
    fish_add_path $ANDROID_HOME/cmdline-tools/latest/bin
    fish_add_path $ANDROID_HOME/platform-tools

    # 4. 【动态检测】寻找已安装的最新的 build-tools 并加入 PATH
    if test -d $ANDROID_HOME/build-tools
        set -l installed_build_tools (ls -1 $ANDROID_HOME/build-tools | sort -V | tail -n 1)
        if test -n "$installed_build_tools"
            fish_add_path $ANDROID_HOME/build-tools/$installed_build_tools
        end
    end
end

# 5. 浏览器配置 (针对 Flutter Web 开发)
if test -f /usr/bin/google-chrome-stable
    set -gx CHROME_EXECUTABLE /usr/bin/google-chrome-stable
end

# 6. 网络代理优化 (彻底消除 flutter doctor 的 NO_PROXY 警告)
# 包含 IPv4 (127.0.0.1) 和 IPv6 (::1) 本地回环
set -gx NO_PROXY "localhost,127.0.0.1,::1"

# 在终端输入 'update-android-sdk' 即可自动补全缺失的平台镜像
function update-android-sdk
    set -l sdk_bin /opt/android-sdk/cmdline-tools/latest/bin/sdkmanager
    if test -f $sdk_bin
        echo "正在从远程仓库获取最新版本信息..."

        # 动态抓取当前最新的 platform 和 build-tools 版本号
        set -l latest_p ($sdk_bin --list | grep "platforms;android-" | cut -d'|' -f1 | tr -d ' ' | sort -V | tail -n 1)
        set -l latest_b ($sdk_bin --list | grep "build-tools;" | cut -d'|' -f1 | tr -d ' ' | sort -V | tail -n 1)

        echo "准备同步最新组件: $latest_p 和 $latest_b"

        # 使用 sudo 执行安装以确保有权限写入 /opt
        sudo $sdk_bin $latest_p $latest_b platform-tools

        # 安装完成后自动修正目录权限，确保 Flutter 能够正常读取
        sudo chown -R $USER:$USER /opt/android-sdk

        echo "更新完成！现在请运行 'flutter doctor' 验证。"
    else
        echo "错误: 找不到 sdkmanager，请检查 /opt/android-sdk 是否已正确安装。"
    end
end
