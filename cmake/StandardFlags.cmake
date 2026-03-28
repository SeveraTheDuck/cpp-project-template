include_guard(GLOBAL)
include(CheckIPOSupported)

function(apply_standard_settings TARGET_NAME)
  get_target_logical_scope(${TARGET_NAME} SCOPE)

  if(NOT CMAKE_CXX_STANDARD)
    set(CMAKE_CXX_STANDARD 23)
  endif()

  target_compile_features(${TARGET_NAME} ${SCOPE} "cxx_std_${CMAKE_CXX_STANDARD}")

  # Warnings
  target_compile_options(
    ${TARGET_NAME}
    ${SCOPE}
    $<$<CXX_COMPILER_ID:Clang,AppleClang,GNU>:
    -Wall
    -Wextra
    -Wpedantic
    -Wconversion
    -Wshadow
    -fstack-protector-strong
    $<$<CONFIG:Release>:-D_FORTIFY_SOURCE=2>
    >
    $<$<CXX_COMPILER_ID:MSVC>:/W4
    /permissive->
  )

  # LTO (IPO)
  if(ENABLE_LTO)
    check_ipo_supported(RESULT ipo_supported)
    if(ipo_supported)
      set_target_properties(${TARGET_NAME} PROPERTIES INTERPROCEDURAL_OPTIMIZATION ON)
    endif()
  endif()
endfunction()
