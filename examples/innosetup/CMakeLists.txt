project(InnoSetupExample VERSION 0.0.0)

add_library(innosetup_plugin)

target_compile_features(innosetup_plugin PRIVATE c_std_17 cxx_std_20)

set_target_properties(innosetup_plugin PROPERTIES SUFFIX ".clap")

add_executable(innosetup_standalone)

target_compile_features(innosetup_standalone PRIVATE c_std_17 cxx_std_20)

set_target_properties(
    innosetup_standalone
    PROPERTIES OUTPUT_NAME "innosetup_plugin"
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

    if(TARGET innosetup::compiler)
        # Make sure to generate your own GUID
        add_custom_target(
            installer
            COMMAND
                innosetup::compiler /O"$<TARGET_FILE_DIR:innosetup_plugin>"
                /DName="innosetup_plugin" /DNameCondensed="innosetup_plugin"
                /DVersion="0.0.0" /DID="B4D0D906-1549-43AE-A1DA-50763394B707"
                /DArch=$<TARGET_PROPERTY:innosetup::compiler,ARCH_ID>
                /DIcon="${CMAKE_CURRENT_LIST_DIR}/icon.ico"
                /DBanner="${CMAKE_CURRENT_LIST_DIR}/banner.png"
                /DLicense="${CMAKE_SOURCE_DIR}/LICENSE" /DCLAP /DVST3 /DSA
                /DStagedAssets="$<TARGET_FILE_DIR:innosetup_plugin>"
                /DData="${CMAKE_CURRENT_LIST_DIR}/data"
                $<TARGET_PROPERTY:innosetup::compiler,INSTALL_SCRIPT>
            DEPENDS innosetup_plugin innosetup_standalone
        )
    else()
        message(
            WARNING
            "Inno Setup compiler not found, skipping installer targets"
        )
    endif()
endif()
