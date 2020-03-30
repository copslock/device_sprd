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
        s9863a1h10_go_Natv:$(LOCAL_DIR)/s9863a1h10_go/s9863a1h10_go_Natv.mk \
        s9863a3h10_Natv:$(LOCAL_DIR)/s9863a3h10/s9863a3h10_Natv.mk \
        s9863a1h10_Natv:$(LOCAL_DIR)/s9863a1h10/s9863a1h10_Natv.mk \
        s9863a1h10_Tsg:$(LOCAL_DIR)/s9863a1h10/s9863a1h10_Tsg.mk \
        s9863a1h10_nosec:$(LOCAL_DIR)/s9863a1h10/s9863a1h10_nosec.mk \
        s9863a2h10_Natv:$(LOCAL_DIR)/s9863a2h10/s9863a2h10_Natv.mk \
        s9863a3h10_go_32b_Natv:$(LOCAL_DIR)/s9863a3h10_go/s9863a3h10_go_32b_Natv.mk \
        s9863a1h10_go_32b_Natv:$(LOCAL_DIR)/s9863a1h10_go_32b/s9863a1h10_go_32b_Natv.mk \
        s9863a10c10_Natv:$(LOCAL_DIR)/s9863a10c10/s9863a10c10_Natv.mk \
        s9863a3c10_go_32b_Natv:$(LOCAL_DIR)/s9863a3c10_go/s9863a3c10_go_32b_Natv.mk \
        s9863a3c10_Natv:$(LOCAL_DIR)/s9863a3c10/s9863a3c10_Natv.mk \
        s9863a1c10_Natv:$(LOCAL_DIR)/s9863a1c10/s9863a1c10_Natv.mk \
        s9863a1h10_go_32b_2g:$(LOCAL_DIR)/s9863a1h10_go_32b/s9863a1h10_go_32b_2g.mk

COMMON_LUNCH_CHOICES := \
        s9863a1h10_go_Natv-userdebug \
        s9863a3h10_Natv-userdebug-native \
        s9863a3h10_Natv-userdebug-gms \
        s9863a1h10_Natv-userdebug-native \
        s9863a1h10_Natv-userdebug-gms \
        s9863a1h10_Tsg-userdebug \
        s9863a1h10_nosec-userdebug-native \
        s9863a2h10_Natv-userdebug-native \
        s9863a2h10_Natv-userdebug-gms \
        s9863a3h10_go_32b_Natv-userdebug-native \
        s9863a3h10_go_32b_Natv-userdebug-gms \
        s9863a1h10_go_32b_Natv-userdebug \
        s9863a1h10_go_32b_Natv-userdebug-gms \
        s9863a10c10_Natv-userdebug-native \
        s9863a10c10_Natv-userdebug-gms \
        s9863a3c10_go_32b_Natv-userdebug-native \
        s9863a3c10_go_32b_Natv-userdebug-gms \
        s9863a3c10_Natv-userdebug-native \
        s9863a3c10_Natv-userdebug-gms \
        s9863a1c10_Natv-userdebug-native \
        s9863a1c10_Natv-userdebug-gms \
        s9863a1h10_go_32b_2g-userdebug-native \
        s9863a1h10_go_32b_2g-userdebug-gms \

