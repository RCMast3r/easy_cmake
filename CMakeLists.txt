cmake_minimum_required(VERSION 3.2)
project(cmake_macros)
include(CMakePackageConfigHelpers)
include(GNUInstallDirs)
set(MY_CMAKE_MODULES_PATH ${CMAKE_INSTALL_LIBDIR}/cmake)

configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmake_macrosConfig.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/cmake_macrosConfig.cmake"
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/cmake_macros
    PATH_VARS MY_CMAKE_MODULES_PATH
)

install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/cmake_macrosConfig.cmake"
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/cmake_macros
)

install(
    FILES
        "cmake/create_package.cmake"
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/
)