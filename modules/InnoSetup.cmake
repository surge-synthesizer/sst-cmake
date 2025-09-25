set(INNOSETUP_MODULE_DIR ${CMAKE_CURRENT_LIST_DIR})

function(install_inno_setup)
    find_program(INNOSETUP_COMPILER_EXECUTABLE iscc)

    if(NOT INNOSETUP_COMPILER_EXECUTABLE)
        message(
            STATUS
            "Inno Setup Compiler not found, downloading & installing into ${CMAKE_BINARY_DIR}..."
        )

        file(
            DOWNLOAD
                "https://files.jrsoftware.org/is/6/innosetup-6.5.4.exe"
                "${CMAKE_BINARY_DIR}/innosetup-6.5.4.exe"
            EXPECTED_HASH
                SHA256=FA73BF47A4DA250D185D07561C2BFDA387E5E20DB77E4570004CF6A133CC10B1
        )

        execute_process(
            COMMAND
                "${CMAKE_BINARY_DIR}/innosetup-6.5.4.exe" /VERYSILENT
                /CURRENTUSER /DIR=${CMAKE_BINARY_DIR}/innosetup-6.5.4
        )

        find_program(
            INNOSETUP_COMPILER_EXECUTABLE
            iscc
            PATHS ${CMAKE_BINARY_DIR}/innosetup-6.5.4
        )

        message(STATUS "Resolved iscc=${INNOSETUP_COMPILER_EXECUTABLE}")
    endif()

    set(INNOSETUP_INSTALL_SCRIPT
        ${INNOSETUP_MODULE_DIR}/InnoSetup/installer.iss
        PARENT_SCOPE
    )

    if(CMAKE_SYSTEM_PROCESSOR MATCHES "ARM64")
        set(INNOSETUP_ARCH_ID "arm64" PARENT_SCOPE)
    elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "AMD64")
        set(INNOSETUP_ARCH_ID "x64compatible" PARENT_SCOPE)
    else()
        set(INNOSETUP_ARCH_ID "x86compatible" PARENT_SCOPE)
    endif()
endfunction()
