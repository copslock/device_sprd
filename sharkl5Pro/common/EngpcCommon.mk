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

# unisoc factory Functions


#engpc
PRODUCT_PACKAGES += \
    engpc \

#so: for common
PRODUCT_PACKAGES += \
    libcomcontrol \
    libengpc_adapt \
    librebootcmd \
    libreadfixednv \
    libdloader \
    libapcomm \

#so: for cali
PRODUCT_PACKAGES += \
    libtsxrawdata \
    libmiscdata \
    libapdeepsleep \
    libftmode \
    libeng_tok \
    libap_opt \
    libdcxcali \
    dcxsrv \
    libchipid \
    libtsensor \
    libnefuse \
    libgetswpac \

#so: for bbat test
PRODUCT_PACKAGES += \
    libgpio \
    autotestsensorinfo \
    autotestgps \
    autotestsim \
    autotesttcard \
    libkeypadnpi \
    liblcdnpi \
    liblkvnpi \
    libsensornpi \
    libeng_tok \
    libnpi_rtc \
    libcharge \

#engpc config
PRODUCT_COPY_FILES += \
    $(ROOTCOMM)/system/etc/engpc/dev/agdsp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/engpc/dev/agdsp.conf \
    $(ROOTCOMM)/system/etc/engpc/dev/ap.conf:$(TARGET_COPY_OUT_VENDOR)/etc/engpc/dev/ap.conf \
    $(ROOTCOMM)/system/etc/engpc/dev/cp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/engpc/dev/cp.conf \
    $(ROOTCOMM)/system/etc/engpc/dev/pc.conf:$(TARGET_COPY_OUT_VENDOR)/etc/engpc/dev/pc.conf \
    $(ROOTCOMM)/system/etc/engpc/dev/sensorhub.conf:$(TARGET_COPY_OUT_VENDOR)/etc/engpc/dev/sensorhub.conf \
    $(ROOTCOMM)/system/etc/engpc/dev/wcn.conf:$(TARGET_COPY_OUT_VENDOR)/etc/engpc/dev/wcn.conf \
    $(ROOTCOMM)/system/etc/engpc/chnl/autotest.conf:$(TARGET_COPY_OUT_VENDOR)/etc/engpc/chnl/autotest.conf \
    $(ROOTCOMM)/system/etc/engpc/chnl/cali.conf:$(TARGET_COPY_OUT_VENDOR)/etc/engpc/chnl/cali.conf \
    $(ROOTCOMM)/system/etc/engpc/chnl/normal.conf:$(TARGET_COPY_OUT_VENDOR)/etc/engpc/chnl/normal.conf \
    $(ROOTCOMM)/system/etc/engpc/chnl/normal_lite.conf:$(TARGET_COPY_OUT_VENDOR)/etc/engpc/chnl/normal_lite.conf \

#copy factorytest config
PRODUCT_COPY_FILES += \
    $(ROOTDIR)/prodnv/PCBA.conf:$(TARGET_COPY_OUT_VENDOR)/etc/PCBA.conf \
    $(ROOTDIR)/prodnv/BBAT.conf:$(TARGET_COPY_OUT_VENDOR)/etc/BBAT.conf

#init autotest.rc start
PRODUCT_COPY_FILES += vendor/sprd/proprietories-source/autotest/autotest.rc:vendor/etc/init/autotest.rc
#init autotest.rc end

#engpc support cali mode when product have no modem
PRODUCT_PROPERTY_OVERRIDES += \
  ro.vendor.modem.support=1

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/root/init.cali.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.cali.rc \
    $(LOCAL_PATH)/rootdir/root/fstab.cali:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.cali \
    $(LOCAL_PATH)/rootdir/root/init.factorytest.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.factorytest.rc \
    $(LOCAL_PATH)/rootdir/root/fstab.factorytest:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.factorytest \
