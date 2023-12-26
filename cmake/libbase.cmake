set(TARGET base)

set(TARGET_SRC_DIR "${LIB_DIR}/libbase")

set(TARGET_CFLAGS 
    "-Wall"
    "-Werror"
    "-Wextra"
    "-Wno-c99-designator"
)

list(APPEND TARGET_CFLAGS "-Wexit-time-destructors")

set(libbase_srcs
    "${TARGET_SRC_DIR}/abi_compatibility.cpp"
    "${TARGET_SRC_DIR}/chrono_utils.cpp"
    "${TARGET_SRC_DIR}/cmsg.cpp"
    "${TARGET_SRC_DIR}/file.cpp"
    "${TARGET_SRC_DIR}/hex.cpp"
    "${TARGET_SRC_DIR}/logging.cpp"
    "${TARGET_SRC_DIR}/mapped_file.cpp"
    "${TARGET_SRC_DIR}/parsebool.cpp"
    "${TARGET_SRC_DIR}/parsenetaddress.cpp"
    "${TARGET_SRC_DIR}/posix_strerror_r.cpp"
    "${TARGET_SRC_DIR}/process.cpp"
    "${TARGET_SRC_DIR}/properties.cpp"
    "${TARGET_SRC_DIR}/stringprintf.cpp"
    "${TARGET_SRC_DIR}/strings.cpp"
    "${TARGET_SRC_DIR}/threads.cpp"
    "${TARGET_SRC_DIR}/test_utils.cpp"
)

if (WIN32)
    list(APPEND libbase_srcs 
    "${TARGET_SRC_DIR}/errors_windows.cpp"
    "${TARGET_SRC_DIR}/utf8.cpp"
    )
else ()
    list(APPEND libbase_srcs "${TARGET_SRC_DIR}/errors_unix.cpp")
endif ()

if (WIN32 OR CYGWIN)
    list(REMOVE_ITEM libbase_srcs "${TARGET_SRC_DIR}/cmsg.cpp")
    list(APPEND TARGET_CFLAGS "-D_POSIX_THREAD_SAFE_FUNCTIONS"
        "-static"    
    )
endif ()

if (CYGWIN)
    list(APPEND TARGET_CFLAGS "-Doff64_t=off_t")
endif ()

add_library(${TARGET} STATIC ${libbase_srcs})

target_include_directories(${TARGET} PRIVATE
	${libbase_headers}
	${liblog_headers}
)

target_compile_options(${TARGET} PRIVATE
	"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
	"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)