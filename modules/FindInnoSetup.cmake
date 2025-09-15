find_program(INNOSETUP_COMPILER_EXECUTABLE iscc)

if(NOT INNOSETUP_COMPILER_EXECUTABLE)
    if(NOT DEFINED InnoSetup_FIND_VERSION)
        set(InnoSetup_FIND_VERSION "6.5.3")
    endif()

    if(InnoSetup_FIND_VERSION STREQUAL "6.5.3")
        if(NOT DEFINED INNOSETUP_EXPECTED_SHA256)
            set(INNOSETUP_EXPECTED_SHA256
                "9345EE029FAA0B7AED0818C3D5B227699EF9A496CCE79E20C19EB9D6EF2E2C2D"
                CACHE STRING
                "Optional SHA256 hash to verify integrity of the downloaded InnoSetup installer"
            )
        endif()
    endif()

    if(DEFINED INNOSETUP_EXPECTED_SHA256)
        message(STATUS "Verifying InnoSetup installer with expected hash")
        file(
            DOWNLOAD
                "https://files.jrsoftware.org/is/6/innosetup-${InnoSetup_FIND_VERSION}.exe"
                "${CMAKE_BINARY_DIR}/innosetup-${InnoSetup_FIND_VERSION}.exe"
            EXPECTED_HASH SHA256=${INNOSETUP_EXPECTED_SHA256}
        )
    else()
        message(
            WARNING
            "No expected hash for InnoSetup installer; skipping integrity check"
        )
        file(
            DOWNLOAD
                "https://files.jrsoftware.org/is/6/innosetup-${InnoSetup_FIND_VERSION}.exe"
                "${CMAKE_BINARY_DIR}/innosetup-${InnoSetup_FIND_VERSION}.exe"
        )
    endif()

    execute_process(
        COMMAND
            "${CMAKE_BINARY_DIR}/innosetup-${InnoSetup_FIND_VERSION}.exe"
            /VERYSILENT /CURRENTUSER /DIR=innosetup-${InnoSetup_FIND_VERSION}
    )

    find_program(
        INNOSETUP_COMPILER_EXECUTABLE
        iscc
        PATHS ${CMAKE_BINARY_DIR}/innosetup-${InnoSetup_FIND_VERSION}
    )
endif()

if(INNOSETUP_COMPILER_EXECUTABLE)
    set(INNOSETUP_COMPILER_FOUND TRUE)
    cmake_path(GET INNOSETUP_COMPILER_EXECUTABLE PARENT_PATH INNOSETUP_ROOT_DIR)
    set(INNOSETUP_FOUND TRUE)
endif()

if(CMAKE_SYSTEM_PROCESSOR MATCHES "ARM64")
    set(INNOSETUP_ARCH_ID "arm64")
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "AMD64")
    set(INNOSETUP_ARCH_ID "x64compatible")
else()
    set(INNOSETUP_ARCH_ID "x86compatible")
endif()
