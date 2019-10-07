################################################################################
# \file libs.mk
# \version 1.0
#
# \brief
# Makefile to describe libraries needed for CyBootloader based applications.
#
################################################################################
# \copyright
# Copyright 2018-2019 Cypress Semiconductor Corporation
# SPDX-License-Identifier: Apache-2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################



#### THIS IS JUST A SKELETON - NEEDS TO BE MODIFIED!!!!!!!




################################################################################
# JWT and Cypress policy libraries
################################################################################
INCLUDES_JWT := -I./jwt/ -I./cJSON/ -I./nvstore/ -I./base64/
SOURCES_JWT  := $(wildcard ./jwt/*.c) $(wildcard ./cJSON/*.c)  $(wildcard ./nvstore/*.c) $(wildcard ./base64/*.c)
DEFINES_JWT  := -DHAVE_STDINT_H -DHAVE_STDINT_H -DSIZEOF_UNSIGNED_INT=4 -DSIZEOF_UNSIGNED_LONG_INT=4


################################################################################
# PDL crypto driver and mbed-crypto Cypress library
################################################################################
# Crypto defines
INCLUDE_DIRS_CRYPTOLIB := cryptolib cryptolib/crypto_driver/include cryptolib/mbedtls_target/ hal/bsp/
DEFINES_CRYPTO := -DCY_CRYPTO_USER_CONFIG_FILE="\"fb_crypto_config.h\"" -DMBEDTLS_CONFIG_FILE="\"mbedtls-config.h\""
INCLUDES_CRYPTOLIB = $(addprefix -I./, $(INCLUDE_DIRS_CRYPTOLIB))
SOURCES_CRYPTOLIB := $(wildcard ./cryptolib/crypto_driver/source/cy_crypto_core_*.c) $(wildcard ./cryptolib/mbedtls_target/*.c)  $(wildcard ./cryptolib/*.c)
#
ifeq ($(FAMILY), $(FAMILY_PSOC6A_BLE2))
	INCLUDES_CRYPTOLIB += -I"./cryptolib/mbedtls_target/TARGET_PSOC6_01/"
else
	INCLUDES_CRYPTOLIB += -I"./cryptolib/mbedtls_target/TARGET_PSOC6_02/"
endif

################################################################################
# mbed-crypto library
################################################################################
# MBED_CRYPTO_PATH = mbed-crypto-development
MBED_CRYPTO_PATH = mbedtls
################################################################################
INCLUDES_MBED_CRYPTO := -I"$(MBED_CRYPTO_PATH)/inc" -I"$(MBED_CRYPTO_PATH)/inc/mbedtls" -I"$(MBED_CRYPTO_PATH)/mbed-crypto/inc"
INCLUDES_MBED_CRYPTO += -I"$(MBED_CRYPTO_PATH)/mbed-crypto/platform/COMPONENT_PSA_SRV_IMPL/COMPONENT_NSPE"
SOURCES_MBED_CRYPTO  := $(wildcard ./$(MBED_CRYPTO_PATH)/mbed-crypto/src/*.c)
SOURCES_MBED_CRYPTO  += $(wildcard ./$(MBED_CRYPTO_PATH)/mbed-crypto/platform/COMPONENT_PSA_SRV_IMPL/*.c)
#