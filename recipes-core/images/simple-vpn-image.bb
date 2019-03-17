SUMMARY = "A small image for simple vpn gateway."

IMAGE_INSTALL = "packagegroup-core-boot ${CORE_IMAGE_EXTRA_INSTALL}"
IMAGE_INSTALL_append = " packagegroup-simple-vpn os-release"

IMAGE_LINGUAS = " "

LICENSE = "MIT"

DISTRO_FEATURES_append = " ipv6 ipsec" 

# aparmor
# DNS
# DHCP

IMAGE_ROOTFS_SIZE ?= "8192"

inherit core-image extrausers
EXTRA_USERS_PARAMS = "usermod -P 1SimpleVpn! root;"
DISTRO_FEATURES_remove = "x11"
