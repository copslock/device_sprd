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

PLATDIR := device/sprd/pike2
TARGET_BOARD := sp7731e_1h20
BOARDDIR := device/sprd/pike2/$(TARGET_BOARD)
WPDIR := vendor/sprd/resource/wallpapers/FWVGA
TARGET_GPU_PLATFORM := midgard
PLATCOMM := $(PLATDIR)/common
ROOTDIR := $(BOARDDIR)/rootdir
TARGET_BOARD_PLATFORM := sp7731e
TARGET_NO_BOOTLOADER := false

PRODUCT_AAPT_CONFIG := xhdpi hdpi mdpi normal
PRODUCT_AAPT_PREF_CONFIG := hdpi

USE_XML_AUDIO_POLICY_CONF := 1

#for gms
PRODUCT_COPY_FILES += $(PLATCOMM)/rootdir/root/init.ram.gms.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.ram.rc

SPRD_AUDIO_HIDL_CLIENT_SUPPORT := true
SPRD_DYNAMIC_AUDIO_ENCRYPT := true
SPRD_AUDIO_NORMAL_DISABLE_POWER_HINT := true
# use configurable audio policy
SPRD_AUDIO_HIDL_CLIENT_VERSION := v5
USE_CONFIGURABLE_AUDIO_POLICY := 1
USE_CUSTOM_CONFIGUREABLE_AUDIO_POLICY := true
BUILD_AUDIO_POLICY_CONFIGURATION := phone_configurable
AUDIO_PFW_PATH := $(ROOTDIR)/system/etc/parameter-framework
AUDIO_PFW_EDD_FILES := \
        $(AUDIO_PFW_PATH)/Settings/device_for_input_source.pfw \
        $(AUDIO_PFW_PATH)/Settings/volumes.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_media.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_accessibility.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_dtmf.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_enforced_audible.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_phone.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_sonification.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_sonification_respectful.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_transmitted_through_speaker.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_rerouting.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_fm.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_patch.pfw

#dm-verity: new Board should not config this
#TARGET_DM_VERITY := true

#USE_NEWUI ?= true

USE_SPRD_HWCOMPOSER := true

# support gnss hidl
SUPPORT_GNSS_HARDWARE := true

# support location
SUPPORT_LOCATION := enabled

PRODUCT_PROPERTY_OVERRIDES := \
    ro.config.ringtone=Ring_Synth_04.ogg \
    ro.config.ringtone1=Ring_Synth_02.ogg \
    ro.config.default_message=Argon.ogg \
    ro.config.default_message0=Argon.ogg \
    ro.config.default_message1=Highwire.ogg \
    ro.config.notification_sound=pixiedust.ogg \
    ro.config.alarm_alert=Alarm_Classic.ogg

TARGET_SYSTEM_PROP += $(wildcard $(TARGET_DEVICE_DIR)/system.prop)
$(call inherit-product, build/make/target/product/go_defaults_512.mk)
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackageGo.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
MALLOC_SVELTE := true
PRODUCT_PACKAGES += SprdDialerGo
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.foreground-heap-growth-multiplier=2.0
PRODUCT_PROPERTY_OVERRIDES += \
     ro.lmk.upgrade_pressure=30 \
     ro.lmk.downgrade_pressure=70

$(call inherit-product, device/sprd/pike2/common/DeviceCommon.mk)
$(call inherit-product, device/sprd/pike2/common/proprietories.mk)
$(call inherit-product-if-exists, vendor/sprd/modules/libcamera/libcam_device.mk)
#$(call inherit-product-if-exists, vendor/sprd/modules/faceunlock/faceunlock_device.mk)
# Get the TTS language packs
$(call inherit-product-if-exists, external/svox/pico/lang/all_pico_languages.mk)

BOARD_HAVE_SPRD_WCN_COMBO := pike2
$(call inherit-product-if-exists, vendor/sprd/modules/wcn/connconfig/device-sprd-wcn.mk)
$(call inherit-product-if-exists, vendor/sprd/modules/wlan/wlanconfig/device-sprd-wlan.mk)

DEVICE_PACKAGE_OVERLAYS := $(BOARDDIR)/overlay $(PLATDIR)/overlay $(PLATCOMM)/overlay $(WPDIR)/overlay
LOCAL_PATH := device/sprd/pike2/$(TARGET_BOARD)
COMMON_PATH := device/sprd/pike2/common

#enable F2FS for userdata.img
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

ifeq (f2fs,$(strip $(BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE)))
  NORMAL_FSTAB_SUFFIX1 := .f2fs
endif
NORMAL_FSTAB_SUFFIX := $(NORMAL_FSTAB_SUFFIX1)

