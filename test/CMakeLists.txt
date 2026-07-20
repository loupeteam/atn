# Host unit tests for ATN. Included from the top-level CMakeLists.txt, which
# defines the `atn` library target (and carries the include dirs + defines the
# tests inherit).

project(atn_test CXX)

# Self-contained pass/fail logic test. Returns 0 and prints "Passed" on success,
# throws otherwise. This is the target that runs in CI via ctest.
add_executable(atn_test_main "test_main.cpp")
target_link_libraries(atn_test_main PRIVATE atn)
add_test(NAME atn_test_main COMMAND atn_test_main)
