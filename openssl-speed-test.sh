#!/bin/bash

echo "----------------------------------------------------"
echo "本程序会依次执行以下算法加密性能的测试："
echo "  AES-(128/256)-(CFB/CTR/GCM)"
echo "  Chacha20(-poly1305)"
echo "并横向对比输出结果"
echo "至于用途....看着办吧！"
echo "----------------------------------------------------"

openssl speed -evp aes-128-cfb > 128cfb.txt
openssl speed -evp aes-256-cfb > 256cfb.txt
openssl speed -evp aes-128-ctr > 128ctr.txt
openssl speed -evp aes-256-ctr > 256ctr.txt
openssl speed -evp aes-128-gcm > 128gcm.txt
openssl speed -evp aes-256-gcm > 256gcm.txt
openssl speed -evp chacha20 > c20.txt
openssl speed -evp chacha20-poly1305 > c20p1305.txt

echo "----------------------------------------------------"
echo "以下是测试结果，越高越好："
cat 128cfb.txt | tail - -n 2
cat 256cfb.txt | tail - -n 1
cat 128ctr.txt | tail - -n 1
cat 256ctr.txt | tail - -n 1
cat 128gcm.txt | tail - -n 1
cat 256gcm.txt | tail - -n 1
cat c20.txt | tail - -n 1
cat c20p1305.txt | tail - -n 1
echo "-----------------------------------------------------"

rm 128cfb.txt 
rm 256cfb.txt
rm 128ctr.txt
rm 256ctr.txt
rm 128gcm.txt
rm 256gcm.txt
rm c20.txt
rm c20p1305.txt

echo "测试结束"
