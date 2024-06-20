#!/bin/bash

source /etc/os-release
set -ex

if [ "$VERSION_CODENAME" == "focal" ]; then
    echo '[ -f /tools/Xilinx/PetaLinux/2022.2/settings.sh ] && source /tools/Xilinx/PetaLinux/2022.2/settings.sh' >>~/.bashrc
fi

if [ "$VERSION_CODENAME" == "jammy" ]; then
    echo '[ -f /tools/Xilinx/PetaLinux/2023.2/settings.sh ] && source /tools/Xilinx/PetaLinux/2023.2/settings.sh' >>~/.bashrc
fi
