#
# Copyright 2015 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#

GO_2G := true
KERNEL_PATH := kernel4.14
export KERNEL_PATH

$(call inherit-product, device/sprd/sharkle/sp9832e_1h10_go/sp9832e_1h10_go_base.mk)
PLATDIR := device/sprd/sharkle
TARGET_BOARD := sp9832e_1h10_go
BOARDDIR := $(PLATDIR)/$(TARGET_BOARD)
PLATCOMM := $(PLATDIR)/common
ROOTDIR := $(BOARDDIR)/rootdir
WPDIR := vendor/sprd/resource/wallpapers/HD
TARGET_BOARD_PLATFORM := sp9832e

TARGET_GPU_PLATFORM := midgard

TARGET_BOOTLOADER_BOARD_NAME := sp9832e_1h10_32b
CHIPRAM_DEFCONFIG := sp9832e_1h10_32b
UBOOT_DEFCONFIG := sp9832e_1h10_32b
UBOOT_TARGET_DTB := sp9832e_1h10_32b

PRODUCT_NAME := sp9832e_1h10_go2g
PRODUCT_DEVICE := sp9832e_1h10_go
PRODUCT_BRAND := SPRD
PRODUCT_MODEL := sp9832e_1h10_go2g
PRODUCT_WIFI_DEVICE := sprd
PRODUCT_MANUFACTURER := sprd

DEVICE_PACKAGE_OVERLAYS := $(BOARDDIR)/overlay $(PLATDIR)/overlay $(PLATCOMM)/overlay $(WPDIR)/overlay

#Runtime Overlay Packages
PRODUCT_ENFORCE_RRO_TARGETS := \
    framework-res

#TARGET_ARCH := arm64
#TARGET_ARCH_VARIANT := armv8-a
#TARGET_CPU_ABI := arm64-v8a
#TARGET_CPU_VARIANT := generic

#TARGET_2ND_ARCH := arm
#TARGET_2ND_ARCH_VARIANT := armv7-a-neon
#TARGET_2ND_CPU_VARIANT := cortex-a15
#TARGET_2ND_CPU_ABI := armeabi-v7a
#TARGET_2ND_CPU_ABI2 := armeabi

TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := generic
#CONFIG_64KERNEL_32FRAMEWORK := true

TARGET_USES_64_BIT_BINDER := true

#secure boot
BOARD_SECBOOT_CONFIG := true

BOARD_TEE_CONFIG := trusty

#add for sunwave fingerprint
BOARD_FINGERPRINT_CONFIG := sunwave

CFG_TRUSTY_DEFAULT_PROJECT := sharkle-lowmemory
$(call inherit-product, $(PLATCOMM)/security_feature.mk)

#enable 3dnr
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.3dnr.version=1

PRODUCT_COPY_FILES += \
    $(BOARDDIR)/sp9832e_1h10_go.xml:$(PRODUCT_OUT)/sp9832e_1h10.xml

PRODUCT_AAPT_CONFIG := normal large xlarge mdpi 420dpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi
PRODUCT_AAPT_PREBUILT_DPI := 320hdpi xhdpi
TARGET_SYSTEM_PROP += $(wildcard $(TARGET_DEVICE_DIR)/system.prop)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
include build/make/target/product/go_defaults_common_speed_compile.mk
PRODUCT_PACKAGES += SprdDialerGo

#Bringup use 1G
CHIPRAM_DDR_1G_LIMITED := true
# 512
#CHIPRAM_DDR_512M_LIMITED := true
CHIPRAM_DDR_CUSTOMIZE_LIMITED := true
CHIPRAM_DDR_CUSTOMIZE_SIZE := 0x40000000

#Display/Graphic config
PRODUCT_PROPERTY_OVERRIDES += \
      ro.sf.lcd_density=320 \
      ro.vendor.sf.lcd_width=54 \
      ro.vendor.sf.lcd_height=96 \
      ro.opengles.version=196610

