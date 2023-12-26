set(TARGET sparse)

set(TARGET_SRC_DIR "${LIB_DIR}/core/libsparse")

set(TARGET_CFLAGS 
    "-Werror"
)

if (CYGWIN)
    list(APPEND TARGET_CFLAGS 
        "-Doff64_t=_off64_t"
        "-Dftruncate64=ftruncate"
        "-Dlseek64=lseek"
        "-Wno-macro-redefined"
        "-static"
        )
endif ()

set(libcutils_srcs
    "${TARGET_SRC_DIR}/backed_block.cpp"
    "${TARGET_SRC_DIR}/output_file.cpp"
    "${TARGET_SRC_DIR}/sparse.cpp"
    "${TARGET_SRC_DIR}/sparse_crc32.cpp"
    "${TARGET_SRC_DIR}/sparse_err.cpp"
    "${TARGET_SRC_DIR}/sparse_read.cpp"
)

add_library(${TARGET} STATIC ${libcutils_srcs})

target_include_directories(${TARGET} PRIVATE
    ${libsparse_headers}
	${libbase_headers}
    ${libz_headers}
)

target_compile_options(${TARGET} PRIVATE
	"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
	"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)