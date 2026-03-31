include_guard(GLOBAL)

find_program(CLANG_TIDY_EXE NAMES clang-tidy)

function(apply_static_analysis TARGET_NAME)
  if(CLANG_TIDY_EXE AND NOT CMAKE_CXX_CLANG_TIDY STREQUAL "OFF")
    set_target_properties(${TARGET_NAME} PROPERTIES CXX_CLANG_TIDY "${CLANG_TIDY_EXE}")
  elseif(CMAKE_CXX_CLANG_TIDY STREQUAL "OFF")
    set_target_properties(${TARGET_NAME} PROPERTIES CXX_CLANG_TIDY "")
  endif()
endfunction()
