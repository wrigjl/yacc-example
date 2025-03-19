cmake_minimum_required(VERSION 3.22)
project(calc)

set(CMAKE_CXX_STANDARD 20)

# flex must be available.
# - Windows: I installed it with Chocolatey (package: winflexbison3)
# - Linux: apt install bison flex
# - MacOS: ???
find_package(FLEX)
find_package(BISON)
include_directories(${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR})

BISON_TARGET(CalcParser calc-parser.y ${CMAKE_CURRENT_BINARY_DIR}/calc-parser.cpp
        DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/calc-parser.h
        COMPILE_FLAGS -Wcounterexamples
)
FLEX_TARGET(CalcParser calc-lex.l  ${CMAKE_CURRENT_BINARY_DIR}/calc-lex.cpp)

add_executable(calc ${BISON_CalcParser_OUTPUTS} ${FLEX_CalcParser_OUTPUTS})
