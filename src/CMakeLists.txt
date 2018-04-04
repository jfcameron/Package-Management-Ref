# © 2017 Joseph Cameron - All Rights Reserved
# Project: Hello Travis CI
# Created on 2017-12-7.

project("Hunter-Usage-Reference" VERSION "0.0.1" DESCRIPTION "has no description!")
#hunter_add_package(glfw)
#find_package(glfw3 CONFIG REQUIRED)
add_executable(${PROJECT_NAME}
    ${PROJECT_SOURCE_DIR}/main.cpp
)
target_include_directories(${PROJECT_NAME} PRIVATE
    #${PROJECT_SOURCE_DIR}/include/${PROJECT_NAME}
)
target_link_libraries(${PROJECT_NAME} 
#    glfw
)
set_target_properties(${PROJECT_NAME} PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/build
    LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/build
    RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/build
)
set_target_properties(${PROJECT_NAME} PROPERTIES VERSION ${PROJECT_VERSION})
target_compile_features(${PROJECT_NAME} ${JFC_CXX_COMPILER_FEATURE_REQUIREMENTS})
