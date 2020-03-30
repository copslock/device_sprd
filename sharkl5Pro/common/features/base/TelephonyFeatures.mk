#VT config
ADDITIONAL_BUILD_PROPERTIES += \
    persist.sys.support.vt=true \
    persist.sys.csvt=false \
    persist.sys.audio.source=true
#add for Telephony
ADDITIONAL_BUILD_PROPERTIES += \
    keyguard.no_require_sim=true \
    ro.com.android.dataroaming=false \
    ro.simlock.unlock.autoshow=1 \
    ro.simlock.unlock.bynv=0 \
    ro.simlock.onekey.lock=0
