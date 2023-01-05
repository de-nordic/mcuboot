/*
 * Copyright (c) 2018 Nordic Semiconductor ASA
 * Copyright (c) 2015 Runtime Inc
 *
 * SPDX-License-Identifier: Apache-2.0
 */
#ifndef __FLASH_MAP_BACKEND_H__
#define __FLASH_MAP_BACKEND_H__

#include <sysflash/sysflash.h>
#include <flash_map/flash_map.h>
#include <mcuboot_config/mcuboot_config.h>

#if (MCUBOOT_IMAGE_NUMBER == 1)

#define FLASH_AREA_IMAGE_PRIMARY(x)    (((x) == 0) ?          \
                                         FLASH_AREA_IMAGE_0 : \
                                         FLASH_AREA_IMAGE_0)
#define FLASH_AREA_IMAGE_SECONDARY(x)  (((x) == 0) ?          \
                                         FLASH_AREA_IMAGE_1 : \
                                         FLASH_AREA_IMAGE_1)

#elif (MCUBOOT_IMAGE_NUMBER == 2)

#define FLASH_AREA_IMAGE_PRIMARY(x)    (((x) == 0) ?          \
                                         FLASH_AREA_IMAGE_0 : \
                                        ((x) == 1) ?          \
                                         FLASH_AREA_IMAGE_2 : \
                                         255)
#define FLASH_AREA_IMAGE_SECONDARY(x)  (((x) == 0) ?          \
                                         FLASH_AREA_IMAGE_1 : \
                                        ((x) == 1) ?          \
                                         FLASH_AREA_IMAGE_3 : \
                                         255)

#else
#error "Image slot and flash area mapping is not defined"
#endif

struct flash_sector {
    uint32_t fs_off;
    uint32_t fs_size;
};

int flash_area_id_from_multi_image_slot(int image_index, int slot);
int flash_area_id_to_multi_image_slot(int image_index, int area_id);

int flash_area_get_sectors(int idx, uint32_t *cnt,
                           struct flash_sector *sectors);

static inline uint8_t flash_area_get_id(const struct flash_area *fa)
{
    return fa->fa_id;
}

static inline uint8_t flash_area_get_device_id(const struct flash_area *fa)
{
    return fa->fa_device_id;
}

static inline uint32_t flash_area_get_off(const struct flash_area *fa)
{
    return fa->fa_off;
}

static inline uint32_t flash_area_get_size(const struct flash_area *fa)
{
    return fa->fa_size;
}

static inline uint32_t flash_sector_get_off(const struct flash_sector *fa)
{
    return fa->fs_off;
}

static inline uint32_t flash_sector_get_size(const struct flash_sector *fa)
{
    return fa->fs_size;
}

#endif /* __FLASH_MAP_BACKEND_H__ */
