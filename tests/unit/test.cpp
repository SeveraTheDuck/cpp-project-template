#include <engine/hello/hello.hpp>

#include <gtest/gtest.h>

TEST(HelloTest, PrintDoesNotCrash) {
  EXPECT_NO_THROW(hello::Print());
}
