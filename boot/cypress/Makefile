################################################################################
# \file Makefile
# \version 1.0
#
# \brief
# Main Makefile for building MCUBoot application for Cypress target.
#
################################################################################
# \copyright
# Copyright 2019 Cypress Semiconductor Corporation
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
# Main settings
################################################################################

# default TARGET
APP_NAME ?= MCUBootApp
#
APPS := MCUBootApp

ifneq ($(filter $(APP_NAME), $(APPS)),)
include ./$(APP_NAME)/$(APP_NAME).mk
else
$(error Not supported application: '$(APP_NAME)')
endif

ASM_FILES := $(ASM_FILES_PDL)

C_FILES := $(SOURCES_APP)
C_FILES += $(SOURCES_LIBS)

INCLUDE_DIRS := $(INCLUDE_DIRS_APP)
INCLUDE_DIRS += $(INCLUDE_DIRS_LIBS)

INCLUDES := $(INCLUDES_APP)
INCLUDES += $(INCLUDES_LIBS)

DEFINES := $(DEFINES_BSP)
DEFINES += $(DEFINES_APP)
DEFINES += -DCUSTOM_DEF

#$(info ==============================================================================)
#$(info = Collected Defines string: =)
#$(info ==============================================================================)
#$(info $(DEFINES))
#DEFINES +=

#DEFINES := -D$(CHIP_ID) -DCY_FB_OPT_$(SI_REVISION) -DNDEBUG -DCY_CORE_ID=0 $(DEFINES_CRYPTO) $(DEFINES_PDL) $(DEFINES_OTHER) -DCY_FB_BUILD_NUMBER=$(CY_BUILD_NUMBER)UL $(PSVP_DEFINES) $(DEFINES_JWT)

## helper suffix for versioning support
#SUFFIX := $(SUFFIX_FAMILY)_$(SUFFIX_VERSION)
OUT := ./$(APP_NAME)/out
#
#ifeq ($(CY_BUILD_NUMBER), )
#	# may be useful when building from a command line on a local machine
#	CY_BUILD_NUMBER := 10
#endif
#
#################################################################################
## Application sources
#################################################################################
#SOURCES_APPLICATION = 
#
#################################################################################
## Common section
#################################################################################
#
## Project includes path define
#INCLUDES := $(INCLUDES_JWT) $(INCLUDES_CRYPTOLIB) $(INCLUDES_PDL) $(INCLUDES_MBED_CRYPTO) -I"./hal"  -I"./crypto" -I.
#
## Other defines
#DEFINES_OTHER := -DFB_SECURE_ENABLED -DCY_FLASH_RWW_DRV_SUPPORT_DISABLED
#ifneq ($(FAMILY), $(FAMILY_PSOC6A_512K))
#	DEFINES_OTHER := $(DEFINES_OTHER) -DCY_FB_ATTESTATON_ENABLE
#endif
#
#ifneq (, $(findstring _psvp_, $(SUFFIX)))
#	PSVP_DEFINES := -DCY_FB_OPT_PSVP
#endif
#
#DEFINES := -D$(CHIP_ID) -DCY_FB_OPT_$(SI_REVISION) -DNDEBUG -DCY_CORE_ID=0 $(DEFINES_CRYPTO) $(DEFINES_PDL) $(DEFINES_OTHER) -DCY_FB_BUILD_NUMBER=$(CY_BUILD_NUMBER)UL $(PSVP_DEFINES) $(DEFINES_JWT)
#
#DEFINES += -DCY_FB_FAMILY=$(FAMILY) -DCY_FB_SI_REV=$(SI_REV)
#
#
#ASM_FILES += $(ASM_FILES_PDL)
#C_FILES := $(SOURCES_CRYPTOLIB) $(SOURCES_MBED_CRYPTO) $(SOURCES_JWT) $(SOURCES_BSP) $(SOURCES_PDL) $(SOURCES_FB)
#C_FILES += $(wildcard hal/*.c)
O_FILES := $(notdir $(C_FILES:.c=.o)) $(addsuffix .o, $(notdir $(basename $(ASM_FILES))))

VPATH = $(dir $(C_FILES) $(ASM_FILES))

