# Override
PRODUCT_PROPERTY_OVERRIDES := \
persist.vendor.radio.primarysim=1 \
ro.vendor.radio.fixed_slot=true \
persist.sys.callforwarding=2 \
persist.vendor.radio.vsim.product=2 \
$(PRODUCT_PROPERTY_OVERRIDES)

PRODUCT_PACKAGES += VsimService
