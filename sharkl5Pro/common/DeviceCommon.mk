# Copyright (C) 2016 The Android Open Source Project
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

CHIP_NAME  := sharkl5Pro

LOCAL_PATH := device/sprd/sharkl5Pro/common
ROOTCOMM := $(LOCAL_PATH)/rootdir
include $(LOCAL_PATH)/ModemCommon.mk
include $(LOCAL_PATH)/TelephonyCommon.mk
include $(wildcard $(LOCAL_PATH)/common_packages.mk)
include $(LOCAL_PATH)/emmc/emmc_device.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)
include $(LOCAL_PATH)/EngpcCommon.mk

BOARD_VNDK_VERSION := current
OMA_DRM := true
#SUPPORT_BTDIALER := true

# add oma drm in pac
PRODUCT_PACKAGES += \
    libdrmomaplugin

ifeq ($(OMA_DRM),true)
PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true
else
PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=false
endif

#support btdialer
ifeq ($(SUPPORT_BTDIALER),true)
PRODUCT_PACKAGES += \
    BtReverse
endif

PRODUCT_PACKAGES += \
    SGPS \
    ProxyNFwLocation \
    uniGNSSTool

#default audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default

#audio hidl hal impl
PRODUCT_PACKAGES += \
    android.hardware.audio@5.0-impl \
    android.hardware.audio.effect@5.0-impl \
    android.hardware.broadcastradio@1.0-impl \
    android.hardware.soundtrigger@2.0-impl \
    android.hardware.audio@2.0-service

# vndk
PRODUCT_PACKAGES +=\
    vndk_package

PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/vndk/system.public.libraries-sprd.txt:system/etc/public.libraries-sprd.txt \
     $(LOCAL_PATH)/vndk/vendor.public.libraries.txt:vendor/etc/public.libraries.txt

# Power hidl HAL
PRODUCT_PACKAGES += \
    android.hardware.power.stats@1.0-service.mock \
    vendor.sprd.hardware.power@4.0-impl \
    vendor.sprd.hardware.power@4.0-service

#aosp power hidl service
#PRODUCT_PACKAGES += \
    android.hardware.power@1.0-impl \
    android.hardware.power@1.0-service

# Health HAL
PRODUCT_PACKAGES += \
    android.hardware.health@2.0-service \
    android.hardware.health@1.0-impl

# Light HAL
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service \
    android.hardware.light@2.0-impl

include vendor/sprd/modules/devdrv/input/leds/leddrv.mk

# Keymaster HAL
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.0-unisoc.service \

# Bluetooth HAL
#PRODUCT_PACKAGES += \
#    libbt-vendor \
#    android.hardware.bluetooth@1.0-impl

# RenderScript HAL
PRODUCT_PACKAGES += \
     android.hardware.renderscript@1.0-impl

#add USB vts service
PRODUCT_PACKAGES += \
    android.hardware.usb@1.1-service

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# use PRODUCT_SHIPPING_API_LEVEL indicates the first api level,and contorl treble macro
PRODUCT_SHIPPING_API_LEVEL := 29
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

# add vndk version
PRODUCT_PROPERTY_OVERRIDES += \
ro.vendor.vndk.version = 1

ifeq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.sys.wcnreset=1 \
    persist.vendor.aprservice.enabled=0 \
    persist.sys.apr.enabled=0 \
    persist.sys.apr.timechanged=180 \
    persist.sys.apr.rlchanged=800 \
    persist.sys.apr.lifetime=0 \
    persist.sys.apr.reload=0  \
    persist.sys.apr.reportlevel=2  \
    persist.sys.apr.exceptionnode=0 \
    persist.vendor.eng.reset=1
else
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.sys.wcnreset=0 \
    persist.vendor.aprservice.enabled=1 \
    persist.sys.apr.enabled=1 \
    persist.sys.apr.timechanged=180 \
    persist.sys.apr.rlchanged=800 \
    persist.sys.apr.lifetime=0 \
    persist.sys.apr.reload=0  \
    persist.sys.apr.reportlevel=0  \
    persist.sys.apr.exceptionnode=0  \
    persist.vendor.sys.core.enabled=1 \
    persist.vendor.eng.reset=0
endif # TARGET_BUILD_VARIANT == user

#poweroff charge
PRODUCT_PACKAGES += charge \
                    phasecheckserver
include vendor/sprd/proprietories-source/charge/charge.mk

