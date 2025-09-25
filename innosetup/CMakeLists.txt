find_program(INNOSETUP_COMPILER_EXECUTABLE iscc)

if("${INNOSETUP_COMPILER_EXECUTABLE}" STREQUAL "INNOSETUP_COMPILER_EXECUTABLE-NOTFOUND")
    message(STATUS "Inno Compiler was not found. Setting up echo as compiler")
    set(INNOSETUP_COMPILR_EXECUTABLE "${CMAKE_PROGRAM} -E echo")
else()
    message(STATUS "ISCC found: ${INNOSETUP_COMPILER_EXECUTABLE}")

endif()


add_custom_target(innosetup_compiler)
set(INNOSETUP_INSTALL_SCRIPT "${CMAKE_CURRENT_LIST_DIR}/installer.iss")

if(CMAKE_SYSTEM_PROCESSOR MATCHES "ARM64")
    set(INNOSETUP_ARCH_ID "arm64")
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "AMD64")
    set(INNOSETUP_ARCH_ID "x64compatible")
else()
    set(INNOSETUP_ARCH_ID "x86compatible")
endif()

set_target_properties(innosetup_compiler
        PROPERTIES
        COMPILER_EXECUTABLE "${INNOSETUP_COMPILER_EXECUTABLE}"
        ARCH_ID "${INNOSETUP_ARCH_ID}"
        INSTALL_SCRIPT "${INNOSETUP_INSTALL_SCRIPT}"
)