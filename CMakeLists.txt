cmake_minimum_required(VERSION 3.8)
project(wbt_controller)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(ament_cmake REQUIRED)

file(GLOB wbt_controller_C_SRC webots/src/controller/c/*.c)
add_library(wbt_controller_c SHARED
  ${wbt_controller_C_SRC}
)
target_include_directories(wbt_controller_c
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/webots/include/controller/c>
    $<INSTALL_INTERFACE:include/c>
)
target_include_directories(wbt_controller_c
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/stb_image/include
    ${CMAKE_CURRENT_SOURCE_DIR}/webots/include
)
target_compile_definitions(wbt_controller_c
  PRIVATE
  -DLIBCONTROLLER_VERSION="R2025a"
)

file(GLOB wbt_controller_CPP_SRC webots/src/controller/cpp/*.cpp)
add_library(wbt_controller_cpp SHARED
  ${wbt_controller_CPP_SRC}
)
target_link_libraries(wbt_controller_cpp PUBLIC
  wbt_controller_c
)
target_include_directories(wbt_controller_cpp
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/webots/include/controller/cpp>
    $<INSTALL_INTERFACE:include/cpp>
)

ament_export_targets(wbt_controller_vendorTargets HAS_LIBRARY_TARGET)

install(
  DIRECTORY webots/include/controller/c/
  DESTINATION include/c
)

install(
  DIRECTORY webots/include/controller/cpp/
  DESTINATION include/cpp
)

install(
  TARGETS wbt_controller_c TARGETS wbt_controller_cpp
  EXPORT wbt_controller_c EXPORT wbt_controller_cpp
  EXPORT wbt_controller_vendorTargets
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  RUNTIME DESTINATION bin
)

ament_package()
