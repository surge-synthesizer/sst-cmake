project(Plugin VERSION 0.0.0)
include(GetSystemBits)
find_package(SST)

if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    set(INNOSETUP_EXPECTED_SHA256
        "9345EE029FAA0B7AED0818C3D5B227699EF9A496CCE79E20C19EB9D6EF2E2C2D"
        CACHE STRING
        "Override InnoSetup installer SHA256"
    )
    find_package(InnoSetup 6.5.3)
    message(STATUS "InnoSetup: ${INNOSETUP_ROOT_DIR}")
    message(STATUS "InnoSetup Compiler: ${INNOSETUP_COMPILER_EXECUTABLE}")
    message(STATUS "InnoSetup Architecture ID: ${INNOSETUP_ARCH_ID}")
    message(STATUS "InnoSetup .iss template: ${INNOSETUP_ISS_TEMPLATE}")
endif()

add_library(plugin)
set_target_properties(plugin PROPERTIES SUFFIX ".clap")
target_link_libraries(
    plugin
    PRIVATE sst::compile_features sst::compile_options sst::link_options
)

if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    target_sources(plugin PRIVATE "src/win/plugin.cpp")

    # Optional, .iss should generate the same thing here by default
    set(INSTALLER_NAME
        "${PROJECT_NAME}-${PROJECT_VERSION}-${CMAKE_SYSTEM_NAME}-${SYSTEM_BITS}bits-setup"
    )

    # Make sure to generate your own GUID
    add_custom_target(
        installer
        COMMAND
            ${INNOSETUP_COMPILER_EXECUTABLE} /O"$<TARGET_FILE_DIR:plugin>"
            /F"${INSTALLER_NAME}" /DName="Plugin" /DNameCondensed="Plugin"
            /DVersion="0.0.0" /DID="CDB8A9AB-E44D-45E2-905F-575AD1DB6DD4" /DCLAP
            /DSRC="${CMAKE_SOURCE_DIR}" /DBIN="$<TARGET_FILE_DIR:plugin>"
            /DIcon="${CMAKE_CURRENT_LIST_DIR}/icon.ico"
            /DArch="${INNOSETUP_ARCH_ID}" /DBits="${SYSTEM_BITS}"
            "${INNOSETUP_ISS_TEMPLATE}"
        DEPENDS plugin
    )
endif()
