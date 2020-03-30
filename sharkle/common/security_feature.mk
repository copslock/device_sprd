#
# three config options can be set in one specific android board as follows:
# BOARD_TEE_CONFIG := trusty
# BOARD_FINGERPRINT_CONFIG := vendor(chipone)
# BOARD_SECBOOT_CONFIG := true
# after setting these options, include this file as include "device/sprd/sharkle/common/security_feature.mk"
#
# sml and firewall is not related to tos, so config them outside the BOARD_TEE_CONFIG
#
PRODUCT_SECURE_BOOT := NONE
BOARD_ATF_CONFIG := true
TARGET_NO_SML_13 := false
#TARGET_SML_CONFIG := <board>[@<platform>@arch]
TARGET_SML_CONFIG := sharkle@sharkle

#add dynamic lib to read uid
HAS_GETUID_LIB := true
PRODUCT_PACKAGES += libgetuid

#feature phone
ifneq ($(BOARD_FEATUREPHONE_CONFIG),)
BOARD_SEC_MEM_SIZE ?= 0x20000
BOARD_SML_MEM_SIZE ?= 0x20000
BOARD_SML_MEM_ADDR ?= 0x8e000000
#smart phone
else
BOARD_SEC_MEM_SIZE ?= 0x20000
BOARD_SML_MEM_SIZE ?= 0x20000
BOARD_SML_MEM_ADDR ?= 0x94000000
endif

CONFIG_TEE_FIREWALL := true

ifeq ($(strip $(BOARD_TEE_CONFIG)), trusty)

BOARD_TOS_MEM_ADDR ?= 0x94020000

TRUSTY_PRODUCTION := true
BOARD_ATF_BOOT_TOS_CONFIG := true

#trusty related config

ifneq ($(BOARD_FEATUREPHONE_CONFIG),)
CFG_TRUSTY_DEFAULT_PROJECT := sharkle-feature
else
CFG_TRUSTY_DEFAULT_PROJECT ?= sharkle
endif


ifeq ($(strip $(BOARD_FEATUREPHONE_CONFIG)),)
#Add for android  gatekeeper HDIL
#BOARD_HARDWARE_GATEKEEPER_CONFIG := true
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.software.secure_lock_screen.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.secure_lock_screen.xml
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service \
    android.hardware.gatekeeper@1.0-impl

PRODUCT_PACKAGES += \
    gatekeeper.default
endif

PRODUCT_PACKAGES += \
    libtrusty \
    libteeproduction

ifeq ($(strip $(BOARD_FEATUREPHONE_CONFIG)),)

PRODUCT_PACKAGES += \
    sprdstorageproxyd \
    rpmbserver \

PRODUCT_PACKAGES += \
    tsupplicant

endif


TRUSTY_SEPOLICY_DIR :=vendor/sprd/proprietories-source/sprdtrusty/vendor/sprd/modules/common/sepolicy_androidq
BOARD_SEPOLICY_DIRS += $(TRUSTY_SEPOLICY_DIR)

#secure boot
ifeq ($(strip $(BOARD_SECBOOT_CONFIG)), true)
SECURE_BOOT_KCE := DISABLE
#SANSA|SPRD|NONE
PRODUCT_SECURE_BOOT := SPRD
PRODUCT_HOST_PACKAGES += sprd_sign \
                         splitimg

# Bypass secure boot enable
BOARD_KBC_BYPASS_SECURE_BOOT := false

#FOR Verified Boot
#1.0|2.0
PRODUCT_VBOOT := V2
BOARD_AVB_ENABLE := true
CONFIG_PATH:=vendor/sprd/proprietories-source/packimage_scripts/signimage/sprd/config

#add for cts test testVerifiedBootSupport
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.software.verified_boot.xml:vendor/etc/permissions/android.software.verified_boot.xml

