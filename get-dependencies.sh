#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    cmake     \
    iniparser \
    libdecor  \
    python    \
    sdl3

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package

# If the application needs to be manually built that has to be done down here
echo "Making nightly build of isle-portable..."
echo "---------------------------------------------------------------"
REPO="https://github.com/isledecomp/isle-portable"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone --recursive --depth 1 "$REPO" ./isle-portable
echo "$VERSION" > ~/version

cd ./isle-portable
mkdir -p build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release \
         -DCMAKE_INSTALL_PREFIX=/usr \
         -DDOWNLOAD_DEPENDENCIES=ON
make -j $(nproc)
make install
