set(TARGET ext2_blkid)

set(TARGET_SRC_DIR "${LIB_DIR}/e2fsprogs/lib/blkid")

include(e2fsprogs_defaults.cmake)

set(TARGET_CFLAGS
	${E2FSPROGS_DEFAULT_CFLAGS}
)

set(libext2_blkid_srcs
    "${TARGET_SRC_DIR}/cache.c"
    "${TARGET_SRC_DIR}/dev.c"
    "${TARGET_SRC_DIR}/devname.c"
    "${TARGET_SRC_DIR}/devno.c"
    "${TARGET_SRC_DIR}/getsize.c"
    "${TARGET_SRC_DIR}/llseek.c"
    "${TARGET_SRC_DIR}/probe.c"
    "${TARGET_SRC_DIR}/read.c"
    "${TARGET_SRC_DIR}/resolve.c"
    "${TARGET_SRC_DIR}/save.c"
    "${TARGET_SRC_DIR}/tag.c"
    "${TARGET_SRC_DIR}/version.c"
)

add_library(${TARGET} STATIC ${libext2_blkid_srcs})

target_include_directories(${TARGET} PRIVATE
    ${E2FSPROGS_DEFAULT_INCLUDES}
)

target_compile_options(${TARGET} PRIVATE
	"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
	"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)