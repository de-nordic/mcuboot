################################################################################
# \file libs.mk
# \version 1.0
#
# \brief
# Makefile to describe libraries needed for Cypress MCUBoot based applications.
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

################################################################################
# PDL library
################################################################################
PDL_VERSION = 121
#
CUR_LIBS_PATH = $(CURDIR)/libs

SOURCES_PDL := $(wildcard $(CUR_LIBS_PATH)/pdl/psoc6pdl/drivers/source/*.c)
SOURCES_PDL += $(CUR_LIBS_PATH)/pdl/psoc6pdl/devices/bsp/COMPONENT_MTB/startup/system_psoc6_cm0plus.c
SOURCES_MBEDTLS := $(wildcard $(CUR_LIBS_PATH)/mbedtls/crypto/library/*.c)

INCLUDE_DIRS_PDL := $(CUR_LIBS_PATH)/pdl/psoc6pdl/drivers/include
INCLUDE_DIRS_MBEDTLS := $(CUR_LIBS_PATH)/mbedtls/crypto/include/mbedtls

#INCLUDES_PDL := $(wildcard $(CUR_LIBS_PATH)/pdl/psoc6pdl/drivers/include/*.h)
#INCLUDES_MBEDTLS := $(wildcard $(CUR_LIBS_PATH)/mbedtls/crypto/include/mbedtls/*.h) 
 
SOURCES_LIBS := $(SOURCES_PDL)
SOURCES_LIBS += $(SOURCES_BSP)
SOURCES_LIBS += $(SOURCES_MBEDTLS)

INCLUDE_DIRS_LIBS := $(addprefix -I,$(INCLUDE_DIRS_PDL))
INCLUDE_DIRS_LIBS += $(addprefix -I,$(INCLUDE_DIRS_BSP))
INCLUDE_DIRS_LIBS += $(addprefix -I,$(INCLUDE_DIRS_MBEDTLS))

#INCLUDE_DIRS_PDL  = cmsis/include devices/include devices/include/ip drivers/include # devices/bsp/COMPONENT_MTB/startup

#ifeq ($(COMPILER), GCC)
#	ASM_FILES_PDL += $(PDL_PATH)/drivers/source/TOOLCHAIN_GCC_ARM/cy_syslib_gcc.S
#else
#	ASM_FILES_PDL += $(PDL_PATH)/drivers/source/TOOLCHAIN_IAR/cy_syslib_iar.s
#endif

################################################################################
#
### In case of PDL ABSOLUTE PATH, PDL_DRIVE variable should be set separately
# PDL_DRIVE = /c
# PDL_PATH = /c/cy-work/git/crypto/fws-532/psoc6pdl
################################################################################
# SOURCES_PDL_ALLDRV  = $(wildcard $(PDL_PATH)/drivers/source/*.c)
# SOURCES_PDL_CRYPTO  = $(wildcard $(PDL_PATH)/drivers/source/cy_crypto*.c)
# SOURCES_PDL_DRIVERS = $(filter-out $(SOURCES_PDL_CRYPTO), $(SOURCES_PDL_ALLDRV))

#SOURCE_FILES_PDL  = $(wildcard $(PDL_PATH)/drivers/source/*.c)


##INCLUDES_PDL = $(addprefix -I$(PDL_DRIVE)$(PDL_PATH)/, $(INCLUDE_DIRS_PDL))
#INCLUDES_PDL = $(addprefix -I$(PDL_PATH)/, $(INCLUDE_DIRS_PDL))
#SOURCES_PDL  = $(SOURCE_FILES_PDL)
DEFINES_PDL += -DPDL_VERSION=$(PDL_VERSION)
#################################################################################
#