#PowerHint HAL
# sprdemand, interactive, schedutil_8
BOARD_POWERHINT_HAL := schedutil_8
POWERHINT_PRODUCT_CONFIG := sharkl5pro

# Power hint config file
PRODUCT_PACKAGES += \
    power_scene_id_define.txt \
    power_scene_config.xml \
    power_resource_file_info.xml \
    libpowerhal_cli \
    libpowerhal_cli.vendor

# ION HAL module
PRODUCT_PACKAGES += \
    libmemion
# ION module
PRODUCT_PACKAGES += \
    libion
#MAP USER
PRODUCT_PACKAGES += \
    libmapuser

# Camera configuration
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
camera.disable_zsl_mode=1

include vendor/sprd/modules/libcamera/sensor/tuning_param/tunning_lib_cfg.mk

PRODUCT_COPY_FILES += \
    vendor/sprd/modules/libcamera/kernel_module/camera.rc:vendor/etc/init/camera.rc \
    vendor/sprd/modules/libcamera/kernel_module/init.sprd_flash.rc:vendor/etc/init/init.sprd_flash.rc \
    vendor/sprd/modules/vdsp/Cadence/xrp/init.sprd_vdsp.rc:vendor/etc/init/init.sprd_vdsp.rc

#camera sensor config
include vendor/sprd/modules/libcamera/sensor/sensor_drv/sensor_lib_cfg.mk
include vendor/sprd/modules/libcamera/sensor/af_drv/vcm_lib_cfg.mk
include vendor/sprd/modules/libcamera/sensor/otp_drv/otp_lib_cfg.mk

PRODUCT_PACKAGES += libmulticam

# media component modules
PRODUCT_PACKAGES += \
    libsprd_omx_core                     \
    libstagefrighthw                     \
    libstagefright_sprd_h264dec          \
    libstagefright_sprd_h264enc          \
    libstagefright_sprd_mpeg4dec         \
    libstagefright_sprd_mpeg4enc         \
    libstagefright_sprd_vpxdec           \
    libstagefright_sprd_vp9dec           \
    libstagefright_sprd_h265dec          \
    libstagefright_sprd_h265enc          \
    libstagefright_sprd_mp3dec           \
    libstagefright_soft_imaadpcmdec      \
    libstagefright_soft_mjpgdec          \
    libstagefright_sprd_mp3enc

# media extractors
PRODUCT_PACKAGES += \
    libaviextractor                      \
    libflvextractor

# factorytest modules
PRODUCT_PACKAGES += \
    factorytest

# sensor
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-service \
    android.hardware.sensors@1.0-impl

# Vibrator HAL
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.0-service \
    android.hardware.vibrator@1.0-impl

include vendor/sprd/modules/devdrv/input/vibrator/vibdrv.mk

# Memtack HAL
PRODUCT_PACKAGES += \
    android.hardware.memtrack@1.0-service \
    android.hardware.memtrack@1.0-impl

# gnss
ifeq ($(strip $(SUPPORT_GNSS_HARDWARE)), true)
PRODUCT_PACKAGES += \
    vendor.sprd.hardware.gnss@2.0-service \
    vendor.sprd.hardware.gnss@2.0-impl
endif

ifeq ($(strip $(SUPPORT_GNSS_HARDWARE)), true)
DEVICE_MANIFEST_FILE += $(PLATCOMM)/manifest_gnss.xml
endif

PRODUCT_PACKAGES += \
        gps.default \
        libgnssmgt \
        libsupl \
        liblcsagent \
        liblcscp \
        liblcswbxml2 \
        liblcsmgt \
        libgpspc

ifeq ($(TARGET_BUILD_VARIANT),userdebug)
PRODUCT_PACKAGES += \
         libgnssmgtmock
endif

