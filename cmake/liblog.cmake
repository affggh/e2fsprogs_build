set(TARGET log)

set(TARGET_SRC_DIR "${LIB_DIR}/logging/liblog")

set(TARGET_CFLAGS 
    "-Wall"
    "-Werror"
    "-Wextra"
    "-Wexit-time-destructors"
    "-DLIBLOG_LOG_TAG=1006"
    "-DSNET_EVENT_LOG_TAG=1397638484"
    "-DANDROID_DEBUGGABLE=0"
)

list(APPEND TARGET_CFLAGS "-Wno-c99-designator")

if (CYGWIN)
    list(APPEND TARGET_CFLAGS "-D_Bool=bool"
        "-static"
    )
endif ()

set(liblog_srcs
    "${TARGET_SRC_DIR}/log_event_list.cpp"
    "${TARGET_SRC_DIR}/log_event_write.cpp"
    "${TARGET_SRC_DIR}/logger_name.cpp"
    "${TARGET_SRC_DIR}/logger_read.cpp"
    "${TARGET_SRC_DIR}/logger_write.cpp"
    "${TARGET_SRC_DIR}/logprint.cpp"
    "${TARGET_SRC_DIR}/properties.cpp"
)

add_library(${TARGET} STATIC ${liblog_srcs})

target_include_directories(${TARGET} PRIVATE
	${libbase_headers}
	${liblog_headers}
    ${libcutils_headers}
)

target_compile_options(${TARGET} PRIVATE
	"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
	"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)