#config key&version for vbmeta
BOARD_AVB_ALGORITHM:=SHA256_RSA4096
BOARD_AVB_KEY_PATH:=$(CONFIG_PATH)/rsa4096_vbmeta.pem
BOARD_AVB_ROLLBACK_INDEX:=$(shell sed -n '/avb_version_vbmeta/p'  $(CONFIG_PATH)/version.cfg | sed -n 's/avb_version_vbmeta=//gp' )

#config key&version for boot
BOARD_AVB_BOOT_KEY_PATH:=$(CONFIG_PATH)/rsa4096_boot.pem
BOARD_AVB_BOOT_ALGORITHM:=SHA256_RSA4096
BOARD_AVB_BOOT_ROLLBACK_INDEX:=$(shell sed -n '/avb_version_boot/p'  $(CONFIG_PATH)/version.cfg | sed -n 's/avb_version_boot=//gp' )
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION:=1

#config key&version for recovery
BOARD_AVB_RECOVERY_KEY_PATH:=$(CONFIG_PATH)/rsa4096_recovery.pem
BOARD_AVB_RECOVERY_ALGORITHM:=SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX:=$(shell sed -n '/avb_version_boot/p'  $(CONFIG_PATH)/version.cfg | sed -n 's/avb_version_boot=//gp' )
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION:=2

#config key&version for system
BOARD_AVB_VBMETA_SYSTEM:=system product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH:=$(CONFIG_PATH)/rsa4096_system.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM:=SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX:=$(shell sed -n '/avb_version_system/p'  $(CONFIG_PATH)/version.cfg | sed -n 's/avb_version_system=//gp' )
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION:=3

#config key&version for vendor
BOARD_AVB_VBMETA_VENDOR:= vendor
BOARD_AVB_VBMETA_VENDOR_KEY_PATH:=$(CONFIG_PATH)/rsa4096_vendor.pem
BOARD_AVB_VBMETA_VENDOR_ALGORITHM:=SHA256_RSA4096
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX:=$(shell sed -n '/avb_version_vendor/p'  $(CONFIG_PATH)/version.cfg | sed -n 's/avb_version_vendor=//gp' )
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX_LOCATION:=4

#config chain_partiton args for modem
BOARD_AVB_KEY_PATH_MODEMIMAGE_PUB:=$(CONFIG_PATH)/rsa4096_modem_pub.bin
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS:=--chain_partition l_modem:5:$(BOARD_AVB_KEY_PATH_MODEMIMAGE_PUB)
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS+=--chain_partition l_ldsp:6:$(BOARD_AVB_KEY_PATH_MODEMIMAGE_PUB)
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS+=--chain_partition l_gdsp:7:$(BOARD_AVB_KEY_PATH_MODEMIMAGE_PUB)
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS+=--chain_partition pm_sys:8:$(BOARD_AVB_KEY_PATH_MODEMIMAGE_PUB)

#config key&version for dtbo
BOARD_AVB_DTBO_KEY_PATH:=$(CONFIG_PATH)/rsa4096_boot.pem
BOARD_AVB_DTBO_ALGORITHM:=SHA256_RSA4096
BOARD_AVB_DTBO_ROLLBACK_INDEX:=$(shell sed -n '/avb_version_boot/p'  $(CONFIG_PATH)/version.cfg | sed -n 's/avb_version_boot=//gp' )
BOARD_AVB_DTBO_ROLLBACK_INDEX_LOCATION:=9

#config key&version for socko
BOARD_AVB_SOCKO_KEY_PATH:=$(CONFIG_PATH)/rsa4096_socko.pem
BOARD_AVB_SOCKO_ALGORITHM:=SHA256_RSA4096
BOARD_AVB_SOCKO_ROLLBACK_INDEX:=$(shell sed -n '/avb_version_socko/p'  $(CONFIG_PATH)/version.cfg | sed -n 's/avb_version_socko=//gp' )
BOARD_AVB_SOCKO_ROLLBACK_INDEX_LOCATION:=10

