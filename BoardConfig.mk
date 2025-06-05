#
# Copyright (C) 2018 The LineageOS Project
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

DEVICE_PATH := device/samsung/greatlte

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53.a57

# Assert
TARGET_OTA_ASSERT_DEVICE := greatlte

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth
BOARD_CUSTOM_BT_CONFIG := $(DEVICE_PATH)/bluetooth/libbt_vndcfg.txt
BOARD_HAVE_BLUETOOTH := true

# Backlight
BACKLIGHT_PATH := "/sys/class/backlight/panel/brightness"

# Build Hacks
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Display
TARGET_SCREEN_DENSITY := 480

# Fingerprint
TARGET_SEC_FP_HAS_FINGERPRINT_GESTURES := true

# Firmware
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Kernel
BOARD_CUSTOM_BOOTIMG := true
BOARD_CUSTOM_BOOTIMG_MK := hardware/samsung/mkbootimg.mk

BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_SEPARATED_DT := true
BOARD_MKBOOTIMG_ARGS := \
    --kernel_offset 0x00008000 \
    --ramdisk_offset 0x01000000 \
    --tags_offset 0x00000100

BOARD_USES_DT := true

TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_SOURCE := kernel/samsung/universal8895
TARGET_KERNEL_CONFIG := exynos8895-greatlte_defconfig

TARGET_CUSTOM_DTBTOOL := dtbhtoolExynos
TARGET_SPECIFIC_HEADER_PATH := $(DEVICE_PATH)/include

TARGET_KERNEL_ADDITIONAL_FLAGS := \
    HOSTCFLAGS="-fuse-ld=lld -Wno-unused-command-line-argument"

# Lineage Health
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_PATH := /sys/class/power_supply/battery/batt_slate_mode
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED := 0
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED := 1
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS := false
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE := true
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE := false

# Use these flags if the board has a ext4 partition larger than 2gb
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4

# Partitions
BOARD_FLASH_BLOCK_SIZE := 4096

BOARD_BOOTIMAGE_PARTITION_SIZE     :=  41943040 #(40960 sda7)
BOARD_CACHEIMAGE_PARTITION_SIZE    :=  524288000 #(512000 sda18)
BOARD_RECOVERYIMAGE_PARTITION_SIZE :=  48234496 #(47104 sda8)
BOARD_SYSTEMIMAGE_PARTITION_SIZE   :=  4508876800 #(4454400 sda17)
BOARD_USERDATAIMAGE_PARTITION_SIZE :=  58556678144 #(57184256 sda24)

BOARD_ROOT_EXTRA_FOLDERS += efs cpefs
BOARD_USES_METADATA_PARTITION := true
TARGET_COPY_OUT_VENDOR := system/vendor

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/system.prop

# Platform
TARGET_BOARD_PLATFORM := exynos5
TARGET_SOC := exynos8895
TARGET_BOOTLOADER_BOARD_NAME := universal8895
BOARD_VENDOR := samsung

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/init/fstab.samsungexynos8895
BOARD_USES_FULL_RECOVERY_IMAGE := false

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# Sepolicy
BOARD_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor
BOARD_SEPOLICY_TEE_FLAVOR := mobicore
SELINUX_IGNORE_NEVERALLOWS := true
include device/lineage/sepolicy/exynos/sepolicy.mk
include device/samsung_slsi/sepolicy/sepolicy.mk

# VINTF
PRODUCT_ENFORCE_VINTF_MANIFEST_OVERRIDE := true
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/configs/vintf/manifest.xml

# Vendor
-include vendor/samsung/greatlte/BoardConfigVendor.mk

# Wifi
BOARD_WLAN_BCMDHD_SAE            := true
BOARD_WLAN_DEVICE                := bcmdhd
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_bcmdhd
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WPA_SUPPLICANT_VERSION           := VER_0_8_X
