set(TARGET ext2_e2p)

set(TARGET_SRC_DIR "${LIB_DIR}/e2fsprogs/lib/e2p")

include(e2fsprogs_defaults.cmake)

set(TARGET_CFLAGS
	${E2FSPROGS_DEFAULT_CFLAGS}
)

set(libext2_e2p_srcs
    "${TARGET_SRC_DIR}/encoding.c"
    "${TARGET_SRC_DIR}/errcode.c"
    "${TARGET_SRC_DIR}/feature.c"
    "${TARGET_SRC_DIR}/fgetflags.c"
    "${TARGET_SRC_DIR}/fsetflags.c"
    "${TARGET_SRC_DIR}/fgetproject.c"
    "${TARGET_SRC_DIR}/fsetproject.c"
    "${TARGET_SRC_DIR}/fgetversion.c"
    "${TARGET_SRC_DIR}/fsetversion.c"
    "${TARGET_SRC_DIR}/getflags.c"
    "${TARGET_SRC_DIR}/getversion.c"
    "${TARGET_SRC_DIR}/hashstr.c"
    "${TARGET_SRC_DIR}/iod.c"
    "${TARGET_SRC_DIR}/ljs.c"
    "${TARGET_SRC_DIR}/ls.c"
    "${TARGET_SRC_DIR}/mntopts.c"
    "${TARGET_SRC_DIR}/parse_num.c"
    "${TARGET_SRC_DIR}/pe.c"
    "${TARGET_SRC_DIR}/pf.c"
    "${TARGET_SRC_DIR}/ps.c"
    "${TARGET_SRC_DIR}/setflags.c"
    "${TARGET_SRC_DIR}/setversion.c"
    "${TARGET_SRC_DIR}/uuid.c"
    "${TARGET_SRC_DIR}/ostype.c"
    "${TARGET_SRC_DIR}/percent.c"
)

add_library(${TARGET} STATIC ${libext2_e2p_srcs})

target_include_directories(${TARGET} PRIVATE
    ${E2FSPROGS_DEFAULT_INCLUDES}
    ${TARGET_SRC_DIR}
)

target_compile_options(${TARGET} PRIVATE
	"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
	"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)