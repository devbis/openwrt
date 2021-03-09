# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2013 OpenWrt.org

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

#################################################
# Images
#################################################

DEVICE_VARS += MKUBIFS_OPTS UBOOT BOOT_SCRIPT

define Build/boot-overlay
	rm -rf $@.boot
	mkdir -p $@.boot

	$(CP) $@ $@.boot/$(IMG_PREFIX)-uImage
	ln -sf $(IMG_PREFIX)-uImage $@.boot/uImage

	$(foreach dts,$(DEVICE_DTS), \
		$(CP) \
			$(DTS_DIR)/$(dts).dtb \
			$@.boot/$(IMG_PREFIX)-$(dts).dtb; \
		ln -sf \
			$(IMG_PREFIX)-$(dts).dtb \
			$@.boot/$(dts).dtb; \
	)
	mkimage -A arm -O linux -T script -C none -a 0 -e 0 \
		-n '$(DEVICE_ID) OpenWrt bootscript' \
		-d ./bootscript-$(DEVICE_NAME) \
		$@.boot/6x_bootscript-$(DEVICE_NAME)

	$(STAGING_DIR_HOST)/bin/mkfs.ubifs \
		--space-fixup --compr=zlib --squash-uids \
		$(MKUBIFS_OPTS) -c 16248 \
		-o $@.boot.ubifs -d $@.boot

	$(TAR) -C $@.boot -cf $@.boot.tar .
endef

define Build/bootfs.tar.gz
	rm -rf $@.boot
	mkdir -p $@.boot

	$(TAR) -C $@.boot -xf $(IMAGE_KERNEL).boot.tar
	$(TAR) -C $@.boot \
		--numeric-owner --owner=0 --group=0 --transform "s,./,./boot/," \
		-czvf $@ .
endef

define Build/boot-scr
	mkimage -A arm -O linux -T script -C none -a 0 -e 0 \
	-n '$(DEVICE_ID) OpenWrt bootscript' \
	-d ./bootscript-$(DEVICE_NAME) \
	$(BIN_DIR)/boot.scr
endef

define Build/recovery-scr
	mkimage -A arm -O linux -T script -C none -a 0 -e 0 \
	-n '$(DEVICE_ID) OpenWrt recovery bootscript' \
	-d ./recovery-$(DEVICE_NAME) $@
endef

define Build/imx6-combined-image-prepare
	rm -rf $@.boot
	mkdir -p $@.boot
endef

define Build/imx6-combined-image-clean
	rm -rf $@.boot $@.fs
endef

define Build/imx6-combined-image
	$(CP) $(IMAGE_KERNEL) $@.boot/uImage

	$(foreach dts,$(DEVICE_DTS), \
		$(CP) \
			$(DTS_DIR)/$(dts).dtb \
			$@.boot/;
	)

	mkimage -A arm -O linux -T script -C none -a 0 -e 0 \
		-n '$(DEVICE_ID) OpenWrt bootscript' \
		-d $(BOOT_SCRIPT) \
		$@.boot/boot.scr

	cp $@ $@.fs

	$(SCRIPT_DIR)/gen_image_generic.sh $@ \
		$(CONFIG_TARGET_KERNEL_PARTSIZE) \
		$@.boot \
		$(CONFIG_TARGET_ROOTFS_PARTSIZE) \
		$@.fs \
		1024
endef

define Build/imx6-sdcard
	$(Build/imx6-combined-image-prepare)

	$(CP) $(STAGING_DIR_IMAGE)/$(UBOOT)-u-boot.img $@.boot/u-boot.img
	$(Build/imx6-combined-image)
	dd if=$(STAGING_DIR_IMAGE)/$(UBOOT)-SPL of=$@ bs=1024 seek=1 conv=notrunc

	$(Build/imx6-combined-image-clean)
endef

define Build/apalis-emmc
	$(Build/imx6-combined-image-prepare)
	$(Build/imx6-combined-image)
	$(Build/imx6-combined-image-clean)
endef

#################################################
# Devices
#################################################

KERNEL_LOADADDR=0x10008000

define Device/Default
  PROFILES := Generic
  FILESYSTEMS := squashfs ext4
  KERNEL_INSTALL := 1
  KERNEL_SUFFIX := -uImage
  KERNEL_NAME := zImage
  KERNEL := kernel-bin | uImage none
  IMAGES :=
endef


#################################################
# Subtarget devices
#################################################

include $(SUBTARGET).mk

$(eval $(call BuildImage))
