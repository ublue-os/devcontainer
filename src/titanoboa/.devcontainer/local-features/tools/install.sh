#!/usr/bin/bash

set -e

RPMS=(
    dosfstools
    erofs-utils
    grub2
    grub2-efi
    grub2-tools
    grub2-tools-extra
    shim
    squashfs-tools
    xorriso
)

if [[ $(uname -m) =~ x86_64 ]]; then
    RPMS+=(
        grub2-efi-x64
        grub2-efi-x64-cdboot
        grub2-efi-x64-modules
    )
elif [[ "$(uname -m)" =~ aarch64 ]]; then
    RPMS+=(grub2-efi-aa64-modules)
fi

dnf5 install -y "${RPMS[@]}"

# Cleanup
dnf5 clean all
