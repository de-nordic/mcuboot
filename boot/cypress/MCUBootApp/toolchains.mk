################################################################################
# \file toolchains.mk
# \version 1.0
#
# \brief
# Makefile to describe supported toolchains for Cypress MCUBoot based applications.
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

# Compilers
GCC   := 1
IAR   := 2
ARM   := 3
OTHER := 4

# Set default compiler to GCC if not specified from command line
COMPILER ?= GCC

# Detect host OS to make resolving compiler pathes easier
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S), Darwin)
	HOST_OS = osx
else
	ifeq ($(UNAME_S), Linux)
		HOST_OS = linux
	else
		HOST_OS = win
	endif
endif

# Path to the compiler installation
# NOTE: Absolute pathes for now for the sake of development
ifeq ($(HOST_OS), win)
	ifeq ($(COMPILER), GCC)
		GCC_PATH := c:\Users\$(USERNAME)\ModusToolbox_1.0\tools\gcc-7.2.1-1.0
		# executables
		CC       := "$(GCC_PATH)/bin/arm-none-eabi-gcc"
		LD       := $(CC)

	else ifeq ($(COMPILER), IAR)
		IAR_PATH := C:\Program Files (x86)\IAR Systems\Embedded Workbench 8.0\arm
		# executables
		CC       := "$(IAR_PATH)/bin/iccarm.exe"
		AS       := "$(IAR_PATH)/bin/iasmarm.exe"
		LD       := "$(IAR_PATH)/bin/ilinkarm.exe"
	endif

else ifeq ($(HOST_OS), osx)
	GCC_PATH := /Users/rnok/toolchains/gcc-arm-none-eabi-6

	CC := "$(GCC_PATH)/bin/arm-none-eabi-gcc"
	LD := $(CC)

else ifreq ($(HOST_OS), linux)
#	GCC_PATH := /usr/bin/gcc-arm-none-eabi/bin/arm-none-eabi-gcc
	# executables
	CC := "$(GCC_PATH)/bin/arm-none-eabi-gcc"
	LD := $(CC) 
endif

PDL_ELFTOOL := "hal/tools/$(HOST_OS)/elf/cymcuelftool"

# Set executable names for compilers
ifeq ($(COMPILER), GCC)
	CC       := "$(GCC_PATH)/bin/arm-none-eabi-gcc"
	LD       := $(CC)
else
	CC       := "$(IAR_PATH)/bin/iccarm.exe"
	AS       := "$(IAR_PATH)/bin/iasmarm.exe"
	LD       := "$(IAR_PATH)/bin/ilinkarm.exe"
endif

OBJDUMP  := "$(GCC_PATH)/bin/arm-none-eabi-objdump"
OBJCOPY  := "$(GCC_PATH)/bin/arm-none-eabi-objcopy"

# Set flags for toolchain executables

ifeq ($(COMPILER), GCC)
	# set build-in compiler flags
	CFLAGS_COMMON := -mcpu=cortex-m0plus -mthumb -Os -mfloat-abi=soft -fno-stack-protector -ffunction-sections -fdata-sections -ffat-lto-objects -fstrict-aliasing -g -Wall -Wextra
# 	CFLAGS_COMMON := -mcpu=cortex-m0plus -mthumb -Og -mfloat-abi=soft -fno-stack-protector -ffunction-sections -fdata-sections -ffat-lto-objects -fstrict-aliasing -g -Wall -Wextra
	# add defines and includes
	CFLAGS := $(CFLAGS_COMMON) $(DEFINES) $(INCLUDES)
	CC_DEPEND = -MD -MP -MF

	LINKER_SCRIPT := $(CHIP_SERIES).ld
#	LINKER_SCRIPT_CM4 := psoc6a_cm4.ld
#	LINKER_SCRIPT_TEMPL := psoc6a_policy_templ.ld

	LDFLAGS_COMMON := -mcpu=cortex-m0plus -mthumb -Os -specs=nano.specs -ffunction-sections -fdata-sections  -Wl,--gc-sections -L "$(GCC_PATH)/lib/gcc/arm-none-eabi/7.2.1/thumb/v6-m" -fwhole-program
# 	LDFLAGS_COMMON := -mcpu=cortex-m0plus -mthumb -Og -specs=nano.specs -ffunction-sections -fdata-sections  -Wl,--gc-sections -L "$(GCC_PATH)/lib/gcc/arm-none-eabi/7.2.1/thumb/v6-m" -fwhole-program
	LDFLAGS_NANO := -L "$(GCC_PATH)/arm-none-eabi/lib/thumb/v6-m"
	LDFLAGS := $(LDFLAGS_COMMON) $(LDFLAGS_NANO) -T ./$(LINKER_SCRIPT) -Wl,-Map,$(OUT)/flashboot_$(SUFFIX_FAMILY).map
#	LDFLAGS_CM4 := $(LDFLAGS_COMMON) -T ./$(LINKER_SCRIPT_CM4) -Wl,-Map,$(OUT)/flashboot_$(SUFFIX_FAMILY)_cm4.map
#	LDFLAGS_TEMPL := $(LDFLAGS_COMMON) -T ./$(LINKER_SCRIPT_TEMPL) -Wl,-Map,$(OUT)/flashboot_$(SUFFIX_FAMILY)_policy_templ.map

else ifeq($(COMPILER), IAR)

	CFLAGS := --debug --endian=little --cpu=Cortex-M0+ -e --fpu=None --dlib_config "$(IAR_PATH)\INC\c\DLib_Config_Normal.h"
	CFLAGS += -Ohz --silent
	CFLAGS += $(DEFINES) $(INCLUDES)
	CC_DEPEND = --dependencies

	AS_FLAGS := -s+ "-M<>" -w+ -r --cpu Cortex-M0+ --fpu None -S

	LINKER_SCRIPT := $(CHIP_SERIES).icf
	#LINKER_SCRIPT_CM4 := psoc6a_cm4.icf
	#LINKER_SCRIPT_TEMPL := $(CHIP_SERIES)_policy_templ.icf

	#options to extend stack analize: --log call_graph --log_file $(OUT)/stack_usage_$(SUFFIX).txt
	LDFLAGS_STACK_USAGE := --stack_usage_control $(STACK_CONTROL_FILE) --diag_suppress=Ls015 --diag_suppress=Ls016
	LDFLAGS_COMMON := --vfe --text_out locale --silent --inline --merge_duplicate_sections
	LDFLAGS := $(LDFLAGS_COMMON) $(LDFLAGS_STACK_USAGE) --config $(LINKER_SCRIPT) --map $(OUT)/flashboot_$(SUFFIX_FAMILY).map --entry Cy_FB_ResetHandler --no_exceptions
	#LDFLAGS_CM4 := $(LDFLAGS_COMMON) --no_entry --config $(LINKER_SCRIPT_CM4) --map $(OUT)/flashboot_$(SUFFIX_FAMILY)_cm4.map --no_exceptions
	#LDFLAGS_TEMPL := $(LDFLAGS_COMMON) --no_entry --config $(LINKER_SCRIPT_TEMPL) --map $(OUT)/flashboot_$(SUFFIX_FAMILY)_policy_templ.map --no_exceptions

endif