# For Dynamic partitions feature, fstab install to ramdisk
PRODUCT_COPY_FILES += $(LOCAL_PATH)/rootdir/root/fstab.$(TARGET_BOARD)$(NORMAL_FSTAB_SUFFIX):vendor/etc/fstab.$(TARGET_BOARD)
PRODUCT_COPY_FILES += $(BOARDDIR)/rootdir/root/fstab.ramdisk:$(TARGET_COPY_OUT_RAMDISK)/fstab.$(TARGET_BOARD)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/root/init.$(TARGET_BOARD).rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(TARGET_BOARD).rc \
    $(LOCAL_PATH)/rootdir/root/init.sensors.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.sensors.rc \
    $(COMMON_PATH)/rootdir/root/ueventd.common.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc \
    $(ROOTDIR)/system/etc/audio_params/tiny_hw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/tiny_hw.xml \
    $(ROOTDIR)/system/etc/audio_params/codec_pga.xml:$(TARGET_COPY_OUT_VENDOR)/etc/codec_pga.xml \
    $(ROOTDIR)/system/etc/audio_params/audio_hw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_hw.xml \
    $(ROOTDIR)/system/etc/audio_params/audio_para:$(TARGET_COPY_OUT_VENDOR)/etc/audio_para \
    $(ROOTDIR)/system/etc/audio_params/smart_amp_init.bin:$(TARGET_COPY_OUT_VENDOR)/etc/smart_amp_init.bin \
    $(ROOTDIR)/system/etc/audio_params/record_tone_1.pcm:$(TARGET_COPY_OUT_VENDOR)/etc/record_tone_1.pcm \
    $(ROOTDIR)/system/etc/audio_params/record_tone_2.pcm:$(TARGET_COPY_OUT_VENDOR)/etc/record_tone_2.pcm \
    $(BOARDDIR)/log_conf/slog_modem_$(TARGET_BUILD_VARIANT).conf:vendor/etc/slog_modem.conf \
    $(BOARDDIR)/log_conf/slog_modem_cali.conf:vendor/etc/slog_modem_cali.conf \
    $(BOARDDIR)/log_conf/slog_modem_factory.conf:vendor/etc/slog_modem_factory.conf \
    $(BOARDDIR)/log_conf/slog_modem_autotest.conf:vendor/etc/slog_modem_autotest.conf \
    $(BOARDDIR)/log_conf/mlogservice_$(TARGET_BUILD_VARIANT).conf:vendor/etc/mlogservice.conf \
    $(ROOTDIR)/prodnv/PCBA.conf:$(TARGET_COPY_OUT_VENDOR)/etc/PCBA.conf \
    $(ROOTDIR)/system/etc/audio_params/rx_data.pcm:$(TARGET_COPY_OUT_VENDOR)/etc/rx_data.pcm \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    $(ROOTDIR)/prodnv/BBAT.conf:$(TARGET_COPY_OUT_VENDOR)/etc/BBAT.conf \
    $(COMMON_PATH)/rootdir/root/init.common.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(TARGET_BOARD).usb.rc \
    $(LOCAL_PATH)/sp7731e_1h20.xml:$(PRODUCT_OUT)/sp7731e_1h20.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml

#copy audio policy config
ifeq ($(USE_XML_AUDIO_POLICY_CONF), 1)
PRODUCT_COPY_FILES += \
    $(ROOTDIR)/system/etc/audio_policy_config/audio_policy_configuration_bluetooth_legacy_hal.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration_bluetooth_legacy_hal.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/audio_policy_configuration_generic.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/primary_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/primary_audio_policy_configuration.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/primary_audio_policy_configuration_smart_pa.xml:$(TARGET_COPY_OUT_VENDOR)/etc/primary_audio_policy_configuration_smart_pa.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/bluetooth_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml
else
PRODUCT_COPY_FILES += \
    $(ROOTDIR)/system/etc/audio_params/audio_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy.conf
endif

#camera sensor config
PRODUCT_COPY_FILES += \
    $(BOARDDIR)/camera/sensor_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sensor_config.xml

SPRD_GNSS_ARCH := arm

# GNSS
ifeq ($(strip $(SUPPORT_GNSS_HARDWARE)), true)
SPRD_GNSS_SHARKLE_PIKL2 := true
$(call inherit-product, vendor/sprd/modules/agps/device-sprd-gps.mk)
endif

TARGET_BOOTLOADER_BOARD_NAME := sp7731e_1h20
CHIPRAM_DEFCONFIG := sp7731e_1h20

UBOOT_DEFCONFIG := sp7731e_1h20
UBOOT_TARGET_DTB := sp7731e_1h20

PRODUCT_NAME := sp7731e_1h20_native
PRODUCT_DEVICE := sp7731e_1h20
PRODUCT_BRAND := SPRD
PRODUCT_MODEL := sp7731e_1h20_native
PRODUCT_MANUFACTURER := sprd
PRODUCT_WIFI_DEVICE := sprd
#camera app config
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.cam.zsl=false \
    persist.sys.cam.quick=false \
    persist.sys.cam.filter.version=0 \
    persist.sys.com.arc.beauty=true \
    persist.sys.cam.wideangle=0 \
    persist.sys.cam.slow_motion=false \
    persist.sys.cam.continue_photo=false \
    persist.sys.cam.ai_detect=true \
    persist.sys.cam.interval=false \
    persist.sys.cam.normalhdr=false \
    persist.sys.cam.freeze_display=false

