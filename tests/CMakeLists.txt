# © 2017 Joseph Cameron - All Rights Reserved
# Project: Hello Travis CI
# Created on 2017-12-7.

#[[project("Unit-Tests")
hunter_add_package(Catch)
find_package(Catch2 CONFIG REQUIRED)
add_executable(${PROJECT_NAME}
    ${PROJECT_SOURCE_DIR}/tests/main.cpp
)
target_include_directories(${PROJECT_NAME} PRIVATE
)
target_link_libraries(${PROJECT_NAME} PRIVATE 
    Catch2::Catch
)
target_compile_features(${PROJECT_NAME} ${JFC_CXX_COMPILER_FEATURE_REQUIREMENTS})
add_test(${PROJECT_NAME} ${PROJECT_NAME})]]
