include_guard(GLOBAL)

function(get_target_logical_scope TARGET_NAME OUT_VAR)
  get_target_property(target_type ${TARGET_NAME} TYPE)
  if(target_type STREQUAL "INTERFACE_LIBRARY")
    set(${OUT_VAR}
        "INTERFACE"
        PARENT_SCOPE
    )
  else()
    set(${OUT_VAR}
        "PRIVATE"
        PARENT_SCOPE
    )
  endif()
endfunction()

function(target_collect_sources TARGET_NAME BASE_DIR EXCLUDE_LIST)
  get_target_property(target_type ${TARGET_NAME} TYPE)

  if(NOT target_type STREQUAL "INTERFACE_LIBRARY")
    file(GLOB_RECURSE cpp_files CONFIGURE_DEPENDS "${BASE_DIR}/*.cpp")
    foreach(ex_file IN LISTS EXCLUDE_LIST)
      list(FILTER cpp_files EXCLUDE REGEX ".*${ex_file}$")
    endforeach()
    target_sources(${TARGET_NAME} PRIVATE ${cpp_files})
  endif()
endfunction()

function(target_collect_headers TARGET_NAME BASE_DIR)
  get_target_property(target_type ${TARGET_NAME} TYPE)

  if(target_type STREQUAL "INTERFACE_LIBRARY")
    set(SCOPE "INTERFACE")
  elseif(target_type STREQUAL "EXECUTABLE")
    set(SCOPE "PRIVATE")
  else()
    set(SCOPE "PUBLIC")
  endif()

  file(GLOB_RECURSE hpp_files CONFIGURE_DEPENDS "${BASE_DIR}/*.hpp")
  if(hpp_files)
    get_filename_component(INC_BASE "${BASE_DIR}" DIRECTORY)

    target_sources(
      ${TARGET_NAME}
      ${SCOPE}
      FILE_SET
      HEADERS
      BASE_DIRS
      "${INC_BASE}"
      FILES
      ${hpp_files}
    )
  endif()
endfunction()

function(target_standard_setup TARGET_NAME)
  set(options)
  set(one_value_args)
  set(multi_value_args EXCLUDE_BASENAMES)
  cmake_parse_arguments(ARG "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  target_collect_sources(${TARGET_NAME} "${CMAKE_CURRENT_SOURCE_DIR}" "${ARG_EXCLUDE_BASENAMES}")
  target_collect_headers(${TARGET_NAME} "${CMAKE_CURRENT_SOURCE_DIR}")

  apply_standard_settings(${TARGET_NAME})
  apply_sanitizers(${TARGET_NAME})
  apply_static_analysis(${TARGET_NAME})
endfunction()