#WCN config
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.modem.wcn.enable=1 \
    ro.vendor.modem.wcn.diag=/dev/slog_wcn0 \
    ro.vendor.modem.wcn.id=1 \
    ro.vendor.modem.wcn.count=1 \
    ro.vendor.modem.gnss.diag=/dev/slog_gnss \
    ro.vendor.wcn.gpschip=ge2
    ro.ge2.mode=gps_beidou

#Display/Graphic config
PRODUCT_PROPERTY_OVERRIDES += \
      ro.sf.lcd_density=240 \
      ro.vendor.sf.lcd_width=54 \
      ro.vendor.sf.lcd_height=96 \
      ro.opengles.version=196610

TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a7

# sprd hw module
PRODUCT_PACKAGES += \
    lights.$(TARGET_BOARD_PLATFORM) \
    sensors.$(TARGET_BOARD_PLATFORM) \
    gralloc.$(TARGET_BOARD_PLATFORM).so \
    dpu.$(TARGET_BOARD_PLATFORM) \
    gsp.$(TARGET_BOARD_PLATFORM) \
    power.$(TARGET_BOARD_PLATFORM) \
    hwcomposer.$(TARGET_BOARD_PLATFORM) \
    tinymix \
    audio.primary.$(TARGET_BOARD_PLATFORM) \
    libaudionpi \
    parameter-framework.policy \
    memtrack.$(TARGET_BOARD_PLATFORM) \
    camera.$(TARGET_BOARD_PLATFORM) \
    #audio_hardware_test




#SANSA|SPRD|NONE
PRODUCT_SECURE_BOOT := NONE
PRODUCT_HOST_PACKAGES += imgheaderinsert \
                         packimage.sh

BOARD_TEE_CONFIG := trusty

PRODUCT_PACKAGES += \
                    audio_vbc_eq \
                    libaudionpi \
                    libaudioparamteser \
                    libpolicy-subsystem \
                    FMRadio \
                    csvt

#location feature config
    PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml

PRODUCT_PACKAGES += iwnpi \
		    libiwnpi \
                    libwifieut \
                    wifi_mac_gen

PRODUCT_ENFORCE_RRO_TARGETS := \
    framework-res

#enable blur camera feature
#PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.blur.enable=true
#PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.ba.blur.version=2
#PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.fr.blur.version=1

#enable 3dnr
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.3dnr.version=1

#face_beauty lib   0--close_fb  1--arcsoft  2--sprd
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.facebeauty.corp=2

#disable refocus
#PRODUCT_PROPERTY_OVERRIDES += persist.sys.cam.refocus.enable=false

#enable camera selfshot/turnpage feature
#PRODUCT_PROPERTY_OVERRIDES += persist.sys.cam.covered.enable=false

#PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/sp7731e_1h20_tee.xml:$(PRODUCT_OUT)/sp7731e_1h20_tee.xml \
    $(LOCAL_PATH)/sp7731e_1h20_aosp.xml:$(PRODUCT_OUT)/sp7731e_1h20_aosp.xml

# Preset TouchPal IME
PRODUCT_REVISION := oversea multi-lang
TARGET_USES_64_BIT_BINDER := true
PRODUCT_GO_DEVICE := true
BOARD_SECBOOT_CONFIG := true
BOARD_TEE_LOW_MEM := true
#BOARD_FINGERPRINT_CONFIG :=

$(call inherit-product, $(PLATCOMM)/security_feature.mk)

# GNSS
SUPPORT_GNSS_HARDWARE := true
#CHIPRAM_DDR_512M_LIMITED := true
CHIPRAM_DDR_CUSTOMIZE_LIMITED := true

ifeq ($(strip $(TARGET_BUILD_VARIANT)),userdebug)
    CHIPRAM_DDR_CUSTOMIZE_SIZE := 0x20000000
else
    CHIPRAM_DDR_CUSTOMIZE_SIZE := 0x20000000
endif

#disable dmverity for system
PRODUCT_DMVERITY_DISABLE := false

# sensors
#PRODUCT_PACKAGES += lis2dh.ko \
#		    ltr_558als.ko

# FOR BSP
TARGET_BSP_OUT := bsp/out/$(TARGET_BOARD)/dist
TARGET_PREBUILT_KERNEL := $(TARGET_BSP_OUT)/kernel/Image
BSP_DTB_NAME := sp7731e-1h20-native
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
    $(BSP_KERNEL_MODULES_OUT)/ltr_558als.ko \
    $(BSP_KERNEL_MODULES_OUT)/mali.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprdbt_tty.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_fm.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprdwl_ng.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_flash_drv.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_sensor.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_camera.ko \
    $(BSP_KERNEL_MODULES_OUT)/flash_ic_wd3124da.ko

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

#ART supports pre-optimizing apps with profiles to enable better first day performance.
#This is accomplished by specifying PRODUCT_DEX_PREOPT_PROFILE_DIR
#and placing text based profiles in the directory:
PRODUCT_DEX_PREOPT_PROFILE_DIR := $(BOARDDIR)/profiles

#For Modem build
PRODUCT_MODEM_COPY_LIST :=