#config key&version for odmko
BOARD_AVB_ODMKO_KEY_PATH:=$(CONFIG_PATH)/rsa4096_odmko.pem
BOARD_AVB_ODMKO_ALGORITHM:=SHA256_RSA4096
BOARD_AVB_ODMKO_ROLLBACK_INDEX:=$(shell sed -n '/avb_version_odmko/p'  $(CONFIG_PATH)/version.cfg | sed -n 's/avb_version_odmko=//gp' )
BOARD_AVB_ODMKO_ROLLBACK_INDEX_LOCATION:=11

else
PRODUCT_SECURE_BOOT := NONE
PRODUCT_HOST_PACKAGES += imgheaderinsert \
                         packimage.sh
endif

#feature phone
ifneq ($(BOARD_FEATUREPHONE_CONFIG),)
BOARD_SEC_MEM_SIZE := 0x200000
BOARD_TOS_MEM_SIZE ?= 0x1e0000
BOARD_TOS_MEM_ADDR ?= 0x8e020000
#smart phone
else
#fingerprint
ifneq ($(BOARD_FINGERPRINT_CONFIG),)
PRODUCT_PACKAGES += android.hardware.biometrics.fingerprint@2.1-service

#for fingerprint apk mmi test
PRODUCT_PACKAGES += \
    vendor.sprd.hardware.fingerprintmmi@1.0-service \
    vendor.sprd.hardware.fingerprintmmi@1.0-impl

ifeq ($(strip $(PRODUCT_GO_DEVICE)),true)
PRODUCT_PACKAGES += \
    vendor.sprd.hardware.fingerprintmmi@1.0-service-lazy
endif

BOARD_SEPOLICY_DIRS += vendor/sprd/interfaces/fingerprintmmi/sepolicy

#for fingerprint BBAT & nativemmi test
PRODUCT_PACKAGES += autotestfinger
PRODUCT_PACKAGES += nativemmifinger

PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml
endif

ifneq ($(BOARD_TEE_LOW_MEM), true)
BOARD_SEC_MEM_SIZE := 0x2000000
BOARD_TOS_MEM_SIZE ?= 0x1fe0000
else
ifeq ($(BOARD_TEE_64BIT),false)
BOARD_SEC_MEM_SIZE := 0x300000
BOARD_TOS_MEM_SIZE ?= 0x2E0000
else
BOARD_SEC_MEM_SIZE := 0x400000
BOARD_TOS_MEM_SIZE ?= 0x3E0000
endif
endif
endif

ifeq ($(strip $(BOARD_FINGERPRINT_CONFIG)), sunwave)
include vendor/sprd/partner/sunwave/sharklE/sunwave.mk
endif

#add support checkX
PRODUCTION_SUPPORT_CHECKX := true

#add dynamic lib to link engpc
PRODUCT_PACKAGES += libdynamicproduction

#add for keybox prop value
PRODUCT_PROPERTY_OVERRIDES += \
      ro.vendor.keybox.id.value=SPRD

#add for check keymaster & widevine keybox lib
PRODUCT_PACKAGES += libcheckkeybox

#ifaa
ifeq ($(strip $(BOARD_IFAA_TRUSTY)), true)
PRODUCT_PACKAGES += \
    ifaa.default \
    vendor.sprd.hardware.ifaa@1.0-impl \
    vendor.sprd.hardware.ifaa@1.0-service

DEVICE_MANIFEST_FILE += $(PLATCOMM)/manifest_ifaa.xml

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.ifaa.device=0x08

BOARD_SEPOLICY_DIRS += vendor/sprd/proprietories-source/sprdtrusty/vendor/sprd/modules/ifaa/sepolicy_androido
endif

#soter
ifeq ($(strip $(BOARD_SOTER_TRUSTY)), treble)
PRODUCT_PACKAGES += \
   SoterService \
   libsoter_trusty \
   vendor.sprd.hardware.soter@1.0-service

DEVICE_MANIFEST_FILE += $(PLATCOMM)/manifest_soter.xml

BOARD_SEPOLICY_DIRS += vendor/sprd/generic/sepolicy/selinux/vendor/soter
endif

endif
