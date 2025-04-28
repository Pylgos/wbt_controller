cmake_minimum_required(VERSION 3.8)
project(webots_controller_vendor)

find_package(ament_cmake REQUIRED)

file(GLOB WEBOTS_CONTROLLER_C_SRC webots/src/controller/c/*.c)
add_library(webots_controller_c SHARED
  ${WEBOTS_CONTROLLER_C_SRC}
)
target_include_directories(webots_controller_c
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/webots/include/controller/c>
    $<INSTALL_INTERFACE:include/c>
)
target_include_directories(webots_controller_c
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/stb_image/include
)
target_compile_definitions(webots_controller_c
  PRIVATE
  -DLIBCONTROLLER_VERSION="R2025a"
)

file(GLOB WEBOTS_CONTROLLER_CPP_SRC webots/src/controller/cpp/*.cpp)
add_library(webots_controller_cpp SHARED
  ${WEBOTS_CONTROLLER_CPP_SRC}
)
target_link_libraries(webots_controller_cpp PUBLIC
  webots_controller_c
)
target_include_directories(webots_controller_cpp
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/webots/include/controller/cpp>
    $<INSTALL_INTERFACE:include/cpp>
)

ament_export_targets(webots_controller_vendorTargets HAS_LIBRARY_TARGET)

install(
  DIRECTORY webots/include/controller/c/
  DESTINATION include/c
)

install(
  DIRECTORY webots/include/controller/cpp/
  DESTINATION include/cpp
)

install(
  TARGETS webots_controller_c TARGETS webots_controller_cpp
  EXPORT webots_controller_c EXPORT webots_controller_cpp
  EXPORT webots_controller_vendorTargets
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  RUNTIME DESTINATION bin
)

ament_package()
