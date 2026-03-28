cmake_minimum_required(VERSION 3.28...3.30 FATAL_ERROR)

set(PRJ_NAME "engine")
set(PRJ_NAMESPACE "severa")

project(
  ${PRJ_NAME}
  VERSION 0.1.0
  LANGUAGES CXX
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(Options)
include(CompilerCheck)
include(TargetHelpers)
include(StandardFlags)
include(Sanitizers)
include(StaticAnalysis)
include(Dependencies)
include(PackageHelpers)
include(Ccache)

check_compiler_versions()
setup_ccache()

add_subdirectory(source/${PRJ_NAME})

if(BUILD_TESTING)
  enable_testing()
  setup_gtest()
  add_subdirectory(tests)
endif()

if(PROJECT_IS_TOP_LEVEL)
  generate_project_package_config(${PRJ_NAME}Targets)
endif()

if(CMAKE_EXPORT_COMPILE_COMMANDS)
  add_custom_target(
    symlink_compile_commands ALL
    COMMAND ${CMAKE_COMMAND} -E create_symlink "${CMAKE_BINARY_DIR}/compile_commands.json"
            "${CMAKE_SOURCE_DIR}/compile_commands.json"
    COMMENT "Symlinking compile_commands.json to source directory for clangd"
  )
endif()
