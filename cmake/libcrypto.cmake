set(TARGET crypto)

set(TARGET_SRC_DIR "${LIB_DIR}/boringssl")

set(TARGET_CFLAGS 
    "-Wall"
    "-fvisibility=hidden"
    "-DBORINGSSL_SHARED_LIBRARY"
    "-DOPENSSL_SMALL"
    "-Werror"
    "-Wno-unused-parameter"
)

list(APPEND TARGET_CFLAGS "-DBORINGSSL_IMPLEMENTATION")

set(BORINGSSL_ROOT ${TARGET_SRC_DIR}/)
include(${TARGET_SRC_DIR}/android-sources.cmake)

set(libcrypto_srcs ${crypto_sources})

if (NOT (WIN32 OR CYGWIN))
    list(APPEND libcrypto_srcs ${crypto_sources_asm})
endif ()

add_library(${TARGET} STATIC ${libcrypto_srcs})

target_include_directories(${TARGET} PRIVATE
    ${libcrypto_headers}
)

if (WIN32)
    target_link_options(${TARGET} PUBLIC "-lws2_32")
else ()
    target_link_options(${TARGET} PUBLIC "-lpthread")
endif ()

target_compile_options(${TARGET} PRIVATE
	"$<$<COMPILE_LANGUAGE:C>:${TARGET_CFLAGS}>"
	"$<$<COMPILE_LANGUAGE:CXX>:${TARGET_CFLAGS}>"
)