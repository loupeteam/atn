# version 3.11 or later of CMake or needed later for installing GoogleTest
# so let's require it now.
cmake_minimum_required(VERSION 3.11-3.18)

project(atn)

file(GLOB SRC
"*.cpp"
"*.c"
)

# add_compile_options(-fpermissive -Wno-write-strings)
add_definitions(-D_BUR_FORMAT_BRELF)
add_definitions(-D_REPLACE_CONST)

add_library(${PROJECT_NAME} ${SRC})
