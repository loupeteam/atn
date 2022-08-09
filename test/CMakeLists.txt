# version 3.11 or later of CMake or needed later for installing GoogleTest
# so let's require it now.
cmake_minimum_required(VERSION 3.11-3.18)

project(atn_test)

# add_compile_options(-fpermissive -Wno-write-strings)
add_definitions(-D_BUR_FORMAT_BRELF)
add_definitions(-D_REPLACE_CONST)
add_definitions(-D_SG4)

add_executable(atn_test_main "test_main.cpp")
add_executable(atn_test_machine "machineTest.cpp")

target_link_libraries(atn_test_main PUBLIC atn)
target_link_libraries(atn_test_machine PUBLIC atn)
