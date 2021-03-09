#

define Device/lumi
  DEVICE_VENDOR := Xiaomi
  DEVICE_MODEL := Lumi Gateway
  DEVICE_VARIANT := DGNWG05LM
  DEVICE_NAME := xiaomi,gateway-lumi
  DEVICE_PACKAGES := kmod-rtl8723bs rtl8723bs-firmware kmod-bluetooth \
  	kmod-sound-core kmod-button-hotplug kmod-bluetooth \
  	bluez-daemon bluez-libs bluez-utils alsa-utils hostapd \
  	wpa-supplicant ca-certificates kmod-gpio-button-hotplug \
  	kmod-i2c-core kmod-iio-core

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
