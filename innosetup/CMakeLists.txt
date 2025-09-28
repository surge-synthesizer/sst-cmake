if(CMAKE_SYSTEM_NAME STREQUAL "Windows" AND NOT TARGET innosetup::compiler)
    find_program(INNOSETUP_COMPILER_EXECUTABLE iscc)

    if(
        NOT INNOSETUP_COMPILER_EXECUTABLE
        OR "${INNOSETUP_COMPILER_EXECUTABLE}" MATCHES "NOTFOUND"
        OR NOT EXISTS "${INNOSETUP_COMPILER_EXECUTABLE}"
    )
        message(STATUS "Inno Setup compiler not found")
    else()
        message(
            STATUS
            "Inno Setup compiler found: ${INNOSETUP_COMPILER_EXECUTABLE}"
        )

        if(CMAKE_SYSTEM_PROCESSOR MATCHES "ARM64")
            set(INNOSETUP_ARCH_ID "arm64")
        elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "AMD64")
            set(INNOSETUP_ARCH_ID "x64compatible")
        else()
            set(INNOSETUP_ARCH_ID "x86compatible")
        endif()

        add_executable(innosetup::compiler IMPORTED GLOBAL)
        set_target_properties(
            innosetup::compiler
            PROPERTIES
                IMPORTED_LOCATION "${INNOSETUP_COMPILER_EXECUTABLE}"
                ARCH_ID "${INNOSETUP_ARCH_ID}"
                INSTALL_SCRIPT "${CMAKE_CURRENT_LIST_DIR}/installer.iss"
        )
    endif()
endif()
