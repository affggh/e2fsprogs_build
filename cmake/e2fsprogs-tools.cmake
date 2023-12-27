set(common_static_link_lib
    "ext2_misc"
    "ext2fs"
    "ext2_com_err"
    "ext2_profile"
    "ext2_e2p"
    "ext2_quota"
    "ext2_blkid"
    "ext2_uuid"
    "ext2_support"
    "ext2_ss"
    "sparse"
    "z_stable"
    "cutils"
    "base"
    "selinux"
    "crypto"
    "log"
    "pcre2"
)

if (CYGWIN)
    list(common_link_options "-stdlib=libc++" "-static" "-s")
endif ()

# mke2fs
include(e2fsprogs_defaults.cmake)

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
target_link_options(${TARGET} PRIVATE ${common_link_options})
target_compile_options(${TARGET} PRIVATE
"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)

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
target_link_options(${TARGET} PRIVATE ${common_link_options})
target_compile_options(${TARGET} PRIVATE
"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)

# ext2simg
include(e2fsprogs_defaults.cmake)

set(TARGET ext2simg)
set(TARGET_SRC_DIR "${LIB_DIR}/e2fsprogs/contrib/android")
set(TARGET_CFLAGS
	${E2FSPROGS_DEFAULT_CFLAGS}
)
set(ext2simg_srcs
    "${TARGET_SRC_DIR}/ext2simg.c"
)
add_executable(${TARGET} ${ext2simg_srcs})
target_include_directories(${TARGET} PRIVATE
    ${E2FSPROGS_DEFAULT_INCLUDES}
    ${TARGET_SRC_DIR}
    ${libsparse_headers}
)
target_link_libraries(${TARGET} ${common_static_link_lib})
target_link_options(${TARGET} PRIVATE ${common_link_options})
target_compile_options(${TARGET} PRIVATE
"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)

# tune2fs
include(e2fsprogs_defaults.cmake)
set(TARGET tune2fs)
set(TARGET_SRC_DIR "${LIB_DIR}/e2fsprogs/misc")
set(TARGET_CFLAGS
	${E2FSPROGS_DEFAULT_CFLAGS}
    "-DNO_RECOVERY"
)
set(tune2fs_srcs
    "${TARGET_SRC_DIR}/tune2fs.c"
    "${TARGET_SRC_DIR}/util.c"
)
add_executable(${TARGET} ${tune2fs_srcs})
target_include_directories(${TARGET} PRIVATE
    ${E2FSPROGS_DEFAULT_INCLUDES}
    ${TARGET_SRC_DIR}
    ${LIB_DIR}/e2fsprogs/e2fsck
)
target_link_libraries(${TARGET} ${common_static_link_lib})
target_link_options(${TARGET} PRIVATE ${common_link_options})
target_compile_options(${TARGET} PRIVATE
"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)

# e2fsck
include(e2fsprogs_defaults.cmake)
set(TARGET e2fsck)
set(TARGET_SRC_DIR "${LIB_DIR}/e2fsprogs/e2fsck")
set(TARGET_CFLAGS
	${E2FSPROGS_DEFAULT_CFLAGS}
)
set(e2fsck_srcs
    "${TARGET_SRC_DIR}/e2fsck.c"
    "${TARGET_SRC_DIR}/super.c"
    "${TARGET_SRC_DIR}/pass1.c"
    "${TARGET_SRC_DIR}/pass1b.c"
    "${TARGET_SRC_DIR}/pass2.c"
    "${TARGET_SRC_DIR}/pass3.c"
    "${TARGET_SRC_DIR}/pass4.c"
    "${TARGET_SRC_DIR}/pass5.c"
    "${TARGET_SRC_DIR}/logfile.c"
    "${TARGET_SRC_DIR}/journal.c"
    "${TARGET_SRC_DIR}/recovery.c"
    "${TARGET_SRC_DIR}/revoke.c"
    "${TARGET_SRC_DIR}/badblocks.c"
    "${TARGET_SRC_DIR}/util.c"
    "${TARGET_SRC_DIR}/unix.c"
    "${TARGET_SRC_DIR}/dirinfo.c"
    "${TARGET_SRC_DIR}/dx_dirinfo.c"
    "${TARGET_SRC_DIR}/ehandler.c"
    "${TARGET_SRC_DIR}/problem.c"
    "${TARGET_SRC_DIR}/message.c"
    "${TARGET_SRC_DIR}/ea_refcount.c"
    "${TARGET_SRC_DIR}/quota.c"
    "${TARGET_SRC_DIR}/rehash.c"
    "${TARGET_SRC_DIR}/region.c"
    "${TARGET_SRC_DIR}/sigcatcher.c"
    "${TARGET_SRC_DIR}/readahead.c"
    "${TARGET_SRC_DIR}/extents.c"
    "${TARGET_SRC_DIR}/encrypted_files.c"
)
add_executable(${TARGET} ${e2fsck_srcs})
target_include_directories(${TARGET} PRIVATE
    ${E2FSPROGS_DEFAULT_INCLUDES}
    ${TARGET_SRC_DIR}
)
target_link_libraries(${TARGET} ${common_static_link_lib})
target_link_options(${TARGET} PRIVATE ${common_link_options})
target_compile_options(${TARGET} PRIVATE
"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)

#debugfs
include(e2fsprogs_defaults.cmake)
set(TARGET debugfs)
set(TARGET_SRC_DIR "${LIB_DIR}/e2fsprogs/debugfs")
set(TARGET_CFLAGS
	${E2FSPROGS_DEFAULT_CFLAGS}
    "-DDEBUGFS"
)
set(debugfs_srcs
    "${TARGET_SRC_DIR}/debug_cmds.c"
    "${TARGET_SRC_DIR}/debugfs.c"
    "${TARGET_SRC_DIR}/util.c"
    "${TARGET_SRC_DIR}/ncheck.c"
    "${TARGET_SRC_DIR}/icheck.c"
    "${TARGET_SRC_DIR}/ls.c"
    "${TARGET_SRC_DIR}/lsdel.c"
    "${TARGET_SRC_DIR}/dump.c"
    "${TARGET_SRC_DIR}/set_fields.c"
    "${TARGET_SRC_DIR}/logdump.c"
    "${TARGET_SRC_DIR}/htree.c"
    "${TARGET_SRC_DIR}/unused.c"
    "${TARGET_SRC_DIR}/e2freefrag.c"
    "${TARGET_SRC_DIR}/filefrag.c"
    "${TARGET_SRC_DIR}/extent_cmds.c"
    "${TARGET_SRC_DIR}/extent_inode.c"
    "${TARGET_SRC_DIR}/zap.c"
    "${TARGET_SRC_DIR}/quota.c"
    "${TARGET_SRC_DIR}/xattrs.c"
    "${TARGET_SRC_DIR}/journal.c"
    "${TARGET_SRC_DIR}/revoke.c"
    "${TARGET_SRC_DIR}/recovery.c"
    "${TARGET_SRC_DIR}/do_journal.c"
)
add_executable(${TARGET} ${debugfs_srcs})
target_include_directories(${TARGET} PRIVATE
    ${E2FSPROGS_DEFAULT_INCLUDES}
    ${TARGET_SRC_DIR}
    ${LIB_DIR}/e2fsprogs/misc
    ${LIB_DIR}/e2fsprogs/e2fsck
)
target_link_libraries(${TARGET} ${common_static_link_lib})
target_link_options(${TARGET} PRIVATE ${common_link_options})
target_compile_options(${TARGET} PRIVATE
"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)