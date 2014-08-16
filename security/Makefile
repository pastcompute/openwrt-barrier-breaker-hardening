# Proof of concept.

TOPDIR:=${CURDIR}/..
SECDIR=$(TOPDIR)/security
CHECKSEC=$(SECDIR)/checksec.sh

include $(TOPDIR)/rules.mk
include $(TOPDIR)/include/image.mk


CHECK_DIR=$(STAGING_DIR)/security-check-rootfs


all:;
	@-rm -rf 
	@mkdir -p $(CHECK_DIR)
	@tar xzf $(BIN_DIR)/$(IMG_PREFIX)$(if $(PROFILE),-$(PROFILE))-rootfs.tar.gz -C $(CHECK_DIR)
	@cd $(CHECK_DIR) && \
	  bash "$(CHECKSEC)" --dir `pwd`/lib/ && \
	  bash "$(CHECKSEC)" --dir `pwd`/usr/lib/ && \
	  bash "$(CHECKSEC)" --dir `pwd`/sbin/ && \
	  bash "$(CHECKSEC)" --dir `pwd`/bin/ && \
	  bash "$(CHECKSEC)" --dir `pwd`/usr/sbin/ && \
	  bash "$(CHECKSEC)" --dir `pwd`/usr/bin/

