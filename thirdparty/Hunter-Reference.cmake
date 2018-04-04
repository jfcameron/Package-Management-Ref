# © 2017 Joseph Cameron - All Rights Reserved
# Project: Hello Travis CI
# Created on 2017-12-7.
#${CURL_LIBRARIES}

find_path(HUNTER-REFERENCE_INCLUDE_DIR ...)

if((NOT HUNTER-REFERENCE_INCLUDE_DIR) OR (NOT EXISTS ${HUNTER-REFERENCE_INCLUDE_DIR}))
    message(STATUS "Initializing dependency \"Hunter-Reference\"")

    execute_process(
        COMMAND git submodule update --init -- Hunter-Reference
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )

    set(HUNTER-REFERENCE_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/Hunter-Reference/include"
        CACHE PATH "hunter-reference include directory" FORCE
    )

else()
    message(STATUS "dependency \"Hunter-Reference\" already initialized. Skipping")
endif()

#[[# step 0
find_path(FOO_INCLUDE_DIR ...)

if((NOT FOO_INCLUDE_DIR) OR (NOT EXISTS ${FOO_INCLUDE_DIR})
    # we couldn't find the header files for FOO or they don't exist
    message("Unable to find foo")

    # we have a submodule setup for foo, assume it is under external/foo
    # now we need to clone this submodule
    execute_process(COMMAND git submodule update --init -- external/foo
                    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

    # set FOO_INCLUDE_DIR properly
    set(FOO_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/external/foo/path/to/include
        CACHE PATH "foo include directory")

    # also install it
    install(DIRECTORY ${FOO_INCLUDE_DIR}/foo DESTINATION ${some_dest})

    # for convenience setup a target
    add_library(foo INTERFACE)
    target_include_directories(foo INTERFACE
                               $<BUILD_INTERFACE:${FOO_INCLUDE_DIR}>
                               $<INSTALL_INTERFACE:${some_dest}>)

    # need to export target as well
    install(TARGETS foo EXPORT my_export_set DESTINATION ${some_dest})
else()
    # see above, setup target as well
endif()
]]
