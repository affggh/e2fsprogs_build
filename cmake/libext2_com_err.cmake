set(TARGET ext2_com_err)

set(TARGET_SRC_DIR "${LIB_DIR}/e2fsprogs/lib/et")

include(e2fsprogs_defaults.cmake)

set(TARGET_CFLAGS
	${E2FSPROGS_DEFAULT_CFLAGS}
)

set(libext2_com_err_srcs
    "${TARGET_SRC_DIR}/error_message.c"
    "${TARGET_SRC_DIR}/et_name.c"
    "${TARGET_SRC_DIR}/init_et.c"
    "${TARGET_SRC_DIR}/com_err.c"
    "${TARGET_SRC_DIR}/com_right.c"
)

add_library(${TARGET} STATIC ${libext2_com_err_srcs})

target_include_directories(${TARGET} PRIVATE
    ${E2FSPROGS_DEFAULT_INCLUDES}
    ${TARGET_SRC_DIR}
)

target_compile_options(${TARGET} PRIVATE
	"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
	"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)