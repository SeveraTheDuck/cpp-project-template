include_guard(GLOBAL)
include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

function(generate_project_package_config EXPORT_NAME)
  write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion
  )

  configure_package_config_file(
    "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/ProjectConfig.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
  )

  install(
    EXPORT ${EXPORT_NAME}
    FILE ${PROJECT_NAME}Targets.cmake
    NAMESPACE ${PRJ_NAMESPACE}::
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
  )

  install(FILES "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
                "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
          DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
  )
endfunction()
