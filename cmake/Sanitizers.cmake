include_guard(GLOBAL)

function(apply_sanitizers TARGET_NAME)
  get_target_logical_scope(${TARGET_NAME} SCOPE)

  if(ENABLE_ASAN)
    target_compile_options(${TARGET_NAME} ${SCOPE} -fsanitize=address -fno-omit-frame-pointer)
    target_link_options(${TARGET_NAME} ${SCOPE} -fsanitize=address)
  endif()

  if(ENABLE_UBSAN)
    target_compile_options(${TARGET_NAME} ${SCOPE} -fsanitize=undefined)
    target_link_options(${TARGET_NAME} ${SCOPE} -fsanitize=undefined)
  endif()

  if(ENABLE_TSAN)
    target_compile_options(${TARGET_NAME} ${SCOPE} -fsanitize=thread)
    target_link_options(${TARGET_NAME} ${SCOPE} -fsanitize=thread)
  endif()

  if(ENABLE_ASAN AND ENABLE_TSAN)
    message(FATAL_ERROR "ASan and TSan cannot be enabled together")
  endif()
endfunction()
