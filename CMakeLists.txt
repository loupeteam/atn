# Off-target (host) build of the ATN library for unit testing.
#
# ATN normally builds inside Automation Studio for the PLC target. This CMake
# project compiles the same C/C++ sources on a PC so the logic can be exercised
# by the unit tests in test/ (locally and in CI). The B&R runtime headers that
# the sources expect (<bur/plctypes.h>, atn.h, stringext.h, vartools.h) are
# supplied off-target by test/host-shim/.
#
# Linux / gcc (matches B&R's compiler family; used by CI):
#     cmake -S . -B build && cmake --build build
#     ctest --test-dir build --output-on-failure
# Windows / MSVC (LLP64, so build 32-bit -> unsigned long == pointer, as on SG4):
#     cmake -S . -B build -A Win32 && cmake --build build --config Debug
#     ctest --test-dir build -C Debug --output-on-failure
cmake_minimum_required(VERSION 3.11)

project(atn CXX)

file(GLOB SRC
    "src/Ar/ATN/*.cpp"
    "src/Ar/ATN/*.c"
)

add_library(${PROJECT_NAME} STATIC ${SRC})

# Off-target stand-in for the LogThat dependency (captures log writes for tests).
target_sources(${PROJECT_NAME} PRIVATE "test/host-shim/logthat_stub.cpp")

# host-shim first so #include "atn.h" / <bur/plctypes.h> resolve to the stubs;
# includes/ provides Director.h, State.h, PLCOpen.h, atnApi.h. Both are PUBLIC so
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
else()
    # Falling off the end of a non-void function is undefined behavior; gcc/clang
    # only warn by default (as B&R's target build does), which let a couple of
    # these slip through. Make that class of bug a hard error.
    target_compile_options(${PROJECT_NAME} PRIVATE -Werror=return-type)
endif()

enable_testing()
add_subdirectory(test)
