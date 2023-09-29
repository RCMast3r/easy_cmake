
macro(make_cmake_package lib ns)

  include(GNUInstallDirs)
  install(TARGETS ${lib}
    EXPORT ${lib}Targets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  )
  
  install(EXPORT ${lib}Targets
        FILE ${lib}Targets.cmake
        NAMESPACE ${ns}::
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${lib}
    )

   include(CMakePackageConfigHelpers)
   configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/${lib}Config.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/${lib}Config.cmake"
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${lib}
    )
    install(FILES
          "${CMAKE_CURRENT_BINARY_DIR}/${lib}Config.cmake"
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${lib}
    )
    install()
endmacro()