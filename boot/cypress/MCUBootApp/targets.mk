################################################################################
# \file targets.mk
# \version 1.0
#
# \brief
# Makefile to describe supported boards and platforms for Cypress MCUBoot based applications.
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

# Target board MCUBoot is built for. CY8CPROTO-062-4343W is set as default
# Supported:
#   - CY8CPROTO-062-4343W
#	- CY8CKIT_062_WIFI_BT
#	- more to come
CY8CPROTO-062-4343W := 0x1901
# TODO: CY8CKIT_062_WIFI_BT := 0x1900

# default TARGET
TARGET ?= CY8CPROTO-062-4343W-M0
#
TARGETS := CY8CPROTO-062-4343W-M0 CY8CKIT-062-WIFI-BT-M0

ifneq ($(filter $(TARGET), $(TARGETS)),)
include ./libs/bsp/TARGET_$(TARGET)/$(TARGET).mk
else
$(error Not supported target: '$(TARGET)')
endif

# TODO: include appropriate BSP sources
# TODO: include appropriate BSP headers
# TODO: include appropriate BSP assembly
# TODO: include appropriate BSP linker(s)
# TODO: include appropriate BSP precompiled

