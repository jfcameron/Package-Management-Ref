#/bin/usr/env bash

# ===========================
# USER DEFINED README SECTION
# ===========================
SUPPORTED_PLATFORM_LIST=(
    MacOS
    Win64
    Ubuntu
)

PREVIEW_IMAGE_LIST=(
    #EarlyRender.png
)

README=$(cat << README
## Description
Demo of package management in C++, using two separate strategies: Hunter for hunter supported libraries and Cmake + Git for others.
A crossplatform project that creates a window and draws a 2d demo on it. Implementation depends on a personal library (abstraction on glfw). This in turn depends on a number of third party libraries (glfw, glew, platform specific libs).
hunter takes care of GLFW and its platform specific requirements. CMake/Git take care of my personal example library.

### Required Tools
* bash
* git
* cmake
* doxygen

README
)

# ==============
# IMPLEMENTATION
# ==============
GenerateReadme()
{
    GeneratePlatformsBadge()
    {
        local output="![](https://img.shields.io/badge/platforms-"

        for platform in $*; do 
            output+="%20${platform}%20"

            if [ "${platform}" != "${@: -1}" ]; then
                output+="|"
            fi
        done

        echo "${output}-lightgrey.svg)"
    }

    GeneratePreviewImages()
    {
        local output=""

        for ImageURL in $*; do 
            output+="<img src=\"http://jfcameron.github.io/Github/GDK/${ImageURL}\" width=\"100%\">"
        done

        echo "${output}"
    }

    # ========================
    # AUTOMATED HEADER SECTION
    # ========================
    local PROJECT_NAME="$(git config --get remote.origin.url | sed -e "s/^https:\/\///" -e "s@.*/@@" -e "s/\..*//")"
    local RELATIVE_PATH_OF_THIS_SCRIPT=$(echo ${PROJECT_NAME}$(echo $(pwd)/${0#"./"} | sed -e "s@.*${PROJECT_NAME}@@"))

    local TRAVIS_CI_BADGE="![](https://travis-ci.org/jfcameron/${PROJECT_NAME}.svg?branch=master)"
    local APPVEYOR_BADGE="![](https://ci.appveyor.com/api/projects/status/github/jfcameron/${PROJECT_NAME})"
    local COVERALLS_BADGE="![](https://coveralls.io/repos/github/jfcameron/${PROJECT_NAME}/badge.svg?branch=master)"

    local TRAVIS_CI_PROJECT_LINK="https://travis-ci.org/jfcameron/${PROJECT_NAME}"
    local APPVEYOR_PROJECT_LINK="https://ci.appveyor.com/project/jfcameron/${PROJECT_NAME}"

    local PLATFORMS_BADGE=$(GeneratePlatformsBadge ${SUPPORTED_PLATFORM_LIST[@]})
    local PREVIEW_IMAGES=$(GeneratePreviewImages ${PREVIEW_IMAGE_LIST[@]})

    cat << OUTPUT > ../README.md
<!--- WARN --->
<!--- This file is automatically generated by ${RELATIVE_PATH_OF_THIS_SCRIPT}. Do not edit directly! --->
<!--- WARN --->
# ${PROJECT_NAME}
${PREVIEW_IMAGES}

## CI Information:
${PLATFORMS_BADGE} ${COVERALLS_BADGE}

| VM OS | Compiler | Status | Logs | Builds |
| --- | --- | --- | --- | --- |
| Ubuntu | GNU | ${TRAVIS_CI_BADGE} | ${TRAVIS_CI_PROJECT_LINK} | [Linux](https://jfcameron.github.io/${PROJECT_NAME}/build/linux.zip) |
| macOS | clang | ${TRAVIS_CI_BADGE} | ${TRAVIS_CI_PROJECT_LINK} | [Macos](https://jfcameron.github.io/${PROJECT_NAME}/build/osx.zip) |
| Win64 | MSVC | ${APPVEYOR_BADGE} | ${APPVEYOR_PROJECT_LINK} | [Win64](https://jfcameron.github.io/${PROJECT_NAME}/build/win64.zip) |

| Service | URL |
| --- | --- |
| Documentation | https://jfcameron.github.io/${PROJECT_NAME} |
| Coverage | https://coveralls.io/github/jfcameron/${PROJECT_NAME} |

${README}
<!--- WARN --->
<!--- This file is automatically generated by ${RELATIVE_PATH_OF_THIS_SCRIPT}. Do not edit directly! --->
<!--- WARN --->
OUTPUT
    }

GenerateReadme
