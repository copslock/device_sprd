# This makefile is used to generate device tree image

# secureboot avb dtb/dtbo
ifeq ($(BOARD_AVB_ENABLE),true)
BOARD_BUILT_DTBOIMAGE := true
endif

#----------------------------------------------------------------------
# Generate device tree image (dtb.img)
#----------------------------------------------------------------------
DTBTOOL := $(HOST_OUT_EXECUTABLES)/dtbTool$(HOST_EXECUTABLE_SUFFIX)

INSTALLED_DTIMAGE_TARGET := $(PRODUCT_OUT)/dtb.img
INSTALLED_DTBIMAGE_TARGET_FOR_RECOVERY := $(PRODUCT_OUT)/recovery-dtb.img

ifeq ($(TARGET_KERNEL_ARCH), arm64)
DTB := $(KERNEL_OUT)/arch/$(TARGET_KERNEL_ARCH)/boot/dts/sprd/
endif

ifeq ($(TARGET_KERNEL_ARCH), arm)
DTB := $(KERNEL_OUT)/arch/$(TARGET_KERNEL_ARCH)/boot/dts/
endif

define build-dtbimage-target
    $(call pretty,"Target dtb image: $(INSTALLED_DTIMAGE_TARGET)")
    @-find $(DTB) -name *.dtb ! -name $(TARGET_DTB).dtb | xargs -I{} rm {}
    rm -f $(INSTALLED_DTIMAGE_TARGET)
    $(DTBTOOL) -o $@ -s $(BOARD_KERNEL_PAGESIZE) -p $(KERNEL_OUT)/scripts/dtc/ $(DTB)
    $(hide) chmod a+r $@
    $(hide) -$(ACP) $@ $(INSTALLED_DTBIMAGE_TARGET_FOR_RECOVERY) -rfv
endef

.PHONY: $(INSTALLED_DTIMAGE_TARGET)
$(INSTALLED_DTIMAGE_TARGET): $(DTBTOOL) $(TARGET_PREBUILT_KERNEL) $(AVBTOOL)
	$(build-dtbimage-target)
ifeq ($(BOARD_AVB_ENABLE),true)
	$(warning avb is enable)
	$(AVBTOOL) add_hash_footer \
		--image $(INSTALLED_DTIMAGE_TARGET) \
		--partition_size $(BOARD_DTBIMG_PARTITION_SIZE) \
		--partition_name dtb $(INTERNAL_AVB_DTBO_SIGNING_ARGS) \
		$(BOARD_AVB_DTBO_ADD_HASH_FOOTER_ARGS)
else
	$(warning avb is disable)
endif
ALL_DEFAULT_INSTALLED_MODULES += $(INSTALLED_DTIMAGE_TARGET)
ALL_MODULES.$(LOCAL_MODULE).INSTALLED += $(INSTALLED_DTIMAGE_TARGET)

.PHONY: dtbimage
dtbimage: $(DTBTOOL) $(KERNEL_CONFIG) FORCE $(AVBTOOL)
	$(MAKE) -C $(KERNEL_PATH) O=../$(KERNEL_OUT) ARCH=$(TARGET_KERNEL_ARCH) CROSS_COMPILE=$(KERNEL_CROSS_COMPILE) dtbs
	@-find $(DTB) -name *.dtb ! -name $(TARGET_DTB).dtb | xargs -I{} rm {}
	$(call pretty,"DTB value: $(DTB)")
	rm -f $(INSTALLED_DTIMAGE_TARGET)
	$(DTBTOOL) -o $(INSTALLED_DTIMAGE_TARGET) -s $(BOARD_KERNEL_PAGESIZE) -p $(KERNEL_OUT)/scripts/dtc/ $(DTB)
	$(hide) chmod a+r $(INSTALLED_DTIMAGE_TARGET)
	$(hide) -$(ACP) $(INSTALLED_DTBIMAGE_TARGET) $(INSTALLED_DTBIMAGE_TARGET_FOR_RECOVERY) -rfv
