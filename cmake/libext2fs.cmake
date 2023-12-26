set(TARGET ext2fs)

set(TARGET_SRC_DIR "${LIB_DIR}/e2fsprogs/lib/ext2fs")

include(e2fsprogs_defaults.cmake)

set(TARGET_CFLAGS
	${E2FSPROGS_DEFAULT_CFLAGS}
)

if (CYGWIN)
    list(APPEND TARGET_CFLAGS 
        "-includeio.h"
        "-Wno-#warnings"
        "-Wno-unused-variable")
endif ()

set(libext2fs_srcs
    "${TARGET_SRC_DIR}/ext2_err.c"
    "${TARGET_SRC_DIR}/alloc.c"
    "${TARGET_SRC_DIR}/alloc_sb.c"
    "${TARGET_SRC_DIR}/alloc_stats.c"
    "${TARGET_SRC_DIR}/alloc_tables.c"
    "${TARGET_SRC_DIR}/atexit.c"
    "${TARGET_SRC_DIR}/badblocks.c"
    "${TARGET_SRC_DIR}/bb_inode.c"
    "${TARGET_SRC_DIR}/bitmaps.c"
    "${TARGET_SRC_DIR}/bitops.c"
    "${TARGET_SRC_DIR}/blkmap64_ba.c"
    "${TARGET_SRC_DIR}/blkmap64_rb.c"
    "${TARGET_SRC_DIR}/blknum.c"
    "${TARGET_SRC_DIR}/block.c"
    "${TARGET_SRC_DIR}/bmap.c"
    "${TARGET_SRC_DIR}/check_desc.c"
    "${TARGET_SRC_DIR}/crc16.c"
    "${TARGET_SRC_DIR}/crc32c.c"
    "${TARGET_SRC_DIR}/csum.c"
    "${TARGET_SRC_DIR}/closefs.c"
    "${TARGET_SRC_DIR}/dblist.c"
    "${TARGET_SRC_DIR}/dblist_dir.c"
    "${TARGET_SRC_DIR}/digest_encode.c"
    "${TARGET_SRC_DIR}/dirblock.c"
    "${TARGET_SRC_DIR}/dirhash.c"
    "${TARGET_SRC_DIR}/dir_iterate.c"
    "${TARGET_SRC_DIR}/dupfs.c"
    "${TARGET_SRC_DIR}/expanddir.c"
    "${TARGET_SRC_DIR}/ext_attr.c"
    "${TARGET_SRC_DIR}/extent.c"
    "${TARGET_SRC_DIR}/fallocate.c"
    "${TARGET_SRC_DIR}/fileio.c"
    "${TARGET_SRC_DIR}/finddev.c"
    "${TARGET_SRC_DIR}/flushb.c"
    "${TARGET_SRC_DIR}/freefs.c"
    "${TARGET_SRC_DIR}/gen_bitmap.c"
    "${TARGET_SRC_DIR}/gen_bitmap64.c"
    "${TARGET_SRC_DIR}/get_num_dirs.c"
    "${TARGET_SRC_DIR}/get_pathname.c"
    "${TARGET_SRC_DIR}/getsize.c"
    "${TARGET_SRC_DIR}/getsectsize.c"
    "${TARGET_SRC_DIR}/hashmap.c"
    "${TARGET_SRC_DIR}/i_block.c"
    "${TARGET_SRC_DIR}/icount.c"
    "${TARGET_SRC_DIR}/imager.c"
    "${TARGET_SRC_DIR}/ind_block.c"
    "${TARGET_SRC_DIR}/initialize.c"
    "${TARGET_SRC_DIR}/inline.c"
    "${TARGET_SRC_DIR}/inline_data.c"
    "${TARGET_SRC_DIR}/inode.c"
    "${TARGET_SRC_DIR}/io_manager.c"
    "${TARGET_SRC_DIR}/ismounted.c"
    "${TARGET_SRC_DIR}/link.c"
    "${TARGET_SRC_DIR}/llseek.c"
    "${TARGET_SRC_DIR}/lookup.c"
    "${TARGET_SRC_DIR}/mmp.c"
    "${TARGET_SRC_DIR}/mkdir.c"
    "${TARGET_SRC_DIR}/mkjournal.c"
    "${TARGET_SRC_DIR}/namei.c"
    "${TARGET_SRC_DIR}/native.c"
    "${TARGET_SRC_DIR}/newdir.c"
    "${TARGET_SRC_DIR}/nls_utf8.c"
    "${TARGET_SRC_DIR}/openfs.c"
    "${TARGET_SRC_DIR}/progress.c"
    "${TARGET_SRC_DIR}/punch.c"
    "${TARGET_SRC_DIR}/qcow2.c"
    "${TARGET_SRC_DIR}/rbtree.c"
    "${TARGET_SRC_DIR}/read_bb.c"
    "${TARGET_SRC_DIR}/read_bb_file.c"
    "${TARGET_SRC_DIR}/res_gdt.c"
    "${TARGET_SRC_DIR}/rw_bitmaps.c"
    "${TARGET_SRC_DIR}/sha256.c"
    "${TARGET_SRC_DIR}/sha512.c"
    "${TARGET_SRC_DIR}/swapfs.c"
    "${TARGET_SRC_DIR}/symlink.c"
    "${TARGET_SRC_DIR}/undo_io.c"
    "${TARGET_SRC_DIR}/unix_io.c"
    "${TARGET_SRC_DIR}/sparse_io.c"
    "${TARGET_SRC_DIR}/unlink.c"
    "${TARGET_SRC_DIR}/valid_blk.c"
    "${TARGET_SRC_DIR}/version.c"
    #// get rid of this?!
    #"${TARGET_SRC_DIR}/test_io.c",
)

add_library(${TARGET} STATIC ${libext2fs_srcs})

target_include_directories(${TARGET} PRIVATE
    ${E2FSPROGS_DEFAULT_INCLUDES}
    ${TARGET_SRC_DIR}
    ${libsparse_headers}
)

target_compile_options(${TARGET} PRIVATE
	"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
	"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)