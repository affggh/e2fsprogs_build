set(TARGET cutils)

set(TARGET_SRC_DIR "${LIB_DIR}/core/libcutils")

set(TARGET_CFLAGS 
    "-Wall"
    "-Werror"
    "-Wextra"
    "-Wno-exit-time-destructors"
)

if (CYGWIN)
    list(APPEND TARGET_CFLAGS "-static" "-stdlib=libc++")
endif ()

set(libcutils_srcs
    "${TARGET_SRC_DIR}/config_utils.cpp"
    "${TARGET_SRC_DIR}/iosched_policy.cpp"
    "${TARGET_SRC_DIR}/load_file.cpp"
    "${TARGET_SRC_DIR}/native_handle.cpp"
    "${TARGET_SRC_DIR}/properties.cpp"
    "${TARGET_SRC_DIR}/record_stream.cpp"
    "${TARGET_SRC_DIR}/strlcpy.c"
)

if (WIN32)
    list(APPEND libcutils_srcs
        "${TARGET_SRC_DIR}/trace-host.cpp"
    )
    target_link_options(${TARGET} "-lws2_32")
else ()
    list(APPEND libcutils_srcs
        "${TARGET_SRC_DIR}/canned_fs_config.cpp"
        "${TARGET_SRC_DIR}/fs_config.cpp"
    )
endif ()

add_library(${TARGET} STATIC ${libcutils_srcs})

target_include_directories(${TARGET} PRIVATE
	${libbase_headers}
	${liblog_headers}
    ${libcutils_headers}
)

target_compile_options(${TARGET} PRIVATE
	"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
	"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)