#!/bin/bash

download_path="download"

rm -rf $download_path
mkdir $download_path

# 下载 SmartDNS
echo "更新 SmartDNS"
git clone --depth 1 https://github.com/pymumu/openwrt-smartdns $download_path/openwrt-smartdns
git clone --depth 1 https://github.com/pymumu/luci-app-smartdns $download_path/luci-app-smartdns

# 下载 Passwall
echo "更新 Passwall"
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall $download_path/openwrt-passwall
mv $download_path/openwrt-passwall/luci-app-passwall $download_path/luci-app-passwall
rm -rf $download_path/openwrt-passwall

# 下载 Passwall Packages
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages $download_path/openwrt-passwall-packages
mv $download_path/openwrt-passwall-packages/* $download_path/
rm -rf $download_path/openwrt-passwall-packages

# 下载 argon主题
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon $download_path/luci-theme-argon
# 下载 argon-config
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config $download_path/luci-app-argon-config

# 清理 git 文件
find $download_path -type d -name ".git" -exec rm -rf {} \;
find $download_path -type d -name ".github" -exec rm -rf {} \;
find $download_path -type f -name ".gitignore" -exec rm -rf {} \;

# 将下载的软件包复制出来
for package_path in $download_path/*/; do
    package_name=$(basename $package_path)
    rm -rf $package_name
    echo "复制 $package_path 到 $package_name"
    cp -r $package_path $package_name
done

# 清理
rm -rf $download_path