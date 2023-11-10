# version 3.11 or later of CMake or needed later for installing GoogleTest
# so let's require it now.
cmake_minimum_required(VERSION 3.11-3.18)

project(atn)

file(GLOB SRC
"src/Ar/ATN/*.cpp"
"src/Ar/ATN/*.c"
)

include_directories( ./src/Ar/ATN/includes )


# add_compile_options(-fpermissive -Wno-write-strings)
add_definitions(-D_BUR_FORMAT_BRELF)
add_definitions(-D_REPLACE_CONST)
add_definitions(-D_SG4)
add_definitions(-D_NOT_BR)
add_library(${PROJECT_NAME} ${SRC})
link_libraries(${PROJECT_NAME} StringExt)

set_property(TARGET atn PROPERTY CXX_STANDARD 11)

add_subdirectory (test)
