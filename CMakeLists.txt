cmake_minimum_required(VERSION 3.14)
project(sst-cmake)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/modules")
list(REMOVE_DUPLICATES CMAKE_MODULE_PATH)

if(NOT PROJECT_IS_TOP_LEVEL)
    set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" PARENT_SCOPE)
endif()

if(PROJECT_IS_TOP_LEVEL)
    add_subdirectory("examples")
endif()
