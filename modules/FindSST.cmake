add_library(sst_compile_features INTERFACE)
add_library(sst::compile_features ALIAS sst_compile_features)
target_compile_features(sst_compile_features INTERFACE c_std_17 cxx_std_20)

add_library(sst_compile_options INTERFACE)
add_library(sst::compile_options ALIAS sst_compile_options)
target_compile_options(
    sst_compile_options
    INTERFACE
        $<$<CXX_COMPILER_ID:MSVC>:
        /W4
        /WX
        /utf-8
        /bigobj
        /permissive-
        /Zc:__cplusplus,enumTypes,templateScope,throwingNew,preprocessor
        >
        $<$<AND:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_FRONTEND_VARIANT:MSVC>>:
        /W4
        /WX
        >
        $<$<AND:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_FRONTEND_VARIANT:GNU>>:
        -Wall
        -Werror
        >
)

add_library(sst_link_options INTERFACE)
add_library(sst::link_options ALIAS sst_link_options)
target_link_options(
    sst_link_options
    INTERFACE
        $<$<CXX_COMPILER_ID:MSVC>:
        /WX
        >
        $<$<AND:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_FRONTEND_VARIANT:MSVC>>:
        /WX
        >
        $<$<AND:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_FRONTEND_VARIANT:GNU>>:
        -Wl,/WX
        >
)
