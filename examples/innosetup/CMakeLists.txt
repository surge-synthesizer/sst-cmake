project(InnoSetupExample VERSION 0.0.0)
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
    message(STATUS "InnoSetup .iss template: ${INNOSETUP_TEMPLATE_FILE}")
endif()

add_library(innosetup_plugin)
set_target_properties(innosetup_plugin PROPERTIES SUFFIX ".clap")
target_link_libraries(
    innosetup_plugin
    PRIVATE sst::compile_features sst::compile_options sst::link_options
)
add_executable(innosetup_standalone)
set_target_properties(
    innosetup_standalone
    PROPERTIES OUTPUT_NAME "innosetup_plugin"
)
target_link_libraries(
    innosetup_standalone
    PRIVATE sst::compile_features sst::compile_options sst::link_options
)
add_custom_command(
    TARGET innosetup_plugin
    POST_BUILD
    COMMAND
        ${CMAKE_COMMAND} -E make_directory
        "$<TARGET_FILE_DIR:innosetup_plugin>/innosetup_plugin.vst3"
    COMMAND
        ${CMAKE_COMMAND} -E copy $<TARGET_FILE:innosetup_plugin>
        "$<TARGET_FILE_DIR:innosetup_plugin>/innosetup_plugin.vst3/innosetup_plugin.vst3"
)

if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    target_sources(innosetup_plugin PRIVATE "src/win/plugin.cpp")
    target_sources(innosetup_standalone PRIVATE "src/win/standalone.cpp")

    # Make sure to generate your own GUID
    add_custom_target(
        installer
        COMMAND
            ${INNOSETUP_COMPILER_EXECUTABLE}
            /O"$<TARGET_FILE_DIR:innosetup_plugin>" /DName="innosetup_plugin"
            /DNameCondensed="innosetup_plugin" /DVersion="0.0.0"
            /DID="B4D0D906-1549-43AE-A1DA-50763394B707"
            /DCLAP /DVST3
            /DIcon="${CMAKE_CURRENT_LIST_DIR}/icon.ico"
            /DArch="${INNOSETUP_ARCH_ID}"
            /DLicense="${CMAKE_SOURCE_DIR}/LICENSE"
            /DStagedAssets="$<TARGET_FILE_DIR:innosetup_plugin>"
            /DData="${CMAKE_CURRENT_LIST_DIR}/data" "${INNOSETUP_TEMPLATE_FILE}"
        DEPENDS innosetup_plugin innosetup_standalone
    )
endif()
