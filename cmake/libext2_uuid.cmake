set(TARGET ext2_uuid)

set(TARGET_SRC_DIR "${LIB_DIR}/e2fsprogs/lib/uuid")

include(e2fsprogs_defaults.cmake)

set(TARGET_CFLAGS
	${E2FSPROGS_DEFAULT_CFLAGS}
)

set(libext2_uuid_srcs
    "${TARGET_SRC_DIR}/clear.c"
    "${TARGET_SRC_DIR}/compare.c"
    "${TARGET_SRC_DIR}/copy.c"
    "${TARGET_SRC_DIR}/gen_uuid.c"
    "${TARGET_SRC_DIR}/isnull.c"
    "${TARGET_SRC_DIR}/pack.c"
    "${TARGET_SRC_DIR}/parse.c"
    "${TARGET_SRC_DIR}/unpack.c"
    "${TARGET_SRC_DIR}/unparse.c"
    "${TARGET_SRC_DIR}/uuid_time.c"
)

add_library(${TARGET} STATIC ${libext2_uuid_srcs})

target_include_directories(${TARGET} PRIVATE
    ${E2FSPROGS_DEFAULT_INCLUDES}
    ${TARGET_SRC_DIR}
)

target_compile_options(${TARGET} PRIVATE
	"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
	"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)