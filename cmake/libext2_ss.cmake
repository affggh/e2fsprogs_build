set(TARGET ext2_ss)

set(TARGET_SRC_DIR "${LIB_DIR}/e2fsprogs/lib/ss")

include(e2fsprogs_defaults.cmake)

set(TARGET_CFLAGS
	${E2FSPROGS_DEFAULT_CFLAGS}
)

if (CYGWIN)
    list(APPEND TARGET_CFLAGS "-DHAVE_SYS_WAIT_H")
endif ()

set(libext2_ss_srcs
    "${TARGET_SRC_DIR}/ss_err.c"
    "${TARGET_SRC_DIR}/std_rqs.c"
    "${TARGET_SRC_DIR}/invocation.c"
    "${TARGET_SRC_DIR}/help.c"
    "${TARGET_SRC_DIR}/execute_cmd.c"
    "${TARGET_SRC_DIR}/listen.c"
    "${TARGET_SRC_DIR}/parse.c"
    "${TARGET_SRC_DIR}/error.c"
    "${TARGET_SRC_DIR}/prompt.c"
    "${TARGET_SRC_DIR}/request_tbl.c"
    "${TARGET_SRC_DIR}/list_rqs.c"
    "${TARGET_SRC_DIR}/pager.c"
    "${TARGET_SRC_DIR}/requests.c"
    "${TARGET_SRC_DIR}/data.c"
    "${TARGET_SRC_DIR}/get_readline.c"
)

add_library(${TARGET} STATIC ${libext2_ss_srcs})

target_include_directories(${TARGET} PRIVATE
    ${E2FSPROGS_DEFAULT_INCLUDES}
    ${TARGET_SRC_DIR}
)

target_compile_options(${TARGET} PRIVATE
	"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
	"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)