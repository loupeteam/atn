# Off-target (host) build of the ATN library for unit testing.
#
# ATN normally builds inside Automation Studio for the PLC target. This CMake
# project compiles the same C/C++ sources on a PC so the logic can be exercised
# by the unit tests in test/ (locally and in CI). The B&R runtime headers that
# the sources expect (<bur/plctypes.h>, atn.h, stringext.h, vartools.h) are
# supplied off-target by test/host-shim/.
#
# Configure as 32-bit to match the SG4 data model, e.g. with MSVC:
#     cmake -S . -B build -A Win32
#     cmake --build build
#     ctest --test-dir build --output-on-failure
cmake_minimum_required(VERSION 3.11)

project(atn CXX)

file(GLOB SRC
    "src/Ar/ATN/*.cpp"
    "src/Ar/ATN/*.c"
)

add_library(${PROJECT_NAME} STATIC ${SRC})

# host-shim first so #include "atn.h" / <bur/plctypes.h> resolve to the stubs;
# includes/ provides Director.h, Action.h, State.h, atnApi.h. Both are PUBLIC so
# the test targets inherit them.
target_include_directories(${PROJECT_NAME} PUBLIC
    "${CMAKE_CURRENT_SOURCE_DIR}/test/host-shim"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/Ar/ATN/includes"
)

# _REPLACE_CONST is required off-target: it makes atn.h define the length
# constants as macros instead of extern _GLOBAL_CONST symbols that nothing
# provides. _SG4 selects the SG4 include paths (satisfied by the shim stubs).
target_compile_definitions(${PROJECT_NAME} PUBLIC
    _BUR_FORMAT_BRELF
    _REPLACE_CONST
    _SG4
    _NOT_BR
)

target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_11)

if(MSVC)
    # The ATN sources use strcpy/strncpy/memcpy; silence MSVC's _s nagging.
    target_compile_definitions(${PROJECT_NAME} PRIVATE _CRT_SECURE_NO_WARNINGS)
endif()

enable_testing()
add_subdirectory(test)