## Set colors for unix compatible terminals, otherwise comment this code
#ifeq ($(JENKINS), yes)
#	COLOR_RESET    = \033[0m
#	COLOR_make_std = \033[3$1m      # defined for 1 through 7
#	COLOR_make     = \033[38;5;$1m  # defined for 1 through 255
#	COLOR_WRN = $(strip $(call COLOR_make,11))
#	COLOR_ERR = $(strip $(call COLOR_make,9))
#	COLOR_STD = $(strip $(call COLOR_make,243))
#
#	COLOR_OUTPUT = 2>&1 |                                         \
#		while IFS='' read -r line; do                             \
#			if  [[ $$line == *Error\[* ]]; then                   \
#				echo -e -n "$(COLOR_ERR)";                        \
#				echo -n $${line};                                 \
#				echo -e "$(COLOR_RESET)";                         \
#			elif [[ $$line == *Warning\[* ]]; then                \
#				echo -e -n "$(COLOR_WRN)";                        \
#				echo -n $${line};                                 \
#				echo -e "$(COLOR_RESET)";                         \
#			else                                                  \
#				echo -e -n "$(COLOR_STD)";                        \
#				echo -n $${line};                                 \
#				echo -e "$(COLOR_RESET)";                         \
#			fi;                                                   \
#		done; exit $${PIPESTATUS[0]};
#else
#	COLOR_RESET    =
#	COLOR_make_std =
#	COLOR_make     =
#	COLOR_WRN =
#	COLOR_ERR =
#	COLOR_STD =
#
#	COLOR_OUTPUT =
#endif
#
#
##.PHONY: all clean app build postbuild
.PHONY: all clean app build

all: clean app

app:
	@`mkdir -p $(OUT)`
	@`mkdir -p $(OUT)/obj`
	@`mkdir -p $(OUT)/obj/$@`
	$(MAKE) build -j4

#all: target_psoc6_ble2 target_psoc6_2m target_psoc6_2m_psvp
#
#build_info:
#	@echo "*** Asm sources (ASM_FILES):"
#	@echo $(ASM_FILES)
#	@echo "*** C sources (C_FILES):"
#	@echo $(C_FILES)
#	@echo "*** Object files (O_FILES):"
#	@echo $(O_FILES)
#
#check_pdl:
#	echo "Remove obsolete crypto driver files from PDL directory"
#	@rm -rf $(PDL_PATH)/drivers/include/cy_crypto*.h
#	@rm -rf $(PDL_PATH)/drivers/source/cy_crypto*.c
#
#target_psoc6_ble2:
#	#Build for PSOC6ble2 $(SI_REVISION)
#	@`mkdir -p ./out`
#	@`mkdir -p ./out/obj`
#	@`mkdir -p ./out/obj/$@`
#	$(MAKE) build FAMILY:=$(FAMILY_PSOC6A_BLE2) TARGET=$@ SI_REVISION:=0D SUFFIX_FAMILY:=psoc62_0D SUFFIX_VERSION:=4.0.0.$(CY_BUILD_NUMBER) -j4
#
#
#
## Build target
build: 

#	$(OUT)/$(APP_NAME)_CM0p.hex
#	$(GCC_PATH)/bin/arm-none-eabi-size -B -d $(OUT)/$(APP_NAME)_CM0p.elf
#build:

#$(OUT)/$(APP_NAME)_CM0p.hex: $(OUT)/$(APP_NAME)_CM0p_link.elf $(OUT)/fb_$(SUFFIX_FAMILY)_cm4_link.elf $(OUT)/fb_$(SUFFIX_FAMILY)_policy_templ1.elf $(OUT)/fb_$(SUFFIX_FAMILY)_policy_templ2.elf
#	$(PDL_ELFTOOL) --sign $(OUT)/fb_$(SUFFIX_FAMILY)_cm4_link.elf --output $(OUT)/fb_$(SUFFIX_FAMILY)_cm4_link.elf
#	$(PDL_ELFTOOL) --sign $(OUT)/$(APP_NAME)_CM0p_link.elf --output $(OUT)/$(APP_NAME)_CM0p_link.elf
#	$(PDL_ELFTOOL) --merge $(OUT)/$(APP_NAME)_CM0p_link.elf $(OUT)/fb_$(SUFFIX_FAMILY)_cm4_link.elf --output $(OUT)/$(APP_NAME)_CM0p.elf
#	$(PDL_ELFTOOL) --merge $(OUT)/$(APP_NAME)_CM0p.elf $(OUT)/fb_$(SUFFIX_FAMILY)_policy_templ1.elf --output $(OUT)/$(APP_NAME)_CM0p_link.elf --hex $(OUT)/$(APP_NAME)_CM0p.hex
#	$(PDL_ELFTOOL) --merge $(OUT)/$(APP_NAME)_CM0p.elf $(OUT)/fb_$(SUFFIX_FAMILY)_policy_templ2.elf --output $(OUT)/$(APP_NAME)_CM0p2_link.elf --hex $(OUT)/$(APP_NAME)_CM0p_cm0open.hex
#	$(OBJDUMP) -h -S $(OUT)/$(APP_NAME)_CM0p_link.elf > $(OUT)/$(APP_NAME)_CM0p.asm
#
$(OUT)/$(APP_NAME)_CM0p.elf: $(addprefix $(OUT)/obj/, $(O_FILES))
	@# the first  line prints a command
	@# the second line executes the command and prints the command's stdout and stderr with colors
	@echo $(LD) $(O_FILES) -o $@ $(LDFLAGS)
	@$(LD) $(addprefix $(OUT)/obj/, $(O_FILES)) -o $@ $(LDFLAGS)
