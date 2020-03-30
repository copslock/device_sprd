include device/sprd/qogirn6pro/ums7520_haps/ums7520_haps_Natv.mk

PRODUCT_REVISION := cmcc
include $(APPLY_PRODUCT_REVISION)

# Override
PRODUCT_NAME := ums7520_haps_cmcc

# add animation resource.
$(call inherit-product-if-exists, vendor/sprd/carriers/cmcc/files/res/boot/boot_res_cmcc_4g_1080x2160.mk)
