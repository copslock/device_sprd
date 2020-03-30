LOCAL_PATH := device/sprd/pike2/common
TARGET_CPU_SMP := true
TARGET_NO_KERNEL := false
ROOTCOMM := $(LOCAL_PATH)/rootdir
PLATCOMM := $(LOCAL_PATH)
BUILD_BROKEN_DUP_RULES := true

BOARD_SUPPORT_UMS_K44 := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
BOARD_KERNEL_SEPARATED_DT := true
USES_UNCOMPRESSED_KERNEL := true
BOARD_KERNEL_BASE :=  0x00000000
BOARD_KERNEL_CMDLINE := console=ttyS1,115200n8


#for boot image format requirements in AndroidQ
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x05400000 --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_KERNEL_PAGESIZE := 2048

#TARGET_GLOBAL_CFLAGS   += -mfpu=neon -mfloat-abi=softfp
#TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp

# graphics configs
USE_SPRD_HWCOMPOSER  := true
USE_OPENGL_RENDERER := true
USE_OVERLAY_COMPOSER_GPU := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
TARGET_USES_HWC2 := true
SPRD_TARGET_USES_HWC2 := true
TARGET_SUPPORT_ADF_DISPLAY := false

MALI_PLATFORM_NAME := pike2

SPRD_VIRTUAL_DISPLAY:= 1

# audio configs
BOARD_USES_GENERIC_AUDIO := true
BOARD_USES_TINYALSA_AUDIO := true
BOARD_USES_ALSA_AUDIO := false
BUILD_WITH_ALSA_UTILS := false
USE_LEGACY_AUDIO_POLICY := 0
USE_CUSTOM_AUDIO_POLICY := 1
SPRD_VBC_NOT_USE_AD23 := true
#SPRD: vbc support deepbufer mixer channel
SPRD_VBC_DEEPBUFFER_MIXER :=true
SPRD_AUDIO_VOIP_VERSION  :=v2

# telephony
#BOARD_SPRD_RIL := true
USE_BOOT_AT_DIAG :=true

# ota releasetools extensions
TARGET_RECOVERY_UPDATER_LIBS := libsprd_updater

#guangsheng fota start
FOTA_UPDATE_SUPPORT := false
FOTA_UPDATE_WITH_ICON := false
#end

#redstone fota
REDSTONE_FOTA_SUPPORT := false
REDSTONE_FOTA_APK_ICON := no
REDSTONE_FOTA_APK_KEY := none
REDSTONE_FOTA_APK_CHANNELID := none
#end
TARGET_OTA_EXTENSIONS_DIR := vendor/sprd/tools/ota
TARGET_RELEASETOOLS_EXTENSIONS := $(TARGET_OTA_EXTENSIONS_DIR)
#TARGET_RECOVERY_UI_LIB := librecovery_ui_whale2
# recovery configs
RECOVERYCOMM := $(PLATCOMM)/recovery
#TARGET_RECOVERY_FSTAB := $(RECOVERYCOMM)/recovery.fstab
# Temp disables it for bringup
#TARGET_RECOVERY_INITRC := $(RECOVERYCOMM)/init.rc

ifeq (f2fs,$(strip $(BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE)))
  RECOVERY_FSTAB_SUFFIX1 := .f2fs
endif
RECOVERY_FSTAB_SUFFIX := $(RECOVERY_FSTAB_SUFFIX1)
TARGET_RECOVERY_FSTAB := $(RECOVERYCOMM)/recovery$(RECOVERY_FSTAB_SUFFIX).fstab
# $(warning RECOVERY_FSTAB=$(TARGET_RECOVERY_FSTAB))
# $(warning RECOVERY_FSTAB=$(TARGET_RECOVERY_FSTAB))
# SPRD: add nvmerge config
TARGET_RECOVERY_NVMERGE_CONFIG := $(PLATCOMM)/nvmerge.cfg
#SPRD:modem update config
MODEM_UPDATE_CONFIG := true
MODEM_UPDATE_CONFIG_FILE := $(PLATCOMM)/modem.cfg
#OTA repart bin for P to Q--prebuild from P
OTA_PTOQ_REPART_BIN := $(BOARDDIR)/recovery/repart

# default value is 512M, using resize to adapter real size
BOARD_USERDATAIMAGE_PARTITION_SIZE := 536870912

BOARD_RESERVED_SPACE_ON := true

# SPRD: add for whale idh version {
#BOARD_IS_WHALE := true
# }

#SPRD：AVIExtractorEx
#USE_AVIExtractorEx :=true

#SPRD：WAVExtractorEx
#USE_WAVExtractorEx :=true

#SPRD：SUPPORT IMAADPCM
#SUPPORT_IMAADPCM :=true

#SPRD：SUPPORT FLVExtractor
#SUPPORT_FLVExtractor :=true

#SPRD：SUPPORT PSXSTRExtractor
#SUPPORT_PSXSTRExtractor :=true

#SPRD: support wcnd eng mode
USE_SPRD_ENG :=true

#SPRD: Use High Quality Dyn SRC
USE_HIGH_QUALITY_DYN_SRC :=true

TARGET_GPU_PLATFORM := midgard
GPU_GRALLOC_INCLUDES := $(TOP)/vendor/sprd/external/drivers/gpu/$(TARGET_GPU_PLATFORM)/include


#ifeq ($(strip $(TARGET_GPU_PLATFORM)),midgard)
#    PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
#        ro.hwui.use_offline_shader=1
#endif

#vsp config
TARGET_VSP_PLATFORM := pike2
SUPPORT_RGB_ENC := true
#SPRD: streaming extention, AOSP should be false.
USE_SPRD_STREAMING_EX := true

# set property overrides split
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

#Supprot camera filter mode. 0:Sprd 1:Arcsoft
TARGET_BOARD_CAMERA_FILTER_VERSION := 0

#vendor apps are restricted to use these versions
#Camera Power and Performence optimization
CONFIG_CAMERA_DFS_FIXED_MAXLEVEL := 2
CONFIG_HAS_CAMERA_HINTS_VERSION := 901

#GPU interface
TARGET_BOARD_CAMERA_3DNR_CAPTURE_GPU := true

#sprd jpeg hardware codec support
TARGET_BOARD_SPRD_JPEG_CODEC_SUPPORT := true

#for dynamic partitions feature
BOARD_BUILD_SUPER_IMAGE_BY_DEFAULT := true
BOARD_SUPER_PARTITION_SIZE :=4404019200
BOARD_SUPER_PARTITION_GROUPS := group_unisoc
BOARD_GROUP_UNISOC_SIZE := 4404019200
BOARD_GROUP_UNISOC_PARTITION_LIST := system vendor product

# bsp uapi path
TARGET_BSP_UAPI_PATH := $(TOP)/bsp/out/$(TARGET_BOARD)/headers
TARGET_BSP_KERNEL_PATH := $(TOP)/bsp/kernel/$(KERNEL_PATH)

#boark NAME
BOARD_NAME := pike2

#for cali mode use boot.img
BOARD_CALIMODE_USE_BOOTIMG := true
