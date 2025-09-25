if (NOT TARGET_DIR)
    message(FATAL_ERROR "Target Dir not set in cmake step")
endif()
file(
    DOWNLOAD
        "https://files.jrsoftware.org/is/6/innosetup-6.5.4.exe"
        "${TARGET_DIR}/innosetup-6.5.4.exe"
    EXPECTED_HASH
        SHA256=FA73BF47A4DA250D185D07561C2BFDA387E5E20DB77E4570004CF6A133CC10B1
)

execute_process(
    COMMAND
        "${TARGET_DIR}/innosetup-6.5.4.exe" /VERYSILENT /CURRENTUSER
        /DIR=${TARGET_DIR}/innosetup-6.5.4
)
