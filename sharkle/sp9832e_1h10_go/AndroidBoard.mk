LOCAL_PATH := $(call my-dir)

include $(PLATCOMM)/ModemBuild.mk

# Compile U-Boot
ifneq ($(strip $(TARGET_NO_BOOTLOADER)),true)
INSTALLED_UBOOT_TARGET := $(PRODUCT_OUT)/u-boot.bin
INSTALLED_CHIPRAM_TARGET := $(PRODUCT_OUT)/u-boot-spl-16k.bin
INSTALLED_SML_TARGET := $(PRODUCT_OUT)/sml.bin
INSTALLED_TRUSTY_TARGET := $(PRODUCT_OUT)/tos.bin


.PHONY: bootloader
bootloader: $(INSTALLED_UBOOT_TARGET)
$(INSTALLED_UBOOT_TARGET):
	@cp $(TARGET_BSP_OUT)/u-boot15/u-boot*.bin $(PRODUCT_OUT)
	@cp $(TARGET_BSP_OUT)/u-boot15/fdl2*.bin $(PRODUCT_OUT)

.PHONY: chipram
chipram: $(INSTALLED_CHIPRAM_TARGET)
$(INSTALLED_CHIPRAM_TARGET):
	@cp $(TARGET_BSP_OUT)/chipram/u-boot*.bin $(PRODUCT_OUT)
	@cp $(TARGET_BSP_OUT)/chipram/fdl1*.bin $(PRODUCT_OUT)

endif # End of U-Boot

.PHONY: bspallimage
ifneq ($(strip $(TARGET_NO_BOOTLOADER)),true)
bspallimage: bootloader chipram sml trusty bootimage dtboimage sockoimage
else
bspallimage: sml trusty bootimage dtboimage sockoimage
endif

.PHONY: sml
sml: $(INSTALLED_SML_TARGET)
$(INSTALLED_SML_TARGET):
	@cp $(TARGET_BSP_OUT)/sml/sml*.bin $(PRODUCT_OUT)

.PHONY: trusty
trusty: $(INSTALLED_TRUSTY_TARGET)
$(INSTALLED_TRUSTY_TARGET):
	@cp $(TARGET_BSP_OUT)/trusty/tos*.bin $(PRODUCT_OUT)

# Compile sprdisk
ifneq ($(strip $(TARGET_NO_SPRDISK)),true)
INSTALLED_SPRDISK_TARGET := $(PRODUCT_OUT)/sprdiskboot.img
-include sprdisk/Makefile

INSTALLED_RADIOIMAGE_TARGET += $(PRODUCT_OUT)/sprdiskboot.img

.PHONY: sprdisk
sprdisk: $(INSTALLED_SPRDISK_TARGET)

ALL_DEFAULT_INSTALLED_MODULES += $(INSTALLED_SPRDISK_TARGET)
ALL_MODULES.$(LOCAL_MODULE).INSTALLED += $(INSTALLED_SPRDISK_TARGET)
endif # End of sprdisk

BOARD_PREBUILT_DTBIMAGE_DIR := $(PRODUCT_OUT)
