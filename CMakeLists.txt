# © 2017 Joseph Cameron - All Rights Reserved
# Project: Hello Travis CI
# Created on 2017-12-7.

cmake_minimum_required(VERSION 3.2 FATAL_ERROR)
enable_testing()

set(JFC_CXX_COMPILER_FEATURE_REQUIREMENTS PRIVATE
    cxx_variadic_templates
    cxx_nullptr
    cxx_lambdas
)

if (NOT JFC_TARGET_PLATFORM)
    set(JFC_TARGET_PLATFORM ${CMAKE_HOST_SYSTEM_NAME})
endif()

add_subdirectory(thirdparty)
add_subdirectory(tests)
add_subdirectory(src)

# ================== GENERATED HEADER ==================

string(RANDOM LENGTH 15 JFC_RANDOM_128BITS)
string(TOUPPER ${JFC_TARGET_PLATFORM} JFC_TARGET_PLATFORM)

execute_process(COMMAND git rev-parse HEAD WORKING_DIRECTORY ${PROJECT_SOURCE_DIR} OUTPUT_VARIABLE JFC_GIT_COMMIT_HASH OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND git log -1 --format=%cd --date=local HEAD WORKING_DIRECTORY ${PROJECT_SOURCE_DIR} OUTPUT_VARIABLE JFC_GIT_COMMIT_DATE OUTPUT_STRIP_TRAILING_WHITESPACE)

configure_file(${CMAKE_SOURCE_DIR}/src/cmake.h.in ${CMAKE_SOURCE_DIR}/src/cmake.h @ONLY)
