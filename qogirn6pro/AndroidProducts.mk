#
# Copyright 2015 The Android Open-Source Project
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
#


PRODUCT_MAKEFILES += \
        ums7520_haps_Natv:$(LOCAL_DIR)/ums7520_haps/ums7520_haps_Natv.mk \
        ums7520_haps_nosec:$(LOCAL_DIR)/ums7520_haps/ums7520_haps_nosec.mk \
        ums7520_haps_cmcc:$(LOCAL_DIR)/ums7520_haps/ums7520_haps_cmcc.mk \
        ums7520_haps_ctcc:$(LOCAL_DIR)/ums7520_haps/ums7520_haps_ctcc.mk \
        ums7520_haps_telcel:$(LOCAL_DIR)/ums7520_haps/ums7520_haps_telcel.mk \
        ums7520_haps_cmcc_nosec:$(LOCAL_DIR)/ums7520_haps/ums7520_haps_cmcc_nosec.mk \
        ums7520_haps_ctcc_nosec:$(LOCAL_DIR)/ums7520_haps/ums7520_haps_ctcc_nosec.mk \
        ums7520_haps_oversea:$(LOCAL_DIR)/ums7520_haps/ums7520_haps_oversea.mk \
        ums7520_zebu_native:$(LOCAL_DIR)/ums7520_zebu/ums7520_zebu_native.mk \
        ums7520_zebu_nosec:$(LOCAL_DIR)/ums7520_zebu/ums7520_zebu_nosec.mk \

COMMON_LUNCH_CHOICES := \
        ums7520_haps_Natv-userdebug-native \
        ums7520_haps_Natv-userdebug-gms \
        ums7520_haps_nosec-userdebug-native \
        ums7520_haps_cmcc-userdebug-native \
        ums7520_haps_ctcc-userdebug-native \
        ums7520_haps_telcel-userdebug-native \
        ums7520_haps_cmcc_nosec-userdebug-native \
        ums7520_haps_ctcc_nosec-userdebug-native \
        ums7520_haps_oversea-userdebug-native \
        ums7520_zebu_native-userdebug-native \
        ums7520_zebu_nosec-userdebug-native \
