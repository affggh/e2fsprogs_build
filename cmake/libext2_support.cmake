set(TARGET ext2_support)

set(TARGET_SRC_DIR "${LIB_DIR}/e2fsprogs/lib/support")

include(e2fsprogs_defaults.cmake)

set(TARGET_CFLAGS
	${E2FSPROGS_DEFAULT_CFLAGS}
)

if (CYGWIN)
    list(APPEND TARGET_CFLAGS "-DHAVE_SYS_WAIT_H")
endif ()

set(libext2_quota_srcs
    "${TARGET_SRC_DIR}/devname.c"
    "${TARGET_SRC_DIR}/dict.c"
    "${TARGET_SRC_DIR}/mkquota.c"
    "${TARGET_SRC_DIR}/parse_qtype.c"
    "${TARGET_SRC_DIR}/plausible.c"
    "${TARGET_SRC_DIR}/profile.c"
    "${TARGET_SRC_DIR}/profile_helpers.c"
    "${TARGET_SRC_DIR}/prof_err.c"
    "${TARGET_SRC_DIR}/quotaio.c"
    "${TARGET_SRC_DIR}/quotaio_tree.c"
    "${TARGET_SRC_DIR}/quotaio_v2.c"
)

set(libext2_profile_src
    "${TARGET_SRC_DIR}/prof_err.c"
    "${TARGET_SRC_DIR}/profile.c"
)

set(libext2_support_src
    "${TARGET_SRC_DIR}/cstring.c"
)


add_library(ext2_quota STATIC ${libext2_quota_srcs})
add_library(ext2_profile STATIC ${libext2_profile_src})
add_library(${TARGET} STATIC ${libext2_ss_srcs})

target_include_directories(ext2_quota PRIVATE
    ${E2FSPROGS_DEFAULT_INCLUDES}
    ${TARGET_SRC_DIR}
)

target_include_directories(ext2_profile PRIVATE
    ${E2FSPROGS_DEFAULT_INCLUDES}
    ${TARGET_SRC_DIR}
)

target_include_directories(${TARGET} PRIVATE
    ${E2FSPROGS_DEFAULT_INCLUDES}
    ${TARGET_SRC_DIR}
)

target_compile_options(ext2_quota PRIVATE
	"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
	"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)

target_compile_options(ext2_profile PRIVATE
	"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
	"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)

target_compile_options(${TARGET} PRIVATE
	"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
	"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)