#################################################
# Subtarget generic
#################################################


define Device/ventana
  DEVICE_VENDOR := Gateworks
  DEVICE_MODEL := Ventana family
  DEVICE_VARIANT := normal NAND flash
  DEVICE_DTS:= \
	imx6dl-gw51xx \
	imx6dl-gw52xx \
	imx6dl-gw53xx \
	imx6dl-gw54xx \
	imx6dl-gw551x \
	imx6dl-gw552x \
	imx6dl-gw553x \
	imx6dl-gw5904 \
	imx6dl-gw5907 \
	imx6dl-gw5910 \
	imx6dl-gw5912 \
	imx6dl-gw5913 \
	imx6q-gw51xx \
	imx6q-gw52xx \
	imx6q-gw53xx \
	imx6q-gw54xx \
	imx6q-gw5400-a \
	imx6q-gw551x \
	imx6q-gw552x \
	imx6q-gw553x \
	imx6q-gw5904 \
	imx6q-gw5907 \
	imx6q-gw5910 \
	imx6q-gw5912 \
	imx6q-gw5913
  DEVICE_PACKAGES := kmod-sky2 kmod-sound-core kmod-sound-soc-imx kmod-sound-soc-imx-sgtl5000 \
	kmod-can kmod-can-flexcan kmod-can-raw \
	kmod-hwmon-gsc \
	kmod-leds-gpio kmod-pps-gpio \
	kobs-ng
  KERNEL += | boot-overlay
  IMAGES := nand.ubi bootfs.tar.gz dtb
  IMAGE_NAME = $$(IMAGE_PREFIX)-$$(1).$$(2)
  UBINIZE_PARTS = boot=$$(KDIR_KERNEL_IMAGE).boot.ubifs=15
  BOOT_SCRIPT := bootscript-ventana
  IMAGE/nand.ubi := append-ubi
  IMAGE/bootfs.tar.gz := bootfs.tar.gz
  IMAGE/dtb := install-dtb
  IMAGE_NAME = $$(IMAGE_PREFIX)-$$(1)-$$(2)
  PAGESIZE := 2048
  BLOCKSIZE := 128k
  MKUBIFS_OPTS := -m $$(PAGESIZE) -e 124KiB
endef
TARGET_DEVICES += ventana

define Device/ventana-large
  $(Device/ventana)
  DEVICE_VENDOR := Gateworks
  DEVICE_MODEL := Ventana family
  DEVICE_VARIANT := large NAND flash
  DEVICE_NAME := ventana
  IMAGES := nand.ubi
  PAGESIZE := 4096
  BLOCKSIZE := 256k
  MKUBIFS_OPTS := -m $$(PAGESIZE) -e 248KiB
endef
TARGET_DEVICES += ventana-large

define Device/wandboard
  DEVICE_VENDOR := Wandboard
  DEVICE_MODEL := Dual
  DEVICE_DTS := imx6dl-wandboard
endef
TARGET_DEVICES += wandboard
#################################################
# Subtarget devices
#################################################

define Device/cubox-i
  DEVICE_VENDOR := SolidRun
  DEVICE_MODEL := CuBox-i
  KERNEL := kernel-bin
  UBOOT := mx6cuboxi
  BOOT_SCRIPT = bootscript-cubox
  DEVICE_NAME := cubox
  DEVICE_PACKAGES := kmod-drm-imx kmod-drm-imx-hdmi kmod-usb-hid
  DEVICE_DTS := imx6q-cubox-i imx6dl-cubox-i imx6q-hummingboard imx6dl-hummingboard
  IMAGES := combined.bin dtb
  FILESYSTEMS := squashfs
  IMAGE/combined.bin := append-rootfs | pad-extra 128k | imx6-sdcard
  IMAGE/dtb := install-dtb
endef
TARGET_DEVICES += cubox-i
include $(SUBTARGET).mk

define Device/apalis
  DEVICE_VENDOR := Toradex
  DEVICE_MODEL := Apalis family
  SUPPORTED_DEVICES := apalis,ixora apalis,eval
  DEVICE_DTS := \
	  imx6q-apalis-eval \
	  imx6q-apalis-ixora \
	  imx6q-apalis-ixora-v1.1
  DEVICE_PACKAGES := \
	kmod-can kmod-can-flexcan kmod-can-raw \
	kmod-leds-gpio kmod-gpio-button-hotplug \
	kmod-pps-gpio kmod-rtc-ds1307
  BOOT_SCRIPT := bootscript-apalis
  UBOOT := apalis_imx6
  FILESYSTEMS := squashfs
  IMAGES := combined.bin sysupgrade.bin
  IMAGE_NAME = $$(IMAGE_PREFIX)-$$(1).$$(2)
  IMAGE/combined.bin := append-rootfs | pad-extra 128k | apalis-emmc
  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
  ARTIFACTS := recovery.scr
  ARTIFACT/recovery.scr := recovery-scr
endef
TARGET_DEVICES += apalis


