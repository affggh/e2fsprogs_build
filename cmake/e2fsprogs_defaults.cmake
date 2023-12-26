set(E2FSPROGS_DEFAULT_CFLAGS
    "-Wall"
    "-Werror"
    "-Wno-pointer-arith"
    "-Wno-sign-compare"
    "-Wno-type-limits"
    "-Wno-typedef-redefinition"
    "-Wno-unused-parameter"
    "-g"
)

if (CYGWIN)
    list(APPEND E2FSPROGS_DEFAULT_CFLAGS 
        "-Wno-char-subscripts"
        "-Wno-unused-but-set-variable"
        "-g"
        )
endif ()

set(E2FSPROGS_DEFAULT_INCLUDES
    ${libext2_headers}
    ${libext2lib_headers}
)