PRODUCT_PACKAGES += \
    sensors.firmware    \
    libsensorsdrvcfg    \
    libsensorlistcfg

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/root/init.common.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.common.rc \
    $(LOCAL_PATH)/recovery/init.recovery.common.rc:root/init.recovery.common.rc \
    $(BOARDDIR)/recovery/init.recovery.$(TARGET_BOARD).rc:root/init.recovery.$(TARGET_BOARD).rc \
    $(LOCAL_PATH)/rootdir/system/usr/keylayout/gpio-keys.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/rootdir/system/usr/keylayout/adaptive_ts.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/adaptive_ts.kl \
    frameworks/native/data/etc/android.hardware.touchscreen.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute-0.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level-1.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_0_3.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_0_3.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_1.xml \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnels.xml \
    $(LOCAL_PATH)/rootdir/system/usr/idc/adaptive_ts.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/adaptive_ts.idc \
    $(LOCAL_PATH)/rootdir/system/usr/idc/synaptics_dsx_i2c.idc::$(TARGET_COPY_OUT_VENDOR)/usr/idc/synaptics_dsx_i2c.idc \
    $(LOCAL_PATH)/rootdir/system/media/engtest_sample.pcm:system/media/engtest_sample.pcm \
    $(LOCAL_PATH)/rootdir/system/vendor/firmware/CT4F3044DSN-1_V03_D01_20180508_app.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/focaltech-FT5x46.bin

