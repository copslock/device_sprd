# Copyright (C) 2015 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.radio.phone_count=2 \
    persist.radio.multisim.config=dsds \
    ro.telephony.default_network=9

# enable ims/modem_vpad
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.sys.volte.enable=true

$(call inherit-product, build/target/product/telephony.mk)
# telephony modules
PRODUCT_PACKAGES += \
    MmsFolderView \
    messaging \
    Stk  \
    UplmnSettings \
    urild \
    librilcore \
    libimpl-ril \
    libril-lite \
    librilutils \
    libatci \
    ModemNotifier \
    vendor.sprd.hardware.radio@1.0 \
    vendor.sprd.hardware.radio.lite@1.0 \
    libFactoryRadioTest \
    android.hardware.radio@1.2 \
    android.hardware.radio@1.3 \
    android.hardware.radio@1.4 \
    libril-private

# Volte config
PRODUCT_PACKAGES += \
    ims

# SPRD: FEATURE_VOLTE_CALLFORWARD_OPTIONS
PRODUCT_PACKAGES += \
    CallFireWall

# add sprd Contacts
PRODUCT_PACKAGES += \
    SprdContacts \
    SprdContactsProvider

#add for ril debug
PRODUCT_PACKAGES_DEBUG += \
    ril-cli

#add radioInteractor
PRODUCT_PACKAGES += \
    radio_interactor_service \
    radio_interactor_common
PRODUCT_BOOT_JARS += radio_interactor_common

#add ims common
PRODUCT_PACKAGES +=  unisoc_ims_common
PRODUCT_BOOT_JARS += unisoc_ims_common

#add ims permission
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.ims.xml

# telephony resource
include $(wildcard vendor/sprd/telephony-res/apply_telephony_res.mk)

# sprd cbcustomsetting
#$(call inherit-product, vendor/sprd/platform/packages/apps/CbCustomSetting/etc/device-sprd-cb.mk)

DISABLE_RILD_OEM_HOOK := true
