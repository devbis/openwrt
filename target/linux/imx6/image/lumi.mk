#

define Device/lumi
  DEVICE_VENDOR := Xiaomi
  DEVICE_MODEL := Lumi Gateway
  DEVICE_VARIANT := DGNWG05LM
  DEVICE_NAME := xiaomi,gateway-lumi
  DEVICE_PACKAGES := kmod-rtl8723bs

  KERNEL_INSTALL := 0
  KERNEL_NAME := zImage
  KERNEL_SUFFIX := -zImage
  KERNEL := kernel-bin
  IMAGES := sysupgrade.bin dtb rootfs.bin
  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
  IMAGE/rootfs.bin := append-rootfs
  IMAGE/dtb := install-dtb

  DEVICE_DTS:= \
	imx6ull-xiaomi-lumi
endef
TARGET_DEVICES += lumi

define Device/aqara
  DEVICE_VENDOR := Xiaomi
  DEVICE_MODEL := Lumi Aqara Gateway
  DEVICE_VARIANT := ZHWG11LM
  DEVICE_NAME := xiaomi,gateway-aqara
  DEVICE_PACKAGES := kmod-rtl8189es

  KERNEL_INSTALL := 0
  KERNEL_NAME := zImage
  KERNEL_SUFFIX := -zImage
  KERNEL := kernel-bin
  IMAGES := sysupgrade.bin dtb rootfs.bin
  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
  IMAGE/rootfs.bin := append-rootfs
  IMAGE/dtb := install-dtb

  DEVICE_DTS:= \
	imx6ull-xiaomi-lumi
endef
TARGET_DEVICES += aqara

