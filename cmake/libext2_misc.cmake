set(TARGET ext2_misc)

set(TARGET_SRC_DIR "${LIB_DIR}/e2fsprogs/misc")

include(e2fsprogs_defaults.cmake)

set(TARGET_CFLAGS
	${E2FSPROGS_DEFAULT_CFLAGS}
)

set(libext2_misc_srcs
    "${TARGET_SRC_DIR}/create_inode.c"
)

add_library(${TARGET} STATIC ${libext2_misc_srcs})

target_include_directories(${TARGET} PRIVATE
    ${E2FSPROGS_DEFAULT_INCLUDES}
    ${TARGET_SRC_DIR}
)

target_compile_options(${TARGET} PRIVATE
	"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
	"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)