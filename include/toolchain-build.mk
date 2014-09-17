# 
# Copyright (C) 2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

override CONFIG_AUTOREBUILD=

REAL_STAGING_DIR_HOST:=$(STAGING_DIR_HOST)
STAGING_DIR_HOST:=$(TOOLCHAIN_DIR)
BUILD_DIR_HOST:=$(BUILD_DIR_TOOLCHAIN)

# Note the importance of PATH_PREFIX here, especially for the case of things like uClibc
# with a nested headers/ target.

ifneq ($(if $(CONFIG_SRC_TREE_OVERRIDE),$(wildcard $(PATH_PREFIX)/git-src)),)
  USE_GIT_TREE:=1
  override QUILT:=
  override HOST_UNPACK:=
endif

ifdef USE_GIT_TREE
define Host/Prepare/Default
	mkdir -p $(HOST_BUILD_DIR)
	ln -s $(CURDIR)/$(PATH_PREFIX)/git-src $(HOST_BUILD_DIR)/.git
	( cd $(HOST_BUILD_DIR); git checkout .)
endef

clean:
	-rm $(HOST_BUILD_DIR)/.git

endif

include $(INCLUDE_DIR)/host-build.mk

HOST_STAMP_PREPARED=$(HOST_BUILD_DIR)/.prepared

define FixupLibdir
	if [ -d $(1)/lib64 -a \! -L $(1)/lib64 ]; then \
		mkdir -p $(1)/lib; \
		mv $(1)/lib64/* $(1)/lib/; \
		rm -rf $(1)/lib64; \
	fi
	ln -sf lib $(1)/lib64
endef
