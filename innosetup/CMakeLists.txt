find_program(INNOSETUP_COMPILER_EXECUTABLE iscc)

if(NOT INNOSETUP_COMPILER_EXECUTABLE)
    add_custom_target(
        innosetup_compiler
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        COMMAND
            ${CMAKE_COMMAND} -P
            "${CMAKE_CURRENT_LIST_DIR}/install_innosetup.cmake"
    )

    set(INNOSETUP_COMPILER_EXECUTABLE
        "${CMAKE_BINARY_DIR}/innosetup-6.5.4/iscc.exe"
        PARENT_SCOPE
    )
else()
    add_custom_target(innosetup_compiler)
endif()

message(STATUS "Resolved iscc=${INNOSETUP_COMPILER_EXECUTABLE}")

set(INNOSETUP_INSTALL_SCRIPT
    "${CMAKE_CURRENT_LIST_DIR}/installer.iss"
    PARENT_SCOPE
)

if(CMAKE_SYSTEM_PROCESSOR MATCHES "ARM64")
    set(INNOSETUP_ARCH_ID "arm64" PARENT_SCOPE)
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "AMD64")
    set(INNOSETUP_ARCH_ID "x64compatible" PARENT_SCOPE)
else()
    set(INNOSETUP_ARCH_ID "x86compatible" PARENT_SCOPE)
endif()
