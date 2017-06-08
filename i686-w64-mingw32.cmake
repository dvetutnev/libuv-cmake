# The name of the target operating system
SET(CMAKE_SYSTEM_NAME Windows)
# The name of the target architecture
SET(CMAKE_SYSTEM_PROCESSOR "i686")

# Choose an appropriate compiler prefix
SET(MINGW_TOOLCHAIN "i686-w64-mingw32")

# Which compilers to use for C and C++
FIND_PROGRAM(CMAKE_RC_COMPILER NAMES ${MINGW_TOOLCHAIN}-windres)
FIND_PROGRAM(CMAKE_C_COMPILER NAMES ${MINGW_TOOLCHAIN}-gcc)
FIND_PROGRAM(CMAKE_CXX_COMPILER NAMES ${MINGW_TOOLCHAIN}-g++)

# Here is the target environment located
SET(CMAKE_FIND_ROOT_PATH /usr/${MINGW_TOOLCHAIN})

# Adjust the default behaviour of the FIND_XXX() commands:
# search headers and libraries in the target environment, search
# programs in the host environment
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
