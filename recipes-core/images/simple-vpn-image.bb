SUMMARY = "A small image for simple vpn gateway."

IMAGE_INSTALL = "packagegroup-core-boot ${CORE_IMAGE_EXTRA_INSTALL}"
IMAGE_INSTALL_append = " packagegroup-simple-vpn os-release"

IMAGE_LINGUAS = " "

LICENSE = "MIT"

# aparmor
# DNS
# DHCP

IMAGE_ROOTFS_SIZE ?= "8192"

inherit core-image extrausers

ROOT_DEFAULT_PASSWORD ?= "1SimpleVpn!"
DEFAULT_ADMIN_ACCOUNT ?= "vpnadmin"
DEFAULT_ADMIN_ACCOUNT_PASSWORD ?= "1SimpleVpn!"

EXTRA_USERS_PARAMS = "${@bb.utils.contains('DISABLE_ROOT', 'True', "usermod -L root;", "usermod -P '${ROOT_DEFAULT_PASSWORD}' root;", d)}"

EXTRA_USERS_PARAMS += "useradd  ${DEFAULT_ADMIN_ACCOUNT};" 
EXTRA_USERS_PARAMS += "usermod -P '${DEFAULT_ADMIN_ACCOUNT_PASSWORD}' ${DEFAULT_ADMIN_ACCOUNT};" 
EXTRA_USERS_PARAMS += "usermod -aG sudo  ${DEFAULT_ADMIN_ACCOUNT};" 