ifeq ($(BOARD_AVB_ENABLE),true)
	$(warning avb is enable)
	$(AVBTOOL) add_hash_footer \
		--image $(INSTALLED_DTIMAGE_TARGET) \
		--partition_size $(BOARD_DTBIMG_PARTITION_SIZE) \
		--partition_name dtb $(INTERNAL_AVB_DTBO_SIGNING_ARGS) \
		$(BOARD_AVB_DTBO_ADD_HASH_FOOTER_ARGS)
else
	$(warning avb is disable)
endif
#----------------------------------------------------------------------
# Generate device tree overlay image (dtbo.img)
#----------------------------------------------------------------------
MKDTIMG := prebuilts/misc/linux-x86/libufdt/mkdtimg
INSTALLED_DTBOIMAGE_TARGET := $(PRODUCT_OUT)/dtbo.img
INSTALLED_DTBOIMAGE_TARGET_FOR_RECOVERY := $(PRODUCT_OUT)/recovery-dtbo.img

ifeq ($(TARGET_KERNEL_ARCH), arm64)
DTBO := $(KERNEL_OUT)/arch/$(TARGET_KERNEL_ARCH)/boot/dts/sprd/
endif

ifeq ($(TARGET_KERNEL_ARCH), arm)
DTBO := $(KERNEL_OUT)/arch/$(TARGET_KERNEL_ARCH)/boot/dts/
endif

define build-dtboimage-target
	$(call pretty,"Target dtbo image: $(INSTALLED_DTBOIMAGE_TARGET)")
	$(MKDTIMG) create $@ $(DTBO)$(TARGET_DTBO).dtbo --id=0
	$(hide) chmod a+r $@
	$(hide) -$(ACP) $@ $(INSTALLED_DTBOIMAGE_TARGET_FOR_RECOVERY) -rfv
endef

.PHONY: $(INSTALLED_DTBOIMAGE_TARGET)
$(INSTALLED_DTBOIMAGE_TARGET): $(MKDTIMG) $(TARGET_PREBUILT_KERNEL) $(AVBTOOL)
	$(build-dtboimage-target)
ifeq ($(BOARD_AVB_ENABLE),true)
	$(warning avb is enable)
	$(AVBTOOL) add_hash_footer \
		--image $(INSTALLED_DTBOIMAGE_TARGET) \
		--partition_size $(BOARD_DTBOIMG_PARTITION_SIZE) \
		--partition_name dtbo $(INTERNAL_AVB_DTBO_SIGNING_ARGS) \
		$(BOARD_AVB_DTBO_ADD_HASH_FOOTER_ARGS)
else
	$(warning avb is disable)
endif
ALL_DEFAULT_INSTALLED_MODULES += $(INSTALLED_DTBOIMAGE_TARGET)
ALL_MODULES.$(LOCAL_MODULE).INSTALLED += $(INSTALLED_DTBOIMAGE_TARGET)

.PHONY: dtboimage
dtboimage: $(MKDTIMG) $(KERNEL_CONFIG) FORCE $(AVBTOOL)
	$(MAKE) -C $(KERNEL_PATH) O=../$(KERNEL_OUT) ARCH=$(TARGET_KERNEL_ARCH) CROSS_COMPILE=$(KERNEL_CROSS_COMPILE) dtbs
	$(MKDTIMG) create $(INSTALLED_DTBOIMAGE_TARGET) $(DTBO)$(TARGET_DTBO).dtbo --id=0
	$(hide) chmod a+r $(INSTALLED_DTBOIMAGE_TARGET)
	$(hide) -$(ACP) $(INSTALLED_DTBOIMAGE_TARGET) $(INSTALLED_DTBOIMAGE_TARGET_FOR_RECOVERY) -rfv
ifeq ($(BOARD_AVB_ENABLE),true)
	$(warning avb is enable)
	$(AVBTOOL) add_hash_footer \
		--image $(INSTALLED_DTBOIMAGE_TARGET) \
		--partition_size $(BOARD_DTBOIMG_PARTITION_SIZE) \
		--partition_name dtbo $(INTERNAL_AVB_DTBO_SIGNING_ARGS) \
		$(BOARD_AVB_DTBO_ADD_HASH_FOOTER_ARGS)
else
	$(warning avb is disable)
endif
