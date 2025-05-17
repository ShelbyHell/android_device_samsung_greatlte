#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/samsung/universal8895-common',
    'hardware/samsung_slsi-linaro/exynos',
    'hardware/samsung_slsi-linaro/graphics',
    'vendor/samsung/universal8895-common',
]

blob_fixups: blob_fixups_user_type = {
    ('vendor/firmware/fimc_is_lib.bin',
	 'vendor/firmware/fimc_is_rta_2l2_3h1.bin',
	 'vendor/firmware/fimc_is_rta_2l2_imx320.bin',
	 'vendor/firmware/fimc_is_rta_imx333_3h1.bin',
	 'vendor/firmware/fimc_is_rta_imx333_imx320.bin',): blob_fixup()
	.sig_replace('40 00 00 54 DE C0 AD', '02 00 00 14 00 00 00'),
} # fmt: skip

module = ExtractUtilsModule(
    'greatlte',
    'samsung',
    namespace_imports=namespace_imports,
    add_firmware_proprietary_file=True,
    blob_fixups=blob_fixups,
)

if __name__ == '__main__':
    utils = ExtractUtils.device_with_common(
        module, 'universal8895-common', module.vendor
    )
    utils.run()