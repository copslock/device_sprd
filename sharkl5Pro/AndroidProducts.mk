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
        ums512_1h10_Natv:$(LOCAL_DIR)/ums512_1h10/ums512_1h10_Natv.mk \
        ums512_1h10_nosec:$(LOCAL_DIR)/ums512_1h10/ums512_1h10_nosec.mk \
        ums512_1h10_cmcc:$(LOCAL_DIR)/ums512_1h10/ums512_1h10_cmcc.mk \
        ums512_lwfq_1h10_ctcc:$(LOCAL_DIR)/ums512_1h10/ums512_lwfq_1h10_ctcc.mk \
        ums512_1h10_ctcc:$(LOCAL_DIR)/ums512_1h10/ums512_1h10_ctcc.mk \
        ums512_1h10_telcel:$(LOCAL_DIR)/ums512_1h10/ums512_1h10_telcel.mk \
        ums512_1h10_cmcc_nosec:$(LOCAL_DIR)/ums512_1h10/ums512_1h10_cmcc_nosec.mk \
        ums512_1h10_ctcc_nosec:$(LOCAL_DIR)/ums512_1h10/ums512_1h10_ctcc_nosec.mk \
        ums512_1h10_oversea:$(LOCAL_DIR)/ums512_1h10/ums512_1h10_oversea.mk \
        ums512_20c10_native:$(LOCAL_DIR)/ums512_20c10/ums512_20c10_native.mk \
        ums512_20c10_ctcc:$(LOCAL_DIR)/ums512_20c10/ums512_20c10_ctcc.mk

COMMON_LUNCH_CHOICES := \
        ums512_1h10_Natv-userdebug-native \
        ums512_1h10_Natv-userdebug-gms \
        ums512_1h10_nosec-userdebug-native \
        ums512_1h10_cmcc-userdebug-native \
        ums512_lwfq_1h10_ctcc-userdebug-native \
        ums512_1h10_ctcc-userdebug-native \
        ums512_1h10_telcel-userdebug-native \
        ums512_1h10_cmcc_nosec-userdebug-native \
        ums512_1h10_ctcc_nosec-userdebug-native \
        ums512_1h10_oversea-userdebug-native \
        ums512_20c10_native-userdebug-native \
        ums512_20c10_ctcc-userdebug-native