# For the new devices shipped we would use go_handheld_core_hardware.xml and
# previously launched devices should continue using handheld_core_hardware.xml
ifeq ($(strip $(PRODUCT_GO_DEVICE)),true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/go_handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml
endif

# graphics modules
$(warning, TARGET_GPU_PLATFORM=$(TARGET_GPU_PLATFORM))

ifeq ($(strip $(TARGET_GPU_PLATFORM)), soft)
PRODUCT_PACKAGES +=  \
        libGLES_android \
        libEGL       \
        libGLESv1_CM \
        libGLESv2
ifeq ($(strip $(USE_SPRD_HWCOMPOSER)),true)
$(error, USE_SPRD_HWCOMPOSER should not be true)
endif

else # $(TARGET_GPU_PLATFORM)), soft)
ifeq ($(strip $(TARGET_GPU_PLATFORM)), midgard)
PRODUCT_PACKAGES += mali.ko gralloc.$(TARGET_BOARD_PLATFORM).so
PRODUCT_PACKAGES += \
    libGLES_mali_64.so \
    libGLES_mali.so \
    libRSDriverArm_64.so \
    libRSDriverArm.so \
    libbccArm_64.so \
    libbccArm.so \
    libmalicore_64.bc \
    libmalicore.bc \
    libhwc2on1adapter.so

PRODUCT_PACKAGES += \
     android.hardware.camera.provider@2.4-impl-sprd \
     android.hardware.camera.provider@2.4-service

OVERRIDE_RS_DRIVER := libRSDriverArm.so
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.vendor.gpu.boost=0
endif # $(TARGET_GPU_PLATFORM)), midgard)

ifeq ($(strip $(TARGET_GPU_PLATFORM)), gondul)
$(warning "GPU: TARGET PLATFORM is Gondul")
PRODUCT_PACKAGES += mali_gondul.ko gralloc.$(TARGET_BOARD_PLATFORM).so
PRODUCT_PACKAGES += \
    libGLES_mali_64.so \
    libGLES_mali.so \
    libRSDriverArm_64.so \
    libRSDriverArm.so \
    libbccArm_64.so \
    libbccArm.so \
    libmalicore_64.bc \
    libmalicore.bc \
    libhwc2on1adapter.so

PRODUCT_PACKAGES += \
     android.hardware.camera.provider@2.4-impl-sprd \
     android.hardware.camera.provider@2.4-service

OVERRIDE_RS_DRIVER := libRSDriverArm.so
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.vendor.gpu.boost=0
endif # $(TARGET_GPU_PLATFORM)), gondul)

ifeq ($(strip $(TARGET_GPU_PLATFORM)), rogue)
PRODUCT_PACKAGES += \
    pvrdebug \
    pvrhwperf \
    pvrlogdump \
    pvrlogsplit \
    pvrtld \
    pvrhtb2txt \
    pvrhtbd \
    libdrm \
    rscompiler \
    libadf \
    libadfhwc \
    rgx.fw.signed.22.86.104.218 \
    libEGL_POWERVR_ROGUE.so \
    libGLESv1_CM_POWERVR_ROGUE.so \
    libGLESv2_POWERVR_ROGUE.so \
    libcreatesurface.so \
    libglslcompiler.so \
    libIMGegl.so \
    libpvrANDROID_WSEGL.so \
    libPVRScopeServices.so \
    libsrv_um.so \
    libusc.so \
    memtrack.$(TARGET_BOARD_PLATFORM).so \
    libPVRRS.so \
    libPVRRS.sha1.so \
    gralloc.$(TARGET_BOARD_PLATFORM).so \
    libhwc2on1adapter.so \
    libtqvalidate.so \
    libsutu_display.so

PRODUCT_PACKAGES += \
     android.hardware.camera.provider@2.4-impl-sprd \
     android.hardware.camera.provider@2.4-service

#PRODUCT_PACKAGES += pvrsrvkm.ko
#PRODUCT_COPY_FILES += \
    vendor/sprd/external/drivers/gpu/rogue/driver/build/linux/sharkl5pro_android/pvrsrvkm.ko:vendor/lib/modules/pvrsrvkm.ko

#OVERRIDE_RS_DRIVER := libPVRRS.so
endif # $(TARGET_GPU_PLATFORM)), rogue)

PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@2.0-impl-2.1 \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service

ifeq ($(strip $(USE_SPRD_HWCOMPOSER)),true)
$(warning, if sprd hwcomposer is not ready, USE_SPRD_HWCOMPOSER should not be true)
PRODUCT_PACKAGES +=  hwcomposer.$(TARGET_BOARD_PLATFORM)
endif

endif # $(TARGET_GPU_PLATFORM)), soft)
#End Graphic Module

#ValidationTools prop
ifeq ($(strip $(USE_AUDIO_WHALE_HAL)),true)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.mmi.use.audio.whale.hal=1
endif
ifeq ($(strip $(TARGET_CAMERA_SENSOR_CCT)),"ams_tcs3430")
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.mmi.camera.sensor.cct=ams_tcs3430
endif
ifeq ($(strip $(TARGET_CAMERA_SENSOR_TOF)),"tof_vl53l0")
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.mmi.camera.sensor.tof=tof_vl53l0
endif

#ValidationTools prop end

# multimedia configs
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    $(LOCAL_PATH)/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    $(LOCAL_PATH)/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(LOCAL_PATH)/media_codecs_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_c2.xml \
    $(LOCAL_PATH)/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml \
    $(LOCAL_PATH)/media_profiles_turnkey.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_turnkey.xml \
    $(LOCAL_PATH)/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/media_codecs_performance_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance_c2.xml \
    $(LOCAL_PATH)/seccomp_policy/mediaextractor.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaextractor.policy

#audio effect configs;
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/etc/audio_effect/audio_effects.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.conf \
    $(LOCAL_PATH)/rootdir/system/etc/audio_effect/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml

#ZRAM
ifeq ($(strip $(PRODUCT_GO_DEVICE)),true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.enableswap_go:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.enableswap
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.enableswap:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.enableswap
endif

#add for cts feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.cts.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.cts.xml

#copy cdrom resource file
PRODUCT_COPY_FILES += \
    vendor/sprd/resource/cdrom/adb.iso:vendor/etc/adb.iso

# Power Framework
PRODUCT_COPY_FILES += \
    vendor/sprd/modules/power/fw-power-config/power_info.db:system/etc/power_info.db \
    vendor/sprd/modules/power/fw-power-config/blackAppList.xml:system/etc/blackAppList.xml \
    vendor/sprd/modules/power/fw-power-config/pwctl_config.xml:system/etc/pwctl_config.xml \
    vendor/sprd/modules/power/fw-power-config/powercontroller.xml:system/etc/powercontroller.xml \
    vendor/sprd/modules/power/fw-power-config/deviceidle.xml:system/etc/deviceidle.xml

#Display PQ enhance config parameters
PRODUCT_COPY_FILES += \
    $(BOARDDIR)/enhance/abc.xml:vendor/etc/enhance/abc.xml \
    $(BOARDDIR)/enhance/bld.xml:vendor/etc/enhance/bld.xml \
    $(BOARDDIR)/enhance/cms.xml:vendor/etc/enhance/cms.xml \
    $(BOARDDIR)/enhance/gamma.xml:vendor/etc/enhance/gamma.xml \
    $(BOARDDIR)/enhance/flash.xml:vendor/etc/enhance/flash.xml

#Display PQ ABC
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.pq.enabled=1

#Add PowerSaveModeLauncher
TARGET_PWCTL_ULTRASAVING ?= true
ifeq (true,$(strip $(TARGET_PWCTL_ULTRASAVING)))
PRODUCT_PACKAGES += \
    PowerSaveModeLauncher
endif

#copy cgroup blkio resource file
ifeq ($(TARGET_BUILD_VARIANT),userdebug)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/etc/init/cgroup_blkio.rc:system/etc/init/cgroup_blkio.rc
endif

# SPRD WCN modules
PRODUCT_PACKAGES += connmgr
# EngineerMode modules
PRODUCT_PACKAGES += \
    EngineerMode \
    EngineerInternal \
    LogManager

#copy coredump resource file
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/etc/init/coredump.rc:system/etc/init/coredump.rc
endif

# Network related modules
PRODUCT_PACKAGES += \
    dhcp6c \
    dhcp6s \
    radvd \
    tcpdump \
    ext_data \
    ip_monitor.sh \
    tiny_firewall.sh \
    data_rps.sh \
    netbox.sh

#copy thermal config file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/thermal.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal.conf \
    $(LOCAL_PATH)/scenario.conf:system/etc/scenario.conf

PRODUCT_PACKAGES += \
    thermal.default \
    vendor.sprd.hardware.thermal@1.0 \
    vendor.sprd.hardware.thermal@1.0-impl \
    vendor.sprd.hardware.thermal@1.0-service \
    android.hardware.thermal@2.0-service.mock

PRODUCT_PROPERTY_OVERRIDES += \
   persist.vendor.bsservice.enable=1

# APR auto upload
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.apr.intervaltime=1 \
    persist.sys.apr.testgroup=CSSLAB \
    persist.sys.apr.autoupload=1


PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.heartbeat.enable=1\
    persist.sys.power.touch=1

# PDK prebuild apps
#include $(wildcard vendor/sprd/pdk_prebuilts/prebuilts.mk)

# add widevine build for androido
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-impl    \
    android.hardware.drm@1.0-service \
    android.hardware.drm@1.2-service.clearkey


# add oma drm for download&documentui
PRODUCT_PACKAGES += \
    DownloadProviderDrmAddon \
    DocumentsUIXposed

#dataLogDaemon
PRODUCT_PACKAGES += \
        dataLogDaemon

# add sprd email
PRODUCT_PACKAGES += \
    Email2 \
    Exchange2

# add sprd calendar
PRODUCT_PACKAGES += \
    SprdCalendar

# add sprd CalendarProvider
PRODUCT_PACKAGES += \
    SprdCalendarProvider

# add sprd quicksearchbox
PRODUCT_PACKAGES += \
    SprdQuickSearchBox

# add sprd deskclock
PRODUCT_PACKAGES += \
    SprdDeskClock

# misc
PRODUCT_PACKAGES += tune2fs

PRODUCT_PACKAGES += libapdeepsleep

# Set default USB interface
ifeq ($(TARGET_BUILD_VARIANT),userdebug)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.vendor.sys.modem.diag=none
endif

ifeq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.vendor.sys.modem.diag=disable
endif

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    sys.usb.controller=musb-hdrc.0.auto

#use lmkd instead of lmfs since AndroidO MR1
#PRODUCT_PACKAGES += lmfs

ifneq ($(strip $(PRODUCT_GO_DEVICE)),true)
PRODUCT_REVISION += multiuser

endif

#add for sprd color mode and night display
#PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
 #   ro.sprd.displayenhance=true \
  #  ro.sprd.nightdisplay.enhance = true

# For gator by Ken.Kuang
#PRODUCT_PACKAGES += gatord \
            gator.ko
#PRODUCT_COPY_FILES += vendor/sprd/tools/gator/gatordstart:$(TARGET_COPY_OUT_VENDOR)/bin/gatordstart

DEVICE_MANIFEST_FILE += $(PLATCOMM)/manifest_main.xml
DEVICE_MATRIX_FILE := $(PLATCOMM)/compatibility_matrix.xml
DEVICE_MANIFEST_FILE += $(PLATCOMM)/manifest_vdsp_nnhal.xml
ifneq ($(wildcard vendor/widevine),)
    PRODUCT_PACKAGES += android.hardware.drm@1.2-service.widevine
    DEVICE_MANIFEST_FILE += $(PLATCOMM)/manifest_drm_widevine.xml
else
    DEVICE_MANIFEST_FILE += $(PLATCOMM)/manifest_drm_default.xml
endif
#add for performance
PRODUCT_PACKAGES += performancemanager
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/sprd_performance_config.xml:/system/etc/sprd_performance_config.xml
#brightness
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/brightness/readme:/vendor/bin/power/backlight/readme

#para
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/para/readme:/vendor/bin/power/paras/readme
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/para/para.sh:/vendor/bin/power/paras/tool/para.sh

#interrupts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/interrupts/readme:/vendor/bin/power/interrupt/readme

#fps
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/fps/readme:/vendor/bin/power/frame/readme
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/fps/fps_sf:/vendor/bin/power/frame/fps_sf
#top
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/top/readme:/vendor/bin/power/tops/readme

#cpu_gpu_ddr_loading
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/loading/loading.sh:/vendor/bin/power/loadings/tool/loading.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/loading/readme:/vendor/bin/power/loadings/readme

#CPU
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/cpu/fix_freq/readme:/vendor/bin/power/cpu/fix_freq/readme
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/cpu/lit_freq/readme:/vendor/bin/power/cpu/lit_freq/readme
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/cpu/hotplug/readme:/vendor/bin/power/cpu/hotplug/readme
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/cpu/trans_table/readme:/vendor/bin/power/cpu/trans_table/readme
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/cpu/loading/readme:/vendor/bin/power/cpu/loading/readme
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/cpu/dvfs/readme:/vendor/bin/power/cpu/dvfs/readme

#GPU
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/gpu/fix_freq/readme:/vendor/bin/power/gpu/fix_freq/readme
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/gpu/loading/readme:/vendor/bin/power/gpu/loading/readme
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/gpu/trans_table/readme:/vendor/bin/power/gpu/trans_table/readme

#DDR
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/ddr/bm/readme:/vendor/bin/power/ddr/bm/readme
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/ddr/bm/tool/ddr_bm_log:/vendor/bin/power/ddr/bm/tool/ddr_bm_log
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/ddr/bm/tool/log_to_csv.sh:/vendor/bin/power/ddr/bm/tool/log_to_csv.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/ddr/bm/tool/sharkl5pro_cm4_disable_smart_light.bin:/vendor/bin/power/ddr/bm/tool/sharkl5pro_cm4_disable_smart_light.bin
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/ddr/loading/readme:/vendor/bin/power/ddr/loading/readme
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/ddr/trans_table/readme:/vendor/bin/power/ddr/trans_table/readme
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/ddr/fix_freq/readme:/vendor/bin/power/ddr/fix_freq/readme

#total
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/total/readme:/vendor/bin/power/total/readme
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power/total/tool/total.sh:/vendor/bin/power/total/tool/total.sh

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/root/ueventd.common.rc:recovery/root/ueventd.$(TARGET_BOARD).rc \
    $(LOCAL_PATH)/recovery/recovery.tmpfsdata.fstab:recovery/root/system/etc/recovery.tmpfsdata.fstab

$(warning  "common/DeviceCommon.mk: PRODUCT_PACKAGES:  $(PRODUCT_PACKAGES)")

#fs doesn't have HEH filename encryption
PRODUCT_PROPERTY_OVERRIDES += \
    ro.crypto.volume.filenames_mode=aes-256-cts

#add for log
PRODUCT_PACKAGES +=  \
    vendor.sprd.hardware.log@1.0-impl \
    vendor.sprd.hardware.log@1.0 \
    vendor.sprd.hardware.log@1.0-service \
    srtd \
    ylog_common \
    log_service \
    vendor.sprd.hardware.aprd@1.0-impl \
    vendor.sprd.hardware.aprd@1.0-service \
    vendor.sprd.hardware.cplog_connmgr@1.0-impl \
    vendor.sprd.hardware.cplog_connmgr@1.0 \
    vendor.sprd.hardware.cplog_connmgr@1.0-service \
    modemlog_connmgr_service

ifeq ($(strip $(FACEID_FEATURE_SUPPORT)),true)
PRODUCT_PACKAGES += \
    vendor.sprd.hardware.face@1.0-service \
    face.default \
    faceid.elf

    ifeq ($(strip $(FACEID_TEE_FULL_SUPPORT)),true)
    PRODUCT_PACKAGES += \
        libfaceid_tee
    else
    PRODUCT_PACKAGES += \
        libfaceid_ca \
        libsprdfaceid
    endif

    ifeq ($(strip $(FACEID_VERSION_PROP)),1)
        PRODUCT_PROPERTY_OVERRIDES += \
            persist.sys.cam.faceid.version=1
    endif
    ifeq ($(strip $(FACEID_VERSION_PROP)),2)
        PRODUCT_PROPERTY_OVERRIDES += \
            persist.sys.cam.faceid.version=2
    endif
    ifeq ($(strip $(FACEID_VERSION_PROP)),3)
        PRODUCT_PROPERTY_OVERRIDES += \
            persist.sys.cam.faceid.version=3
    endif

PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.biometrics.face.xml:vendor/etc/permissions/android.hardware.biometrics.face.xml
endif

#add for connmgr hidl

PRODUCT_PACKAGES +=  \
    vendor.sprd.hardware.connmgr@1.0-impl \
    vendor.sprd.hardware.connmgr@1.0-service

# DPU Enhance HIDL
PRODUCT_PACKAGES += \
    vendor.sprd.hardware.enhance@1.0-impl \
    vendor.sprd.hardware.enhance@1.0-service

PRODUCT_DEXPREOPT_SPEED_APPS += \
    NewGallery2 \
    SystemUI \
    SprdCalendar

PRODUCT_PACKAGES += \
    libyuv_jpeg_converter_jni

#for gms
versiontype :=native
ifeq (vendor/google, $(wildcard vendor/google))
versiontype :=gms
else
    ifeq (vendor/partner_gms, $(wildcard vendor/partner_gms))
        versiontype :=gms
    else
        ifeq ($(strip $(TARGET_BUILD_VERSION)),gms)
            versiontype :=gms
        endif
    endif
endif
$(warning  "common/DeviceCommon.mk: version type: $(versiontype)")
ifeq ($(versiontype),gms)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/rootdir/root/init.ram.gms.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.ram.rc
else
PRODUCT_COPY_FILES += $(LOCAL_PATH)/rootdir/root/init.ram.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.ram.rc
endif

#copy the tf model files to system/etc
TF_MODEL_PATH := vendor/sprd/platform/frameworks/base/data/etc/tf_models
model_files := $(shell ls $(TF_MODEL_PATH))
PRODUCT_COPY_FILES += $(foreach file, $(model_files), \
        $(TF_MODEL_PATH)/$(file):vendor/etc/tf_models/$(file))

#copy hprofs rc file
ifneq ($(TARGET_BUILD_VARIANT),user)
    PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/etc/init/hprofs.rc:system/etc/init/hprofs.rc
endif

# Disable uncompressing priv apps so that there is enough space to build the system partition.
DONT_UNCOMPRESS_PRIV_APPS_DEXS := true

#init gms build
ifneq ($(wildcard vendor/partner_gms),)
  ifeq ($(strip $(TARGET_BUILD_VERSION)),gms)
    ifeq ($(strip $(PRODUCT_GO_DEVICE)),true)
      $(call inherit-product, vendor/partner_gms/products/gms_go.mk)
      FEATURES.PRODUCT_PRODUCT_PROPERTIES += \
              ro.com.google.clientidbase=android-google
    else
      $(call inherit-product, vendor/partner_gms/products/gms.mk)
      FEATURES.PRODUCT_PRODUCT_PROPERTIES += \
              ro.com.google.clientidbase=android-google
    endif
    PRODUCT_COPY_FILES += \
      vendor/sprd/modules/power/fw-power-config/appPowerSaveConfig.xml:system/etc/appPowerSaveConfig.xml
  else
    PRODUCT_COPY_FILES += \
      vendor/sprd/modules/power/fw-power-config/appPowerSaveConfig_native.xml:system/etc/appPowerSaveConfig.xml
  endif
else
  PRODUCT_COPY_FILES += \
    vendor/sprd/modules/power/fw-power-config/appPowerSaveConfig_native.xml:system/etc/appPowerSaveConfig.xml
endif

#For BraodCastRadio HAL
PRODUCT_PACKAGES += \
    libfmjni \
    vendor.sprd.hardware.broadcastradio@2.0-service
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.broadcastradio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.broadcastradio.xml \
    vendor/sprd/interfaces/broadcastradio/2.0/default/fm.conf:$(TARGET_COPY_OUT_VENDOR)/etc/fm.conf

# config gallery discover module on non-gms version and non-go device
ifneq ($(strip $(TARGET_BUILD_VERSION)),gms)
ifneq ($(strip $(PRODUCT_GO_DEVICE)),true)
#0 means not support
#1 means tfl_inception_v3_quant
#2 means tfl_mnasnet_1.3_224 float
TARGET_BOARD_GALLERY_DISCOVER_SUPPORT := 2
PRODUCT_PROPERTY_OVERRIDES += persist.sys.gallery.discover.module=$(TARGET_BOARD_GALLERY_DISCOVER_SUPPORT)
ifneq ($(strip $(TARGET_BOARD_GALLERY_DISCOVER_SUPPORT)),0)
#USCAIEngine
PRODUCT_PACKAGES += \
        USCAIEngine
$(call inherit-product, vendor/sprd/platform/frameworks/base/data/etc/models_config.mk)
endif # $(TARGET_BOARD_GALLERY_DISCOVER_SUPPORT)
endif # $(PRODUCT_GO_DEVICE)
endif # $(TARGET_BUILD_VERSION)

#init Launcher build
ifneq ($(wildcard vendor/sprd/generic/misc/launchercfg),)
    $(call inherit-product, vendor/sprd/generic/misc/launchercfg/LauncherPackages.mk)
endif

#add for F2FS
ifeq (f2fs,$(strip $(BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE)))
TARGET_USERIMAGES_USE_F2FS := true
endif

#for performance
ifneq ($(strip $(PRODUCT_GO_DEVICE)),true)
PRODUCT_USE_PROFILE_FOR_BOOT_IMAGE := false
$(warning "PRODUCT_USE_PROFILE_FOR_BOOT_IMAGE: $(PRODUCT_USE_PROFILE_FOR_BOOT_IMAGE)")
endif

# PRODUCT_PROPERTY_OVERRIDES  must be set before BoardConfig.mk
#faceid version    0--disable  1--single_camera  2--dual_camera
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.cam.faceid.version=1

#add ENG & DEBUG modules here, currently all modules treated as 'common'
PRODUCT_PACKAGES_ENG += \
        iosnoop.sh \
        busybox \
        pack \
        FmRadio \
        stm_sensors_tof_af \
        vl53l0_reg \
        vl53l0_parameter \

PRODUCT_PACKAGES_DEBUG += \
        iperf \
        vibfftest \
        SprdCommLogService \
        iosnoop.sh \
        copybw \
        memverify \
        bonnie \
        busybox \
        costmem \
        lookat \
        memtester \
        imsbrdctl \
        imsbr_tests.sh \
        utest_vsp_hevch265dec \
        utest_vsp_hevch265enc \
        utest_vsp_vp9dec \
        utest_vsp_vp9enc \
        utest_vsp_vp8enc \
        utest_vsp_avch264dec \
        utest_vsp_avch264enc \
        utest_vsp_vpxdec \
        utest_vsp_m4vh263dec \
        utest_vsp_m4vh263enc \
        utest_sw_m4vh263enc \
        utest_jpeg_dec \
        utest_jpeg_enc \
        utest_jpeg_sw_enc \
        test_ext_data \
        fstestpack \
        fspfpack \
        bonnie++ \
        zcav \
        minicamera \


#For Dynamic Partitions feature
PRODUCT_USE_DYNAMIC_PARTITIONS :=true

# Fastbootd and fastboot HAL
PRODUCT_PACKAGES += \
    fastbootd \
    android.hardware.fastboot@1.0-impl

#add for sprd network hidl
PRODUCT_PACKAGES += \
    vendor.sprd.hardware.network@1.0 \
    vendor.sprd.hardware.network@1.0-service \
    vendor.sprd.hardware.network@1.0-impl

#add for sprd networkcontrol service
PRODUCT_PACKAGES += \
    sprd_networkcontrol

#add for sprd INetworkControl xml
DEVICE_MANIFEST_FILE += $(PLATCOMM)/manifest_network.xml

#enable thumbnail prefer_hw_codecs
PRODUCT_PROPERTY_OVERRIDES += \
    media.stagefright.thumbnail.prefer_hw_codecs=true

#for dcx0 cali data write back
DCXDATA_SUPPORT := true

# Integrate Google Mainline Modules
ifneq ($(wildcard vendor/sprd/partner/google_mainline),)
#ifeq ($(strip $(TARGET_BUILD_VERSION)),gms)
    include vendor/sprd/partner/google_mainline/unisoc_integration_rule/mainline.mk
#endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.control_privapp_permissions=enforce

# wait for shutdownanim complete
PRODUCT_PROPERTY_OVERRIDES += service.wait_for_bootanim=1

#for jeita
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.eng.jeita=1

$(call inherit-product-if-exists, vendor/sprd/modules/camera_core/config/default_prop.mk)
