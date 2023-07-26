#!/bin/bash
clear
echo "----------------------------------------------------"
echo "本程序会依次执行以下算法加密性能的测试："
echo "  RC4  BF-CFB"
echo "  AES-(128/256)-(CFB/CTR/GCM)"
echo "  Chacha20(-poly1305)"
echo "并横向对比输出结果"
echo "至于用途....看着办吧！"
echo "----------------------------------------------------"

if [ "$1" == "full" ]; then
    openssl speed -evp rc4 > rc4.txt
    openssl speed -evp bf-cfb > bfcfb.txt
    openssl speed -evp aes-128-cfb > 128cfb.txt
    openssl speed -evp aes-256-cfb > 256cfb.txt
    openssl speed -evp aes-128-ctr > 128ctr.txt
    openssl speed -evp aes-256-ctr > 256ctr.txt
    openssl speed -evp chacha20 > c20.txt
else
    echo -e "\e[1;32m"
    echo "当前未选择完整测试，仅测试常用（带AEAD的）加密算法"
    echo "如需完整测试，请带上 full 参数"
    echo -e "\e[0m"
fi
openssl speed -evp aes-128-gcm > 128gcm.txt
openssl speed -evp aes-256-gcm > 256gcm.txt
openssl speed -evp chacha20-poly1305 > c20p1305.txt

echo "----------------------------------------------------"
echo "以下是测试结果，越高越好："
if [ "$1" == "full" ]; then
    cat rc4.txt | tail - -n 2
    cat bfcfb.txt | tail - -n 1
    cat 128cfb.txt | tail - -n 1
    cat 256cfb.txt | tail - -n 1
    cat 128ctr.txt | tail - -n 1
    cat 256ctr.txt | tail - -n 1
    cat c20.txt | tail - -n 1
    cat 128gcm.txt | tail - -n 1
else
    cat 128gcm.txt | tail - -n 2
fi
cat 256gcm.txt | tail - -n 1
cat c20p1305.txt | tail - -n 1
echo "-----------------------------------------------------"

if [ "$1" == "full" ]; then
    rm rc4.txt 
    rm bfcfb.txt
    rm 128cfb.txt 
    rm 256cfb.txt
    rm 128ctr.txt
    rm 256ctr.txt
    rm c20.txt
fi

rm 128gcm.txt
rm 256gcm.txt
rm c20p1305.txt

echo "测试结束"
