add_library(sst_compile_features INTERFACE)
add_library(sst::compile_features ALIAS sst_compile_features)
target_compile_features(sst_compile_features INTERFACE c_std_17 cxx_std_20)

add_library(sst_compile_options INTERFACE)
add_library(sst::compile_options ALIAS sst_compile_options)

add_library(sst_link_options INTERFACE)
add_library(sst::link_options ALIAS sst_link_options)

if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    if(CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "GNU")
        target_link_options(sst_link_options INTERFACE -Wl,/WX)
    elseif(CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "MSVC")
        target_link_options(sst_link_options INTERFACE /WX)
    endif()
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    target_link_options(sst_link_options INTERFACE /WX)
endif()