#enable blur mode
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.cam.ba.blur.version=1 \
    persist.vendor.cam.fr.blur.version=1 \
    persist.vendor.cam.blur.cov.id=3
#MMI main menu camera calibration & verification entry: 0-not display, 1-display
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.multicam.cali.veri=0

#enable back portrait mode
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.ba.portrait.enable=0
#enable front portrait mode
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.fr.portrait.enable=0
#enable hdr_zsl
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.hdr.zsl=1
#faceid feature
FACEID_FEATURE_SUPPORT := true
#enable faceID
TARGET_BOARD_FACE_UNLOCK_SUPPORT := true
$(call inherit-product-if-exists, vendor/sprd/modules/faceunlock/faceunlock_device.mk)

#faceid version    0--disable  1--single_camera  2--dual_camera
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.cam.faceid.version=1

#camera filter and beauty
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.facebeauty.corp=2

PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI

#NativeMMI Config
PRODUCT_COPY_FILES += \
    $(ROOTDIR)/prodnv/PCBA.conf:$(TARGET_COPY_OUT_VENDOR)/etc/PCBA.conf

#Preset TouchPal InputMethod
PRODUCT_REVISION := oversea multi-lang

#enable VoWiFi
VOWIFI_SERVICE_ENABLE := true

# FOR BSP
TARGET_BSP_OUT := bsp/out/$(TARGET_BOARD)/dist
TARGET_PREBUILT_KERNEL := $(TARGET_BSP_OUT)/kernel/Image
BSP_DTB_NAME := sp9832e-1h10-gofu
TARGET_PREBUILT_DTB := $(TARGET_BSP_OUT)/kernel/$(BSP_DTB_NAME).dtb

PRODUCT_COPY_FILES += $(TARGET_PREBUILT_KERNEL):kernel

BOARD_PREBUILT_DTBOIMAGE := $(TARGET_BSP_OUT)/kernel/dtbo.img

# For bsp ko partitions build
PRODUCT_VENDOR_KO_MOUNT_POINT := /mnt/vendor
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.ko.mount.point=$(PRODUCT_VENDOR_KO_MOUNT_POINT)

BSP_KERNEL_MODULES_OUT := $(TARGET_BSP_OUT)/modules

PRODUCT_SOCKO_KO_LIST := \
    $(BSP_KERNEL_MODULES_OUT)/lis2dh.ko \
    $(BSP_KERNEL_MODULES_OUT)/akm09911.ko \
    $(BSP_KERNEL_MODULES_OUT)/bma2x2.ko \
    $(BSP_KERNEL_MODULES_OUT)/bstclass.ko \
    $(BSP_KERNEL_MODULES_OUT)/ltr_558als.ko \
    $(BSP_KERNEL_MODULES_OUT)/mali.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprdwl_ng.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprdbt_tty.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_fm.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_sensor.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_flash_drv.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_camera.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_cpp.ko \
    $(BSP_KERNEL_MODULES_OUT)/flash_ic_ocp8137.ko

ifeq ($(strip $(BOARD_FINGERPRINT_CONFIG)), sunwave)
PRODUCT_SOCKO_KO_LIST += $(BSP_KERNEL_MODULES_OUT)/sunwave_fp.ko
endif

# Gets ko list by ko dirs and ko names
ifeq ($(strip $(PRODUCT_SOCKO_KO_LIST)),)
PRODUCT_SOCKO_KO_DIRS := \
    $(BSP_KERNEL_MODULES_OUT)

PRODUCT_SOCKO_KO_NAMES :=
endif

PRODUCT_ODMKO_KO_LIST :=

# Gets ko list by ko dirs and ko names
ifeq ($(strip $(PRODUCT_ODMKO_KO_LIST)),)
PRODUCT_ODMKO_KO_DIRS := \
    $(BSP_KERNEL_MODULES_OUT)

PRODUCT_ODMKO_KO_NAMES :=
endif
