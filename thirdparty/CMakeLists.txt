# © 2017 Joseph Cameron - All Rights Reserved
# Project: Hello Travis CI
# Created on 2017-12-7.

#[[!
    Loads the cmake package with the given name find_package, if fail: use submodule
]]
function(jfc_dependency JFC_DEPENDENCY_NAME JFC_PATH_TO_DEPENDENCY_ROOT_CMAKELIST JFC_PATH_TO_INCLUDE_DIRECTORY JFC_DEPENDENCY_LIBRARIES)
    find_package(${JFC_DEPENDENCY_NAME} QUIET)

    if((NOT ${JFC_DEPENDENCY_NAME}_INCLUDE_DIR) OR (NOT EXISTS ${${JFC_DEPENDENCY_NAME}_INCLUDE_DIR}))
        message(STATUS "[Library loader] Initializing dependency \"${JFC_DEPENDENCY_NAME}\"")

        execute_process(COMMAND git submodule update --init -- ${CMAKE_CURRENT_SOURCE_DIR}/${JFC_DEPENDENCY_NAME}
                        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
        
        add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/${JFC_DEPENDENCY_NAME}/${JFC_PATH_TO_DEPENDENCY_ROOT_CMAKELIST}")

        set(Hunter-Reference_INCLUDE_DIR ${CMAKE_CURRENT_LIST_DIR}/${JFC_DEPENDENCY_NAME}/${JFC_PATH_TO_INCLUDE_DIRECTORY}
            CACHE PATH "Hunter-Reference include directory" FORCE)

        set(Hunter-Reference_LIBRARIES ${JFC_DEPENDENCY_LIBRARIES}
            CACHE PATH "Hunter-Reference output libraries" FORCE)
    else()
        message(STATUS "[Library loader] dependency \"${JFC_DEPENDENCY_NAME}\" already initialized. Skipping")
    endif()
endfunction()

# ==================================  Dependency list ================================== 

jfc_dependency("Hunter-Reference" "." "include" 
    "${CMAKE_CURRENT_LIST_DIR}/Hunter-Reference/build/libHunter-Reference.a;glfw"
)

#find_package("curl" REQUIRED)
#-DOPENSSL_ROOT_DIR=/usr/local/opt/openssl \
#-DOPENSSL_LIBRARIES=/usr/local/opt/openssl/lib \
