cmake_minimum_required(VERSION 3.16)
project (volf)

# set cxx standard
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)

# map imported configs
set(CMAKE_MAP_IMPORTED_CONFIG_RELWITHDEBINFO RELWITHDEBINFO RELEASE)
set(CMAKE_MAP_IMPORTED_CONFIG_MINSIZEREL MINSIZEREL RELEASE)
# hide implemetation details
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)

# use folders in ides which support it
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# include cmake modules
include(CTest)
include(GenerateExportHeader)

# cmake options
option(BUILD_EXAMPLES "Build examples" ON)

if (BUILD_EXAMPLES)
    add_subdirectory(examples/kitti)
endif()

