# API
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_n.mk)

# Bootanimation
TARGET_SCREEN_HEIGHT := 2560
TARGET_SCREEN_WIDTH := 1440

# Dalvik
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Graphics
# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := xlarge
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi
# A list of dpis to select prebuilt apk, in precedence order.
PRODUCT_AAPT_PREBUILT_DPI := xxxhdpi xxhdpi xhdpi hdpi

# Partitions - dynamic
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Init files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/fstab.samsungexynos8895:$(TARGET_OUT_VENDOR_ETC)/fstab.samsungexynos8895

# Vendor blobs
$(call inherit-product, vendor/samsung/greatlte/greatlte-vendor.mk)