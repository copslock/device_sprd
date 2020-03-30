
# storage init files, move storage prop to /system, depends on feature_configs/base/config.mk
ifeq ($(STORAGE_ORIGINAL), true)
    PRODUCT_COPY_FILES += \
        $(ROOTCOMM)/root/init.storage_original.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.storage.rc
else
PRODUCT_COPY_FILES += \
    $(ROOTCOMM)/root/init.storage_sprd.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.storage.rc
endif
