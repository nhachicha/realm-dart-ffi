cmake_minimum_required(VERSION 3.0)

project(realm-dart)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED on)
set(CMAKE_CXX_EXTENSIONS off)
add_compile_options(-Wall -DREALM_HAVE_CONFIG)
add_compile_options("$<$<CONFIG:DEBUG>:-DREALM_DEBUG>")

add_subdirectory(external/object-store)
include_directories(external/object-store/external/json)

add_library(realm-dart SHARED
  database.cpp
  wrapper.cpp
)
target_link_libraries(realm-dart realm-object-store)
