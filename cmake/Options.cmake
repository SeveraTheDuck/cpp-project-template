include_guard(GLOBAL)

option(ENABLE_ASAN "Enable Address Sanitizer" OFF)
option(ENABLE_UBSAN "Enable Undefined Behavior Sanitizer" OFF)
option(ENABLE_TSAN "Enable Thread Sanitizer" OFF)
option(ENABLE_LTO "Enable Link Time Optimization" OFF)
option(BUILD_TESTING "Build unit tests" ON)