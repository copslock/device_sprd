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
KERNEL_PATH := kernel4.14
export KERNEL_PATH
PRODUCT_GO_DEVICE := true
$(call inherit-product, device/sprd/sharkl3/s9863a1h10_go_32b/s9863a1h10_go_32b_Base.mk)
PLATDIR := device/sprd/sharkl3
TARGET_BOARD := s9863a1h10_go_32b
BOARDDIR := $(PLATDIR)/$(TARGET_BOARD)
PLATCOMM := $(PLATDIR)/common
ROOTDIR := $(BOARDDIR)/rootdir
WPDIR := vendor/sprd/resource/wallpapers/HD
TARGET_BOARD_PLATFORM := sp9863a
TARGET_GPU_PLATFORM := rogue

TARGET_BOOTLOADER_BOARD_NAME := sp9863a_1h10_32b
CHIPRAM_DEFCONFIG := sp9863a_1h10_32b
UBOOT_DEFCONFIG := sp9863a_1h10_32b
UBOOT_TARGET_DTB := sp9863a_1h10_32b

PRODUCT_NAME := s9863a1h10_go_32b_Natv
PRODUCT_DEVICE := s9863a1h10_go_32b
PRODUCT_BRAND := SPRD
PRODUCT_MODEL := s9863a1h10_go_32b_Natv
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

TARGET_KERNEL_ARCH = arm
TARGET_USES_64_BIT_BINDER := true

#add for microarray fingerprint
BOARD_FINGERPRINT_CONFIG := microarray

#secure boot
BOARD_SECBOOT_CONFIG := true

BOARD_TEE_CONFIG := trusty

$(call inherit-product, $(PLATCOMM)/security_feature.mk)

#enable blur for front camera
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.cam.fr.blur.version=1
#enable blur for back camera
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.cam.ba.blur.version=1
#MMI main menu camera calibration & verification entry: 0-not display, 1-display
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.multicam.cali.veri=0

#enable cnr
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.cnr.mode=1
#enable beauty
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.facebeauty.corp=2
#enable ai
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.ai.scence.enable=true
#enable resolution
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.res.blur.ba=RES_2M
#faceid version    0--disable  1--single_camera  2--dual_camera
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.cam.faceid.version=1
#enable back portrait mode
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.ba.portrait.enable=0
#enable front portrait mode
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.fr.portrait.enable=0

#enable hdr_zsl
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.hdr.zsl=1
#lmkd config
PRODUCT_PROPERTY_OVERRIDES += \
    ro.lmk.upgrade_pressure=30 \
    ro.lmk.downgrade_pressure=60

PRODUCT_COPY_FILES += \
    $(BOARDDIR)/s9863a1h10_go_32b.xml:$(PRODUCT_OUT)/s9863a1h10_go_32b.xml

PRODUCT_AAPT_CONFIG := normal large xlarge mdpi 420dpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi
PRODUCT_AAPT_PREBUILT_DPI := hdpi xhdpi
TARGET_SYSTEM_PROP += $(wildcard $(TARGET_DEVICE_DIR)/system.prop)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
include build/make/target/product/go_defaults_common_speed_compile.mk
PRODUCT_PACKAGES += SprdDialerGo
#Preset TouchPal InputMethod
PRODUCT_REVISION := oversea multi-lang

# add for ifaa
CONFIG_CHIP_UID := false
BOARD_IFAA_TRUSTY := false
# add for soter(weixin pay)
BOARD_SOTER_TRUSTY := false
CHIPRAM_DDR_CUSTOMIZE_LIMITED := true
CHIPRAM_DDR_1G_LIMITED := true
CHIPRAM_DDR_CUSTOMIZE_SIZE := 0x40000000

#enable VoWiFi
VOWIFI_SERVICE_ENABLE := true

#For Modem build
PRODUCT_MODEM_COPY_LIST :=

# FOR BSP
TARGET_BSP_OUT := bsp/out/$(TARGET_BOARD)/dist
TARGET_PREBUILT_KERNEL := $(TARGET_BSP_OUT)/kernel/Image
BSP_DTB_NAME := sp9863a-1h10_go_32b_Natv
TARGET_PREBUILT_DTB := $(TARGET_BSP_OUT)/kernel/$(BSP_DTB_NAME).dtb

PRODUCT_COPY_FILES += $(TARGET_PREBUILT_KERNEL):kernel

BOARD_PREBUILT_DTBOIMAGE := $(TARGET_BSP_OUT)/kernel/dtbo.img
# For bsp ko partitions build
PRODUCT_VENDOR_KO_MOUNT_POINT := /mnt/vendor
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.ko.mount.point=$(PRODUCT_VENDOR_KO_MOUNT_POINT)

BSP_KERNEL_MODULES_OUT := $(TARGET_BSP_OUT)/modules

PRODUCT_SOCKO_KO_LIST := \
    $(BSP_KERNEL_MODULES_OUT)/flash_ic_ocp8137.ko \
    $(BSP_KERNEL_MODULES_OUT)/pvrsrvkm.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprdbt_tty.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_camera.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_cpp.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_flash_drv.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_fm.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_sensor.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprdwl_ng.ko \
    $(BSP_KERNEL_MODULES_OUT)/microarray_fp.ko \
    $(BSP_KERNEL_MODULES_OUT)/tcs3430.ko

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

