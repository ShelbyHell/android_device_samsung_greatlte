#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=greatlte
VENDOR=samsung

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
        vendor/etc/init/init.gps.rc)
            sed -i -z "s/    seclabel u:r:gpsd:s0\n//" "${2}"
            ;;
        etc/gps_debug.conf)
            sed -i "s/XTRA_SERVER_1/LONGTERM_PSDS_SERVER_1/" "${2}"
            sed -i "s/XTRA_SERVER_2/LONGTERM_PSDS_SERVER_2/" "${2}"
            ;;
        vendor/bin/hw/gpsd)
            sed -i "s/SSLv3_client_method/SSLv23_method\x00\x00\x00\x00\x00\x00/" "${2}"
            ;;
        lib/hw/audio.primary.exynos8895.so)
            "${PATCHELF}" --add-needed libaudioparams_shim.so "${2}"
            sed -i 's/str_parms_get_str/str_parms_get_mod/g' "${2}"
            "${PATCHELF}" --remove-needed libaudio_soundtrigger.so "${2}"
            "${PATCHELF}" --replace-needed libvndsecril-client.so libsecril-client.so "${2}"
            ;;
        lib/android.hardware.gnss@1.0.so|lib/android.hardware.gnss@1.1.so|lib/libGrallocWrapper.so|lib/libskeymaster.so|lib/vendor.samsung.hardware.gnss@1.0.so|lib/vendor.samsung_slsi.hardware.ExynosHWCServiceTW@1.0.so|lib64/android.hardware.gnss@1.0.so|lib64/android.hardware.gnss@1.1.so|lib64/libGrallocWrapper.so|lib64/libskeymaster.so|lib64/vendor.samsung.hardware.gnss@1.0.so|lib64/vendor.samsung_slsi.hardware.ExynosHWCServiceTW@1.0.so|vendor/bin/hw/android.hardware.drm@1.1-service.widevine|vendor/bin/hw/vendor.samsung.hardware.gnss@1.0-service|vendor/bin/hw/vendor.samsung_slsi.hardware.ExynosHWCServiceTW@1.0-service|vendor/lib/libskeymaster3device.so|vendor/lib/libstagefright_bufferqueue_helper_vendor.so|vendor/lib/libstagefright_omx_vendor.so|vendor/lib/libwvhidl.so|vendor/lib/sensors.sensorhub.so|vendor/lib64/hw/android.hardware.gnss@1.1-impl.so|vendor/lib64/hw/vendor.samsung.hardware.gnss@1.0-impl.so|vendor/lib64/libskeymaster3device.so|vendor/lib64/sensors.sensorhub.so|vendor/lib64/libsec-ril-dsds.so|vendor/lib64/libsec-ril.so|vendor/lib/libsec-ril-dsds.so|vendor/lib/libsec-ril.so)
            "${PATCHELF}" --remove-needed libhidltransport.so "${2}"
            ;;
        lib/android.hardware.gnss@1.0.so|lib/android.hardware.gnss@1.1.so|lib/vendor.samsung.hardware.gnss@1.0.so|lib/vendor.samsung_slsi.hardware.ExynosHWCServiceTW@1.0.so|lib64/android.hardware.gnss@1.0.so|lib64/android.hardware.gnss@1.1.so|lib64/vendor.samsung.hardware.gnss@1.0.so|lib64/vendor.samsung_slsi.hardware.ExynosHWCServiceTW@1.0.so|vendor/bin/hw/android.hardware.drm@1.1-service.widevine|vendor/lib/libwvhidl.so|vendor/lib64/hw/vendor.samsung.hardware.gnss@1.0-impl.so|vendor/lib64/libsec-ril-dsds.so|vendor/lib64/libsec-ril.so|vendor/lib/libsec-ril-dsds.so|vendor/lib/libsec-ril.so)
            "${PATCHELF}" --remove-needed libhwbinder.so "${2}"
            ;;
        vendor/lib/libwvhidl.so|vendor/lib/mediadrm/libwvdrmengine.so)
            "${PATCHELF}" --replace-needed libprotobuf-cpp-lite.so libprotobuf-cpp-lite-v29.so "${2}"
            ;;
        vendor/lib/libwrappergps.so|vendor/lib64/libwrappergps.so|lib/libaudio-ril.so)
            "${PATCHELF}" --replace-needed libvndsecril-client.so libsecril-client.so "${2}"
            ;;
        lib*/libexynoscamera.so)
            "${PATCHELF}" --add-needed libexynoscamera_shim.so "${2}"
            ;;
        lib*/libblurdetection_interface.so|lib*/libfocuspeaking_interface.so)
            "${PATCHELF}" --add-needed idev0_shim.so "${2}"
            ;;
        vendor/lib*/libexynosdisplay.so|vendor/lib*/hwcomposer.exynos5.so)
            "${PATCHELF}" --add-needed libexynosdisplay_shim.so "${2}"
            ;;
        vendor/firmware/fimc_is_lib.bin|vendor/firmware/fimc_is_rta_2l2_3h1.bin|vendor/firmware/fimc_is_rta_2l2_imx320.bin|vendor/firmware/fimc_is_rta_imx333_3h1.bin|vendor/firmware/fimc_is_rta_imx333_imx320.bin)
            hexdump -ve '1/1 "%.2X"' "${2}" | sed "s/40000054DEC0AD/02000014000000/g" | xxd -r -p > "${2}".patched
            mv "${2}".patched "${2}"
            ;;
    esac
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
