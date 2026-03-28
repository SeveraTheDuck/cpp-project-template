set(TGT_TEST "${PRJ_NAME}_tests")

add_executable(${TGT_TEST})

target_standard_setup(${TGT_TEST})

target_link_libraries(${TGT_TEST} PRIVATE ${PRJ_NAMESPACE}::${PRJ_NAME} GTest::gtest_main)

include(GoogleTest)
gtest_discover_tests(${TGT_TEST})
