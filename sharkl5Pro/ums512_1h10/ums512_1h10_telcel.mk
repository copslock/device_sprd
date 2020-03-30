include device/sprd/sharkl5Pro/ums512_1h10/ums512_1h10_Natv.mk

PRODUCT_REVISION := multi-lang telcel
include $(APPLY_PRODUCT_REVISION)

PRODUCT_PROPERTY_OVERRIDES += persist.sys.videotelcel=3

AUDIO_SMARTAMP_CONFIG = unsupport

AUDIO_HIFI_CONFIG = support

# Override
PRODUCT_NAME := ums512_1h10_telcel
