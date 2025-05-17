LOCAL_PATH := device/samsung/greatlte

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

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := universal8895
TARGET_NO_BOOTLOADER := true

# Kernel
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_SOURCE := kernel/samsung/universal8895

BOARD_USES_DT := true

#BOARD_KERNEL_CMDLINE := The bootloader ignores the cmdline from the boot.img
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_SEPARATED_DT := true

BOARD_CUSTOM_BOOTIMG := true
BOARD_CUSTOM_BOOTIMG_MK := hardware/samsung/mkbootimg.mk
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x01000000 --tags_offset 0x00000100

# Platform
TARGET_BOARD_PLATFORM := exynos5
TARGET_SOC := exynos8895
BOARD_VENDOR := samsung

# Inherit the proprietary files
include vendor/samsung/greatlte/BoardConfigVendor.mk