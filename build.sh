#!/bin/bash

ws=$(pwd)

src=$ws/src
openwrt=openwrt

mkdir -p $src
cd $src

git config --global http.lowSpeedLimit 0
git config --global http.lowSpeedTime 999999
git config --global http.postBuffer 524288000

git config --global  ssh.lowSpeedLimit 0
git config --global  ssh.lowSpeedTime 999999
git config --global  ssh.postBuffer 524288000

git clone git://git.openwrt.org/openwrt/openwrt.git -b openwrt-18.06  $openwrt

cd $openwrt


du -lh --max-depth=1

./scripts/feeds update -a
./scripts/feeds install -a

touch ./.config
echo "CONFIG_TARGET_IMAGES_GZIP=y" >> ./.config

make defconfig

make download -j1|| make download -j1 V=s


make -j1 V=s|| make -j1 V=s

du -lh --max-depth=1
ls -lh .


