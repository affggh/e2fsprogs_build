cmake_minimum_required(VERSION 3.20)

project(e2fsprogs LANGUAGES C CXX)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 20)

set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_definitions(
    "-D_FILE_OFFSET_BITS=64"
    "-D_LARGEFILE_SOURCE"
    "-D_LARGEFILE64_SOURCE"
)

set(GLOBAL_CFLAGS
    "-Wformat"
    "-Wall"
    "-Wextra"
)

set(GLOBAL_LDFLAGS_RELEASE)

if (CYGWIN)
    list(APPEND GLOBAL_CFLAGS
    )
    list(APPEND GLOBAL_LDFLAGS_RELEASE "-static")
else ()
    list(APPEND GLOBAL_LDFLAGS_RELEASE "-Wl,-s,-x,--gc-sections" "-static")
endif ()

set(LIB_DIR "${PROJECT_SOURCE_DIR}/src")

add_subdirectory(cmake)