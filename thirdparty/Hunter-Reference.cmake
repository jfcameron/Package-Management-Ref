# © 2017 Joseph Cameron - All Rights Reserved
# Project: Hello Travis CI
# Created on 2017-12-7.

find_path(HUNTER-REFERENCE_INCLUDE_DIR ...)

if((NOT HUNTER-REFERENCE_INCLUDE_DIR) OR (NOT EXISTS ${HUNTER-REFERENCE_INCLUDE_DIR}))
    message(STATUS "Initializing dependency \"Hunter-Reference\"")

    execute_process(
        COMMAND git submodule update --init -- thirdparty/Hunter-Reference
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )

    set(HUNTER-REFERENCE_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Hunter-Reference/include
        CACHE PATH "hunter-reference include directory" FORCE
    )

    set(HUNTER-REFERENCE_LIBRARIES ${CMAKE_CURRENT_SOURCE_DIR}/Hunter-Reference/build/libHunter-Reference.a;glfw
        CACHE PATH "hunter-reference output libraries" FORCE
    )

    add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/Hunter-Reference")
else()
    message(STATUS "dependency \"Hunter-Reference\" already initialized. Skipping")
endif()
