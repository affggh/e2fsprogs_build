cmake_minimum_required(VERSION 3.20)

project(e2fsprogs LANGUAGES C CXX)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_definitions(
    "-D_FILE_OFFSET_BITS=64"
    "-D_LARGEFILE_SOURCE"
    "-D_LARGEFILE64_SOURCE"
)

# Compile flags
set(GLOBAL_CFLAGS
	"-Wformat"
	"-Werror=format-security"
	"-no-canonical-prefixes"
	"-fdata-sections"
	"-ffunction-sections"
	"-fvisibility=hidden"
	"-fvisibility-inlines-hidden"
	"-funwind-tables"
	"-fstack-protector-strong"
	"-fno-exceptions"
	"-fno-rtti"
)

if (CYGWIN)
    list(APPEND GLOBAL_CFLAGS
        "-Wno-unknown-warning-option"
        )
endif()

set(GLOBAL_CFLAGS_RELEASE
	"-Os"
	"-D_FORTIFY_SOURCE=2"
)

# Linker flags
set(GLOBAL_LDFLAGS
	"-fstack-protector-strong"
	"-Qunused-arguments"
)
set(GLOBAL_LDFLAGS_RELEASE)

if (CMAKE_SYSTEM_NAME MATCHES "Darwin")
	list(APPEND GLOBAL_LDFLAGS "-Wl,-dead_strip,-S,-x")
elseif (CMAKE_SYSTEM_NAME MATCHES "Linux|Android")
	list(APPEND GLOBAL_CFLAGS "-fno-semantic-interposition")
	list(APPEND GLOBAL_LDFLAGS "-Wl,--no-undefined" "-static")
	list(APPEND GLOBAL_LDFLAGS_RELEASE "-Wl,-s,-x,--gc-sections")
	if (CMAKE_SYSTEM_NAME MATCHES "Android")
		list(APPEND GLOBAL_CFLAGS "-DANDROID" "-mllvm" "-polly")
	endif ()
elseif (CMAKE_SYSTEM_NAME MATCHES "CYGWIN")
	list(APPEND GLOBAL_CFLAGS "-static" "-stdlib=libc++")
	list(APPEND GLOBAL_LDFLAGS_RELEASE "-Wl,-s,-x,--gc-sections")
endif ()

if (CMAKE_BUILD_TYPE STREQUAL "Release")
	list(APPEND GLOBAL_CFLAGS ${GLOBAL_CFLAGS_RELEASE})
	list(APPEND GLOBAL_LDFLAGS ${GLOBAL_LDFLAGS_RELEASE})
	if (ENABLE_FULL_LTO)
		list(APPEND GLOBAL_CFLAGS "-flto=full")
		if (CMAKE_SYSTEM_NAME MATCHES "Android")
			# https://github.com/android/ndk/issues/1461
			list(APPEND GLOBAL_LDFLAGS "-T${CMAKE_CURRENT_SOURCE_DIR}/lto_fix.lds")
		endif ()
		if (NOT CMAKE_SYSTEM_NAME MATCHES "Darwin|CYGWIN")
			# Cygwin lld is not work. cause have no __begin_base__ and __bss_base__ and exit also
			list(APPEND GLOBAL_LDFLAGS "-fuse-ld=lld")
			list(APPEND GLOBAL_LDFLAGS_RELEASE "-Wl,-icf=safe,--lto-O3")
		endif ()
	endif ()
	add_definitions("-DNDEBUG")
elseif (CMAKE_BUILD_TYPE STREQUAL "Debug")
	list(APPEND GLOBAL_CFLAGS "-O0" "-g")
endif ()

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
	list(APPEND GLOBAL_CFLAGS "-fdiagnostics-color=always")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
	list(APPEND GLOBAL_CFLAGS "-fcolor-diagnostics")
endif ()

add_compile_options("$<$<COMPILE_LANGUAGE:C>:${GLOBAL_CFLAGS}>" "$<$<COMPILE_LANGUAGE:CXX>:${GLOBAL_CFLAGS}>")
add_link_options("$<$<LINK_LANGUAGE:C>:${GLOBAL_LDFLAGS}>" "$<$<LINK_LANGUAGE:CXX>:${GLOBAL_LDFLAGS}>")

set(LIB_DIR "${PROJECT_SOURCE_DIR}/src")

if (CYGWIN)
    # Cygwin spec patch
    execute_process(COMMAND "./cygwin_apply_patch.sh" "${LIB_DIR}")
endif ()

add_subdirectory(cmake)