#
#$(OUT)/fb_$(SUFFIX_FAMILY)_cm4_link.elf : fb_cm4.c
#	$(CC) $(CFLAGS)  -c fb_cm4.c -o $(OUT)/obj/$(TARGET)/fb_cm4.o
#	$(LD) $(OUT)/obj/$(TARGET)/fb_cm4.o -o $@ $(LDFLAGS_CM4) $(COLOR_OUTPUT)
#	$(OBJDUMP) -h -S $(OUT)/fb_$(SUFFIX_FAMILY)_cm4_link.elf > $(OUT)/fb_$(SUFFIX_FAMILY)_cm4.asm
#
#$(OUT)/fb_$(SUFFIX_FAMILY)_policy_templ1.elf : fb_policy_templ1.c
#	$(CC) $(CFLAGS)  -c fb_policy_templ1.c -o $(OUT)/obj/$(TARGET)/fb_policy_templ1.o
#	$(LD) $(OUT)/obj/$(TARGET)/fb_policy_templ1.o -o $@ $(LDFLAGS_TEMPL) $(COLOR_OUTPUT)
#	$(OBJDUMP) -h -S $(OUT)/fb_$(SUFFIX_FAMILY)_policy_templ1.elf > $(OUT)/fb_$(SUFFIX_FAMILY)_policy_templ1.asm
#
#$(OUT)/fb_$(SUFFIX_FAMILY)_policy_templ2.elf : fb_policy_templ2.c
#	$(CC) $(CFLAGS)  -c fb_policy_templ2.c -o $(OUT)/obj/$(TARGET)/fb_policy_templ2.o
#	$(LD) $(OUT)/obj/$(TARGET)/fb_policy_templ2.o -o $@ $(LDFLAGS_TEMPL) $(COLOR_OUTPUT)
#	$(OBJDUMP) -h -S $(OUT)/fb_$(SUFFIX_FAMILY)_policy_templ2.elf > $(OUT)/fb_$(SUFFIX_FAMILY)_policy_templ2.asm
#

#$(OUT)/$(APP_NAME)_CM0p.elf : ./$(APP_NAME)/main.c
#	$(CC) $(CFLAGS)  -c main.c -o $(OUT)/obj/main.o
#	$(LD) $(OUT)/obj/main.o -o $@ $(LDFLAGS_TEMPL) $(COLOR_OUTPUT)
##	$(OBJDUMP) -h -S $(OUT)/$(APP_NAME)_CM0p.elf > $(OUT)/fb_$(SUFFIX_FAMILY)_policy_templ2.asm

$(OUT)/obj/%.o: %.c
	@echo $(CC) $(CFLAGS) $(CC_DEPEND) $(@:.o=.d) -c $< -o $@
	@$(CC) $(CFLAGS) $(CC_DEPEND) $(@:.o=.d) -c $< -o $@ $(COLOR_OUTPUT)
	@echo

$(OUT)/obj/%.o: %.s
ifeq ($(COMPILER), GCC)
	@echo @$(CC) $(CFLAGS) -c $< -o $@
	@$(CC) $(CFLAGS) -c $< -o $@ $(COLOR_OUTPUT)
else
	@echo $(AS) $< -o $@ $(AS_FLAGS)
	@$(AS) $< -o $@ $(AS_FLAGS) $(COLOR_OUTPUT)
endif
	@echo

clean:
	rm -rf ./$(APP_NAME)/out

# DEBUG PRINT
#$(info $(ASM_FILES))

#$(info $(C_FILES))
#
#$(info $(INCLUDES))
#
#$(info $(INCLUDE_DIRS))
#
#$(info $(DEFINES))
#
#$(info $(CC))

#$(info $(O_FILES))