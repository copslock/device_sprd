PROPRIETARY_BOARD := pike2

#ifneq ($(shell ls -d vendor/sprd/proprietories-source 2>/dev/null),)
# for spreadtrum internal proprietories modules: only support package module names

PRODUCT_PACKAGES :=              \
    libomx_mp3dec_sprd           \
    libomx_m4vh263dec_sw_sprd    \
    libomx_m4vh263enc_sw_sprd    \
    libomx_avcdec_sw_sprd        \
    libomx_avcdec_hw_sprd        \
    libomx_avcenc_hw_sprd        \
    libjpeg_hw_sprd              \
    libomx_mp3enc_sprd           \
    thermald                     \
    cpu_loading                  \
    cpu_hotplug                  \
    cpu_trans_table              \
    dvfs_table                   \
    lit_cpu_freq                 \
    fix_cpu_freq                 \
    fix_gpu_freq                 \
    gpu_loading                  \
    gpu_trans_table              \
    ddr_bm                       \
    ddr_loading                  \
    ddr_trans_table              \
    fix_ddr_freq                 \
    bright                       \
    interrupt                    \
    tops                         \
    power_ctrl                   \
    power_hint                   \
    loading                      \
    paras

# add for volte
ifneq ($(filter $(VOLTE_SERVICE_ENABLE), volte_vowifi_shared volte_only), )
PRODUCT_PACKAGES += \
    VceDaemon \
    libvideo_call_engine_jni \
    libvolte_video_service_jni
endif

ifeq ($(strip $(VOLTE_SERVICE_ENABLE)), volte_only)
PRODUCT_PACKAGES += \
    modemDriver_vpad_main
endif

ifeq ($(strip $(VOLTE_SERVICE_ENABLE)), volte_vowifi_shared)
PRODUCT_PACKAGES += \
    ims_bridged \
    libnl \
    libimsbrd \
    libavatar \
    libzmf \
    libCamdrv24 \
    libmme_jrtc
endif

# Enable VOWIFI functions start
ifeq ($(strip $(VOWIFI_SERVICE_ENABLE)), true)

# vowifi source code module
PRODUCT_PACKAGES += \
    ims \
    SprdVoWifiService \
    ImsCM \
    operator_config.xml

# ims bridge daemon
PRODUCT_PACKAGES += \
    ims_bridged \
    libnl \
    libimsbrd

# SRMI module files
PRODUCT_PACKAGES += \
    libsrmi \
    srmi_proxyd

# ip monitor
PRODUCT_PACKAGES += ip_monitor.sh

# vowifi bin module
PRODUCT_PACKAGES += \
    vowifi_sdk \
    libavatar \
    libzmf \
    libCamdrv24 \
    liblemon \
    libmme_jrtc \
    ju_ipsec_server

# vowifi default rings
PRODUCT_PACKAGES += \
    Busy.wav \
    CallFailed.wav \
    CallWait.wav \
    Held.wav \
    NoAnswer.wav \
    RingBack.wav \
    Ringtone.wav \
    Term.wav \
    Tone0.wav \
    Tone1.wav \
    Tone2.wav \
    Tone3.wav \
    Tone4.wav \
    Tone5.wav \
    Tone6.wav \
    Tone7.wav \
    Tone8.wav \
    Tone9.wav \
    TonePound.wav \
    ToneStar.wav

# vowifi Airtel_IN rings
PRODUCT_PACKAGES += \
    Airtel_IN_RingBack.wav

endif
# Enable VOWIFI functions end

#exfat support
PRODUCT_PACKAGES += \
    mount.exfat \
    mkfs.exfat \
    fsck.exfat

PROPMODS :=                                     \
    system/lib/libomx_mp3dec_sprd.so            \
    system/lib/libomx_m4vh263dec_sw_sprd.so     \
    system/lib/libomx_m4vh263enc_sw_sprd.so     \
    system/lib/libomx_avcdec_sw_sprd.so         \
    system/lib/libomx_avcdec_hw_sprd.so         \
    system/lib/libomx_avcenc_hw_sprd.so         \
    vendor/lib/libjpeg_hw_sprd.so               \
    system/lib/libomx_mp3enc_sprd.so            \
    vendor/bin/thermald                         \
    system/bin/ylog                             \
    system/bin/ylogctl                          \
    system/bin/ylog_lite                        \
    system/bin/yloglitectl                      \
    system/lib/libylog.so                       \
    system/bin/ylogkat                          \
    system/bin/ylogbox


#config video engine for volte video call
ifneq ($(filter $(VOLTE_SERVICE_ENABLE), volte_vowifi_shared volte_only), )
PROPMODS += \
    system/app/VceDaemon \
    system/lib/libvideo_call_engine_jni.so \
    system/lib/libvolte_video_service_jni_.so
endif

ifeq ($(strip $(VOLTE_SERVICE_ENABLE)), volte_only)
PROPMODS += \
    system/bin/modemDriver_vpad_main
endif

ifeq ($(strip $(VOLTE_SERVICE_ENABLE)), volte_vowifi_shared)
PROPMODS += \
    system/bin/ims_bridged \
    system/lib/libimsbrd.so \
    system/lib/libavatar.so \
    system/lib/libzmf.so \
    system/lib/libCamdrv24.so \
    system/lib/libmme_jrtc.so
endif
