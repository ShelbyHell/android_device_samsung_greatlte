# API
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_n.mk)

# Bootanimation
TARGET_SCREEN_HEIGHT := 2560
TARGET_SCREEN_WIDTH := 1440

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl:64 \
    android.hardware.bluetooth@1.0-service

# Camera
PRODUCT_PACKAGES += \
    libhwjpeg

# Configstore
PRODUCT_PACKAGES += \
    disable_configstore

# Dalvik
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.composer.hwc3-service.slsi \
    android.hardware.graphics.mapper@2.0-impl \
    android.hardware.memtrack@1.0-impl \
    hwcomposer.exynos5 \
    gralloc.exynos5 \
    libion

PRODUCT_PACKAGES += \
    android.hardware.drm@1.0 \
    android.hardware.drm@1.1 \
    libfwdlockengine \
    libdrmclearkeyplugin \
    android.hardware.drm@1.0-service \
    android.hardware.drm@1.1-service.clearkey \
    android.hardware.drm@1.0-impl

# Fastbootd
PRODUCT_PACKAGES += fastbootd

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service \
    android.hardware.gatekeeper@1.0-impl \
    libgatekeeper

# Graphics
# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := xlarge
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi
# A list of dpis to select prebuilt apk, in precedence order.
PRODUCT_AAPT_PREBUILT_DPI := xxxhdpi xxhdpi xhdpi hdpi

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0 \
    android.hardware.keymaster@3.0-service \
    android.hardware.keymaster@3.0-impl \
    libkeymaster3device

# Memtrack
PRODUCT_PACKAGES += \
    android.hardware.memtrack-service.samsung-mali

# OMX
PRODUCT_PACKAGES += \
    libstagefrighthw \
    libExynosOMX_Core \
    libExynosOMX_Resourcemanager \
    libOMX.Exynos.AVC.Decoder \
    libOMX.Exynos.AVC.Encoder \
    libOMX.Exynos.HEVC.Decoder \
    libOMX.Exynos.HEVC.Encoder \
    libOMX.Exynos.MPEG4.Decoder \
    libOMX.Exynos.MPEG4.Encoder \
    libOMX.Exynos.VP8.Decoder \
    libOMX.Exynos.VP8.Encoder \
    libOMX.Exynos.VP9.Decoder \
    libOMX.Exynos.VP9.Encoder \
    libOMX.Exynos.WMV.Decoder

# Partitions - dynamic
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Init files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/fstab.samsungexynos8895:$(TARGET_OUT_VENDOR_ETC)/fstab.samsungexynos8895 \
    $(LOCAL_PATH)/init/fstab.samsungexynos8895:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.samsungexynos8895

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/init.recovery.universal8895.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.universal8895.rc \
    $(LOCAL_PATH)/init/init.samsungexynos8895.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.samsungexynos8895.rc \
    $(LOCAL_PATH)/init/init.samsungexynos8895.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.samsungexynos8895.usb.rc \
    $(LOCAL_PATH)/init/init.samsung.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.samsung.rc \
    $(LOCAL_PATH)/init/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.rc \
    $(LOCAL_PATH)/init/wifi.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/wifi.rc

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0 \
    android.hardware.sensors@1.0-impl \
    android.hardware.sensors@1.0-service

# Vibrator
PRODUCT_PACKAGES += android.hardware.vibrator@1.0-service.samsung-haptic

# Wi-Fi
PRODUCT_PACKAGES += \
    macloader \
    wifiloader \
    hostapd \
    wificond \
    wifilogd \
    wlutil \
    libwpa_client \
    wpa_supplicant \
    wpa_supplicant.conf \
    android.hardware.wifi@1.0-service \
    android.hardware.wifi@1.0 \
    android.hardware.wifi@1.0-impl

# Vendor blobs
$(call inherit-product, vendor/samsung/greatlte/greatlte-vendor.mk)