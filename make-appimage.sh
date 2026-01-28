#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q isle-portable-git | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/$HOME/.local/share/icons/hicolor/scalable/apps/org.legoisland.Isle.svg
export DESKTOP=/$HOME/.local/share/applications/org.legoisland.Isle.desktop
export DEPLOY_OPENGL=1
export DEPLOY_VULKAN=1

# Deploy dependencies
quick-sharun /$HOME/.local/bin/isle /usr/bin/isle-config
#/usr/lib/liblego1.so

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
