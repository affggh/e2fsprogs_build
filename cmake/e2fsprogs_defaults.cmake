set(E2FSPROGS_DEFAULT_CFLAGS
    "-Wall"
    "-Werror"
    "-Wno-pointer-arith"
    "-Wno-sign-compare"
    "-Wno-type-limits"
    "-Wno-typedef-redefinition"
    "-Wno-unused-parameter"
)

if (CYGWIN)
    list(APPEND E2FSPROGS_DEFAULT_CFLAGS 
        "-Wno-char-subscripts"
        "-Wno-unused-but-set-variable"
        )
endif ()

set(E2FSPROGS_DEFAULT_INCLUDES
    ${libext2_headers}
    ${libext2lib_headers}
)