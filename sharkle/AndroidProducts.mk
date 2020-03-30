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
        sp9832e_1h10_gofu:$(LOCAL_DIR)/sp9832e_1h10_go/sp9832e_1h10_gofu.mk \
        sp9832e_1h10_gofu_nsec:$(LOCAL_DIR)/sp9832e_1h10_go/sp9832e_1h10_gofu_nsec.mk \
        sp9832e_1h10_go2g:$(LOCAL_DIR)/sp9832e_1h10_go/sp9832e_1h10_go2g.mk \
        sl8541e_1h10_Natv:$(LOCAL_DIR)/sl8541e_1h10/sl8541e_1h10_Natv.mk \

COMMON_LUNCH_CHOICES := \
        sp9832e_1h10_gofu-userdebug-native \
        sp9832e_1h10_gofu-userdebug-gms \
        sp9832e_1h10_gofu_nsec-userdebug-native \
        sp9832e_1h10_go2g-userdebug-native \
        sp9832e_1h10_go2g-userdebug-gms \
	sl8541e_1h10_Natv-userdebug-native \
	sl8541e_1h10_Natv-userdebug-gms \

