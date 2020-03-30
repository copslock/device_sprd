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
$(call inherit-product, device/sprd/qogirn6pro/ums7520_haps/ums7520_haps_Base.mk)
PLATDIR := device/sprd/qogirn6pro
TARGET_BOARD := ums7520_haps
BOARDDIR := $(PLATDIR)/$(TARGET_BOARD)
PLATCOMM := $(PLATDIR)/common
ROOTDIR := $(BOARDDIR)/rootdir
TARGET_BOARD_PLATFORM := ums7520
TARGET_GPU_PLATFORM := gondul
GRAPHIC_RENDER_TYPE := GPU

TARGET_BOOTLOADER_BOARD_NAME := ums7520_haps
CHIPRAM_DEFCONFIG := ums7520_haps
UBOOT_DEFCONFIG := ums7520_haps
UBOOT_TARGET_DTB := ums7520_haps

PRODUCT_NAME := ums7520_haps_Natv
PRODUCT_DEVICE := ums7520_haps
PRODUCT_BRAND := SPRD
PRODUCT_MODEL := ums7520_haps_Natv
PRODUCT_WIFI_DEVICE := sprd
PRODUCT_MANUFACTURER := sprd

DEVICE_PACKAGE_OVERLAYS := $(BOARDDIR)/overlay $(PLATDIR)/overlay $(PLATCOMM)/overlay

#Runtime Overlay Packages
PRODUCT_ENFORCE_RRO_TARGETS := \
    framework-res

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a75

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_VARIANT := cortex-a55
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi

TARGET_KERNEL_ARCH = arm64
TARGET_USES_64_BIT_BINDER := true

#add for microarray fingerprint
BOARD_FINGERPRINT_CONFIG := microarray

#secure boot
BOARD_SECBOOT_CONFIG := true

BOARD_TEE_CONFIG := trusty

$(call inherit-product, $(PLATCOMM)/security_feature.mk)

#enable 3dnr & bokeh
PRODUCT_PROPERTY_OVERRIDES += \
        persist.vendor.cam.3dnr.version=1 \
        persist.vendor.cam.ba.blur.version=6 \
        persist.vendor.cam.fr.blur.version=1 \
        persist.vendor.cam.api.version=0
#enable beauty
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.facebeauty.corp=2

#enable cnr
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.cnr.mode=1

#enable ai
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.ai.scence.enable=true

#enable wt
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.wt.enable=0

#enable hdr_zsl
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.hdr.zsl=1

#BOKEH feature
PRODUCT_PROPERTY_OVERRIDES += \
   persist.vendor.cam.res.bokeh=RES_8M

#enable back portrait mode
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.ba.portrait.enable=0
#enable front portrait mode
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.fr.portrait.enable=1

#Multi Camera
PRODUCT_PROPERTY_OVERRIDES += \
   persist.vendor.cam.res.multi.camera=RES_8M

#multi camera superwide & wide & tele
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.multi.camera.enable=1

#camera back high resolution definition mode
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.back.high.resolution.mode=1

PRODUCT_COPY_FILES += \
    $(BOARDDIR)/ums7520_haps.xml:$(PRODUCT_OUT)/ums7520_haps.xml

PRODUCT_AAPT_CONFIG := normal large xlarge mdpi 420dpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi
PRODUCT_AAPT_PREBUILT_DPI := 480dpi xxhdpi

#Preset TouchPal InputMethod
PRODUCT_REVISION := oversea multi-lang

#ValidationTools prop
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.mmi.camera.sensor.cct=ams_tcs3430

#enable TUI
BOARD_TUI_CONFIG := false

#For Modem build
PRODUCT_MODEM_COPY_LIST :=

# FOR BSP
TARGET_BSP_OUT := bsp/out/$(TARGET_BOARD)/dist
TARGET_PREBUILT_KERNEL := $(TARGET_BSP_OUT)/kernel/Image
BSP_DTB_NAME := ums7520-haps
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
    $(BSP_KERNEL_MODULES_OUT)/mali_gondul.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_flash_drv.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprdwl_ng.ko \
    $(BSP_KERNEL_MODULES_OUT)/flash_ic_sc2703.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprdbt_tty.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_fm.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_sensor.ko\
    $(BSP_KERNEL_MODULES_OUT)/sprd_camera.ko\
    $(BSP_KERNEL_MODULES_OUT)/sprd_fd.ko\
    $(BSP_KERNEL_MODULES_OUT)/sprd_cpp.ko\
    $(BSP_KERNEL_MODULES_OUT)/mmdvfs.ko\
    $(BSP_KERNEL_MODULES_OUT)/tcs3430.ko\
    $(BSP_KERNEL_MODULES_OUT)/stmvl53l0.ko\
    $(BSP_KERNEL_MODULES_OUT)/sprd_vdsp.ko\
    $(BSP_KERNEL_MODULES_OUT)/vdsp_sipc.ko\
    $(BSP_KERNEL_MODULES_OUT)/vdsp_spipe.ko\
    $(BSP_KERNEL_MODULES_OUT)/synaptics_dsx_td4310.ko\
    $(BSP_KERNEL_MODULES_OUT)/akm4377.ko

ifeq ($(strip $(BOARD_FINGERPRINT_CONFIG)), microarray)
PRODUCT_SOCKO_KO_LIST += $(BSP_KERNEL_MODULES_OUT)/microarray_fp.ko
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

