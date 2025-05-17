# API
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_n.mk)

# Bootanimation
TARGET_SCREEN_HEIGHT := 2560
TARGET_SCREEN_WIDTH := 1440

# Dalvik
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Graphics
# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := xlarge
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi
# A list of dpis to select prebuilt apk, in precedence order.
PRODUCT_AAPT_PREBUILT_DPI := xxxhdpi xxhdpi xhdpi hdpi

# Vendor blobs
$(call inherit-product, vendor/samsung/greatlte/greatlte-vendor.mk)