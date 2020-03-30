include device/sprd/qogirn6pro/ums7520_haps/ums7520_haps_Natv.mk

PRODUCT_REVISION := multi-lang telcel
include $(APPLY_PRODUCT_REVISION)

PRODUCT_PROPERTY_OVERRIDES += persist.sys.videotelcel=3

AUDIO_SMARTAMP_CONFIG = unsupport

AUDIO_HIFI_CONFIG = support

# Override
PRODUCT_NAME := ums7520_haps_telcel
