#include "unity.h"
#include "unity_fixture.h"

TEST_GROUP_RUNNER(IDENT)
{
  RUN_TEST_CASE(IDENT, TestNormalUppercase);
  RUN_TEST_CASE(IDENT, TestNormalLowerCase);
  RUN_TEST_CASE(IDENT, TestSize);
  RUN_TEST_CASE(IDENT, TestFirstChar);
  RUN_TEST_CASE(IDENT, TestNumberMiddle);
  RUN_TEST_CASE(IDENT, TestSpecialCharFirst);
  RUN_TEST_CASE(IDENT, TestSpecialCharMiddle);
}
