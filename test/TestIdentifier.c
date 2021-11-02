#include "unity.h"
#include "identifier.h"
#include "unity_fixture.h"


TEST_GROUP(IDENT);

TEST_SETUP(IDENT)
{
}

TEST_TEAR_DOWN(IDENT)
{
}
// Array menor que 6, Inciar por letra, não pode ter caracteres especiais

TEST(IDENT, TestNormalUppercase) {
    char string[] = "ABCDE";
    TEST_ASSERT_EQUAL(0, identifier(string));
}

TEST(IDENT, TestNormalLowerCase) {
    char string[] = "abcde";
    TEST_ASSERT_EQUAL(0, identifier(string));
}

TEST(IDENT, TestSize) {
    char string[] = "qwertyuiopasdfghjklzxcvbnm";
    TEST_ASSERT_EQUAL(1, identifier(string));
}

TEST(IDENT, TestFirstChar) {
    char string[] = "1BCD";
    TEST_ASSERT_EQUAL(1, identifier(string));
}

TEST(IDENT, TestNumberMiddle) {
    char string[] = "AB2CD";
    TEST_ASSERT_EQUAL(0, identifier(string));
}

TEST(IDENT, TestSpecialCharFirst) {
    char string[] = "!BCD";
    TEST_ASSERT_EQUAL(1, identifier(string));
}

TEST(IDENT, TestSpecialCharMiddle) {
    char string[] = "AB!CD";
    TEST_ASSERT_EQUAL(1, identifier(string));
}

TEST(IDENT, TestNull) {
    char string[] = "";
    TEST_ASSERT_EQUAL(1, identifier(string));
}
