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

include device/sprd/sharkle/sp9832e_1h10_go/sp9832e_1h10_gofu.mk


# Override
PRODUCT_NAME := sp9832e_1h10_gofu_nsec

#no secure boot
BOARD_SECBOOT_CONFIG := false
