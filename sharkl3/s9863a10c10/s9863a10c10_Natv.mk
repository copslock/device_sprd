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
KERNEL_PATH := kernel4.4
export KERNEL_PATH
BOARD_PATH=$(KERNEL_PATH)/sprd-board-config/sharkl3/sp9863a_10c10/sp9863a_10c10_native
include $(BOARD_PATH)
$(call inherit-product, device/sprd/sharkl3/s9863a10c10/s9863a10c10_Base.mk)
PLATDIR := device/sprd/sharkl3
TARGET_BOARD := s9863a10c10
BOARDDIR := $(PLATDIR)/$(TARGET_BOARD)
PLATCOMM := $(PLATDIR)/common
ROOTDIR := $(BOARDDIR)/rootdir
TARGET_BOARD_PLATFORM := sp9863a
TARGET_GPU_PLATFORM := rogue

TARGET_BOOTLOADER_BOARD_NAME := sp9863a_10c10
CHIPRAM_DEFCONFIG := sp9863a_10c10
UBOOT_DEFCONFIG := sp9863a_10c10
UBOOT_TARGET_DTB := sp9863a_10c10

PRODUCT_NAME := s9863a10c10_Natv
PRODUCT_DEVICE := s9863a10c10
PRODUCT_BRAND := SPRD
PRODUCT_MODEL := s9863a10c10_Natv
PRODUCT_WIFI_DEVICE := sprd
PRODUCT_MANUFACTURER := sprd

DEVICE_PACKAGE_OVERLAYS := $(BOARDDIR)/overlay $(PLATDIR)/overlay $(PLATCOMM)/overlay

#Runtime Overlay Packages
PRODUCT_ENFORCE_RRO_TARGETS := \
    framework-res

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_VARIANT := cortex-a15
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi

TARGET_KERNEL_ARCH = arm64
TARGET_USES_64_BIT_BINDER := true

#add for support fingerprint,only for sp9863a_10c10,only for zte bringup board
BOARD_FINGERPRINT_CONFIG := goodix

#secure boot
#BOARD_SECBOOT_CONFIG := true
BOARD_SECBOOT_CONFIG := false

$(call inherit-product, $(PLATCOMM)/security_feature.mk)

#enable blur & bokeh
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.cam.ba.blur.version=6 \
    persist.vendor.cam.fr.blur.version=1
#MMI main menu camera calibration & verification entry: 0-not display, 1-display
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.multicam.cali.veri=1

#enable hdr_zsl
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.hdr.zsl=1

PRODUCT_COPY_FILES += \
    $(BOARDDIR)/s9863a10c10.xml:$(PRODUCT_OUT)/s9863a10c10.xml

PRODUCT_AAPT_CONFIG := normal large xlarge mdpi 420dpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := 400dpi
PRODUCT_AAPT_PREBUILT_DPI := 400dpi 320hdpi xhdpi

#Preset TouchPal InputMethod
PRODUCT_REVISION := multi-lang

#enable VoWiFi
VOWIFI_SERVICE_ENABLE := true

#For Modem build
PRODUCT_MODEM_COPY_LIST :=
