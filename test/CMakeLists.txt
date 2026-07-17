# Host unit tests for ATN. Included from the top-level CMakeLists.txt, which
# defines the `atn` library target (and carries the include dirs + defines the
# tests inherit).

project(atn_test CXX)

# Self-contained pass/fail logic test. Returns 0 and prints "Passed" on success,
# throws otherwise. This is the target that runs in CI via ctest.
add_executable(atn_test_main "test_main.cpp")
target_link_libraries(atn_test_main PRIVATE atn)
add_test(NAME atn_test_main COMMAND atn_test_main)

# Interactive multi-threaded demo: it reads commands from stdin in an infinite
# loop and uses POSIX APIs (<unistd.h>, usleep, pthreads), so it is not a CI
# test and does not build with MSVC. Opt in on a POSIX toolchain with
#     cmake -S . -B build -DATN_BUILD_MACHINE_DEMO=ON
option(ATN_BUILD_MACHINE_DEMO "Build the interactive machineTest demo (POSIX toolchains only)" OFF)
if(ATN_BUILD_MACHINE_DEMO)
    file(GLOB machine_src
        "machineTest.cpp"
        "subsystems/*.cpp"
    )
    add_executable(atn_test_machine ${machine_src})
    target_link_libraries(atn_test_machine PRIVATE atn)
    find_package(Threads REQUIRED)
    target_link_libraries(atn_test_machine PRIVATE Threads::Threads)
endif()
