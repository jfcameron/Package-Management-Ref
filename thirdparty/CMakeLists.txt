# © 2017 Joseph Cameron - All Rights Reserved
# Project: Hello Travis CI
# Created on 2017-12-7.

#[[!
    Loads the cmake package with the given name.
    Assumptions: 
        - the dependency is a submodule in the current directory named $JFC_DEPENDENCY_NAME
        - the dependency's project name is the same as its repo name ($JFC_DEPENDENCY_NAME)
        - the dependency's *Config.cmake/*-config.cmake file is at the root of the submodule
]]
function(jfc_add_cmake_dependency JFC_DEPENDENCY_NAME)
    #find_package(${JFC_DEPENDENCY_NAME})

    if((NOT ${JFC_DEPENDENCY_NAME}_INCLUDE_DIR) OR (NOT EXISTS ${${JFC_DEPENDENCY_NAME}_INCLUDE_DIR}))
        message(STATUS "[Library loader] Initializing dependency \"${JFC_DEPENDENCY_NAME}\"")

        execute_process(COMMAND git submodule update --init -- ${CMAKE_CURRENT_SOURCE_DIR}/${JFC_DEPENDENCY_NAME}
                        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
        
        add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/${JFC_DEPENDENCY_NAME}")
    
        set(${JFC_DEPENDENCY_NAME}_DIR ${CMAKE_CURRENT_SOURCE_DIR}/${JFC_DEPENDENCY_NAME} 
            CACHE PATH "location of ${JFC_DEPENDENCY_NAME} Config file" FORCE)
    else()
        message(STATUS "[Library loader] dependency \"${JFC_DEPENDENCY_NAME}\" already initialized. Skipping")
    endif()

    find_package(${JFC_DEPENDENCY_NAME} REQUIRED)
endfunction()

# ==================================  Dependency list ================================== 

jfc_add_cmake_dependency("Hunter-Reference")
