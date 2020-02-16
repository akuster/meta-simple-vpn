SUMMARY = "A small image for simple vpn gateway."

IMAGE_INSTALL = "packagegroup-core-boot ${CORE_IMAGE_EXTRA_INSTALL}"
IMAGE_INSTALL_append = " packagegroup-simple-vpn os-release"

IMAGE_FEATURES = ""
IMAGE_LINGUAS = " "

LICENSE = "MIT"

IMAGE_ROOTFS_SIZE ?= "8192"

inherit core-image extrausers

ROOT_DEFAULT_PASSWORD ?= "1SimpleVpn!"
DEFAULT_ADMIN_ACCOUNT ?= "vpnadmin"
DEFAULT_ADMIN_GROUP ?= "wheel"
DEFAULT_ADMIN_ACCOUNT_PASSWORD ?= "1SimpleVpn!"

EXTRA_USERS_PARAMS = "${@bb.utils.contains('DISABLE_ROOT', 'True', "usermod -L root;", "usermod -P '${ROOT_DEFAULT_PASSWORD}' root;", d)}"

EXTRA_USERS_PARAMS += "useradd  ${DEFAULT_ADMIN_ACCOUNT};" 
EXTRA_USERS_PARAMS += "groupadd  ${DEFAULT_ADMIN_GROUP};" 
EXTRA_USERS_PARAMS += "usermod -P '${DEFAULT_ADMIN_ACCOUNT_PASSWORD}' ${DEFAULT_ADMIN_ACCOUNT};" 
EXTRA_USERS_PARAMS += "usermod -aG ${DEFAULT_ADMIN_GROUP}  ${DEFAULT_ADMIN_ACCOUNT};" 
