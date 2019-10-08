# Downloading Solution's Assets

There are three assets required:

* MCUBooot Library (root repository)
* PSoC6 BSP Library
* PSoC6 Peripheral Drivers Library (PDL)
* mbedTLS cryptographic Library

Those are present as submodules.

To retrive working environment, root repo has to be cloned recursively:

__git clone --recursive https://github.com/JuulLabs-OSS/mcuboot.git__

Then submodules have to be updated:

git submodule update --init


# Building Solution

Appplication name "MCUBootApp"

Board/device target "CY8CPROTO-062-4343W-M0" (CM0p core)

Build config - optimised for "Debug"

__make TARGET=CY8CPROTO-062-4343W-M0 APP=MCUBootApp BUILDCFG=Debug__