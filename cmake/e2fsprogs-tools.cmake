set(common_static_link_lib
    "ext2_com_err"
    "ext2_misc"
    "ext2fs"
    "ext2_com_err"
    "ext2_profile"
    "ext2_e2p"
    "ext2_quota"
    "ext2_blkid"
    "ext2_uuid"
    "sparse"
    "z_stable"
    "cutils"
    "base"
    "selinux"
    "crypto"
    "log"
    "pcre2"
)

# mke2fs
include(e2fsprogs_defaults.cmake)
if (CYGWIN)
    list(APPEND TARGET_CFLAGS "-DHAVE_SYS_WAIT_H")
endif ()

set(TARGET mke2fs)
set(TARGET_SRC_DIR "${LIB_DIR}/e2fsprogs/misc")
set(TARGET_CFLAGS
	${E2FSPROGS_DEFAULT_CFLAGS}
)
set(mke2fs_srcs
    "${TARGET_SRC_DIR}/mke2fs.c"
    "${TARGET_SRC_DIR}/util.c"
    "${TARGET_SRC_DIR}/mk_hugefiles.c"
    "${TARGET_SRC_DIR}/default_profile.c"
)
add_executable(${TARGET} ${mke2fs_srcs})
target_include_directories(${TARGET} PRIVATE
    ${E2FSPROGS_DEFAULT_INCLUDES}
    ${TARGET_SRC_DIR}
)
target_link_libraries(${TARGET} ${common_static_link_lib})
target_link_options(${TARGET} PRIVATE "-static")

include(e2fsprogs_defaults.cmake)
if (CYGWIN)
    list(APPEND TARGET_CFLAGS "-DHAVE_SYS_WAIT_H")
endif ()

# e2fsdroid
set(TARGET e2fsdroid)
set(TARGET_SRC_DIR "${LIB_DIR}/e2fsprogs/contrib/android")
set(TARGET_CFLAGS
	${E2FSPROGS_DEFAULT_CFLAGS}
)
if (CYGWIN)
    list(APPEND TARGET_CFLAGS "-D__GNU_VISIBLE")
endif ()
set(e2fsdroid_srcs
    "${TARGET_SRC_DIR}/e2fsdroid.c"
    "${TARGET_SRC_DIR}/block_range.c"
    "${TARGET_SRC_DIR}/fsmap.c"
    "${TARGET_SRC_DIR}/block_list.c"
    "${TARGET_SRC_DIR}/base_fs.c"
    "${TARGET_SRC_DIR}/perms.c"
    "${TARGET_SRC_DIR}/basefs_allocator.c"
)
add_executable(${TARGET} ${e2fsdroid_srcs})
target_include_directories(${TARGET} PRIVATE
    ${E2FSPROGS_DEFAULT_INCLUDES}
    ${TARGET_SRC_DIR}
    ${libselinux_headers}
    ${libbase_headers}
    ${libcutils_headers}
    ${liblog_headers}
    ${libsparse_headers}
    ${libext2lib_headers}/ext2fs
    ${libext2lib_headers}/../misc
    ${LIB_DIR}
)
target_link_libraries(${TARGET} ${common_static_link_lib})
target_link_options(${TARGET} PRIVATE "-static")