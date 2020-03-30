LOCAL_PATH := $(call my-dir)

include $(PLATCOMM)/ModemBuild.mk

# Compile U-Boot
ifneq ($(strip $(TARGET_NO_BOOTLOADER)),true)
INSTALLED_UBOOT_TARGET := $(PRODUCT_OUT)/u-boot.bin
INSTALLED_CHIPRAM_TARGET := $(PRODUCT_OUT)/u-boot-spl-16k.bin
-include u-boot15/AndroidUBoot.mk
-include chipram/AndroidChipram.mk


.PHONY: bootloader
bootloader: $(INSTALLED_UBOOT_TARGET)

ALL_DEFAULT_INSTALLED_MODULES += $(INSTALLED_UBOOT_TARGET)
ALL_MODULES.$(LOCAL_MODULE).INSTALLED += $(INSTALLED_UBOOT_TARGET)

.PHONY: chipram
chipram: $(INSTALLED_CHIPRAM_TARGET)

ALL_DEFAULT_INSTALLED_MODULES += $(INSTALLED_CHIPRAM_TARGET)
ALL_MODULES.$(LOCAL_MODULE).INSTALLED += $(INSTALLED_CHIPRAM_TARGET)
endif # End of U-Boot

# Compile Linux Kernel
ifneq ($(strip $(TARGET_NO_KERNEL)),true)
#-include device/sprd/sharkl3/common/AndroidKernel.mk
include $(KERNEL_PATH)/AndroidKernel.mk
file := $(PRODUCT_OUT)/kernel
#ALL_PREBUILT += $(file)
$(file) : $(TARGET_PREBUILT_KERNEL) | $(ACP)
	$(transform-prebuilt-to-target)
endif # End of Kernel

# Compile dtb
ifeq ($(strip $(BOARD_KERNEL_SEPARATED_DT)),true)
include device/sprd/sharkl3/common/generate_dtb_image.mk
endif # End of dtb

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
