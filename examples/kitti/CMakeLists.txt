cmake_minimum_required(VERSION 3.16)
project(volf_kitti)
# set cxx standard
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)

# map imported configs
set(CMAKE_MAP_IMPORTED_CONFIG_RELWITHDEBINFO RELWITHDEBINFO RELEASE)
set(CMAKE_MAP_IMPORTED_CONFIG_MINSIZEREL MINSIZEREL RELEASE)

# use folders in ides which support it
set_property(GLOBAL PROPERTY USE_FOLDERS ON)


find_package(OpenCV REQUIRED CONFIG)

add_executable(${PROJECT_NAME}
    ${PROJECT_NAME}.cpp
    kitti_reader.h
    kitti_reader.cpp
)
set_target_properties(${PROJECT_NAME} PROPERTIES
    DEBUG_POSTFIX _d
    RELWITHDEBINFO_POSTFIX _rd
    MINSIZEREL_POSTFIX _mr
    FOLDER examples
)

target_link_libraries(${PROJECT_NAME} PRIVATE
    ${OpenCV_LIBRARIES}
)

install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION bin)

