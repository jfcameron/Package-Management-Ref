# © 2017 Joseph Cameron - All Rights Reserved
# Project: Hello Travis CI
# Created on 2017-12-7.

#[[!
    Loads a library project from jfcameron github account.
    Requires the project follows my personal layout.
]]
function(jfc_load_personal_dependency JFC_DEPENDENCY_NAME JFC_DEPENDENCY_LIBRARIES)
    if((NOT ${JFC_DEPENDENCY_NAME}_INCLUDE_DIR) OR (NOT EXISTS ${${JFC_DEPENDENCY_NAME}_INCLUDE_DIR}))
        message(STATUS "[Library loader] Package \"${JFC_DEPENDENCY_NAME}\" could not be found on the system. Initializing dependency from a submodule.")

        execute_process(COMMAND git submodule update --init -- ${CMAKE_CURRENT_SOURCE_DIR}/${JFC_DEPENDENCY_NAME}
                        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
        
        add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/${JFC_DEPENDENCY_NAME}/")

        set(${JFC_DEPENDENCY_NAME}_INCLUDE_DIR ${CMAKE_CURRENT_LIST_DIR}/${JFC_DEPENDENCY_NAME}/include
            CACHE PATH "${JFC_DEPENDENCY_NAME} include directory" FORCE)

        set(${JFC_DEPENDENCY_NAME}_LIBRARIES ${JFC_DEPENDENCY_LIBRARIES}
            CACHE PATH "${JFC_DEPENDENCY_NAME} output libraries" FORCE)
    else()
        message(STATUS "[Library loader] dependency \"${JFC_DEPENDENCY_NAME}\" already initialized. Skipping")
    endif()
endfunction()

jfc_load_personal_dependency("Hunter-Reference"
    "${CMAKE_CURRENT_LIST_DIR}/Hunter-Reference/build/libHunter-Reference.a;glfw"
)

#[[######### OLD NEW METHOD : PROVIDE OVERRIDABLE SOLUTION USING FIND_PACKAGE

if((NOT HUNTER-REFERENCE_INCLUDE_DIR) OR (NOT EXISTS ${HUNTER-REFERENCE_INCLUDE_DIR}))
    message(STATUS "Initializing dependency \"Hunter-Reference\"")
    
    set(hunter-reference_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Hunter-Reference 
        CACHE PATH "location of hunter-reference Config file" FORCE)

    execute_process(COMMAND git submodule update --init -- thirdparty/Hunter-Reference
                    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})

    add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/Hunter-Reference")
else()
    message(STATUS "dependency \"Hunter-Reference\" already initialized. Skipping")
endif()

find_package(hunter-reference)
]]
#[[ ######### OLD METHOD : PUTS ONUS ON USER TO SET CORRECT PATHS ##############

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
endif() ]]
