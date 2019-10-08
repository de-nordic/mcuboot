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

CUR_APP_PATH = $(CURDIR)/$(APP)

include $(CUR_APP_PATH)/targets.mk
include $(CUR_APP_PATH)/libs.mk
include $(CUR_APP_PATH)/toolchains.mk

# TODO: add DEFINES in Application

# TODO: MCUBoot library
SOURCES_MCUBOOT := $(wildcard $(CURDIR)/../bootutil/src/*.c)
INCLUDES_MCUBOOT := $(wildcard $(CURDIR)/../bootutil/include/bootutil/*.h)

SOURCES_APP := $(wildcard $(CUR_APP_PATH)/*.c)
SOURCES_APP += $(SOURCES_MCUBOOT)

INCLUDES_APP := $(wildcard $(CUR_APP_PATH)/*.h)
INCLUDES_APP += $(wildcard $(CUR_APP_PATH)/config/*.h)
INCLUDES_APP += $(INCLUDES_MCUBOOT)
