include device/sprd/sharkl5Pro/ums512_1h10/ums512_1h10_Natv.mk

PRODUCT_REVISION := cmcc
include $(APPLY_PRODUCT_REVISION)

# Override
PRODUCT_NAME := ums512_1h10_cmcc

# add animation resource.
$(call inherit-product-if-exists, vendor/sprd/carriers/cmcc/files/res/boot/boot_res_cmcc_4g_1080x2160.mk)
