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
# Modem Functions

PRODUCT_PACKAGES += \
    calibration_init \
    modem_control \
    refnotify \
    slogmodem \
    slogmodem_vendor \
    iqfeed \
    cplogctl \
    cp_diskserver \
    mlogservice \

# Modem Prop
ifeq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.modem.log_dest=0 \
    persist.vendor.wcn.log_dest=0 \
    persist.vendor.sys.modemreset=1 \
    persist.vendor.sys.modem.save_dump=0
else
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.modem.log_dest=2 \
    persist.vendor.wcn.log_dest=2 \
    persist.vendor.sys.modemreset=0 \
    persist.vendor.sys.modem.save_dump=1
endif # TARGET_BUILD_VARIANT == user

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.product.partitionpath=/dev/block/platform/soc/soc:ap-ahb/20600000.sdio/by-name/ \
    ro.vendor.modem.dev=/proc/cptl/ \
    ro.vendor.modem.tty=/dev/stty_lte \
    ro.vendor.modem.eth=seth_lte \
    ro.vendor.modem.snd=1 \
    ro.vendor.radio.modemtype=l\
    ro.vendor.modem.diag=/dev/sdiag_lte \
    ro.vendor.modem.log=/dev/slog_lte \
    ro.vendor.modem.loop=/dev/spipe_lte0 \
    ro.vendor.modem.nv=/dev/spipe_lte1 \
    ro.vendor.modem.assert=/dev/spipe_lte2 \
    ro.modem.l.vbc=/dev/spipe_lte6 \
    ro.modem.l.id=0 \
    ro.vendor.modem.fixnv_size=0x80000 \
    ro.vendor.modem.runnv_size=0xa0000 \
    persist.vendor.modem.nvp=w_ \
    persist.vendor.modem.l.enable=1 \
    persist.vendor.sys.isfirstboot=1 \
    ro.vendor.sp.log=/dev/slog_pm

