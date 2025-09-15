if(NOT DEFINED SYSTEM_BITS)
    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        set(SYSTEM_BITS 64)
    elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
        set(SYSTEM_BITS 32)
    endif()
    
    message(STATUS "Detected system pointer size: ${SYSTEM_BITS}bit")
endif()
