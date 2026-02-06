/**
 * Cppcheck 测试文件 - 包含 150 个错误
 * 用于测试 Vitis Cppcheck 插件
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// 错误 1-10: 数组越界
void test_array_bounds() {
    int arr[10];
    arr[10] = 1;  // error 1
    arr[15] = 2;  // error 2
    arr[20] = 3;  // error 3
    arr[-1] = 4;  // error 4
    arr[-5] = 5;  // error 5

    char buf[5];
    buf[5] = 'a';  // error 6
    buf[10] = 'b';  // error 7

    int data[100];
    for (int i = 0; i <= 100; i++) {  // error 8
        data[i] = i;  // error 9
    }

    int matrix[10][10];
    matrix[10][5] = 1;  // error 10
}

// 错误 11-20: 内存泄漏
void test_memory_leak() {
    int *p1 = malloc(10);  // error 11 - leak
    int *p2 = malloc(20);  // error 12 - leak
    char *p3 = malloc(30);  // error 13 - leak
    void *p4 = malloc(40);  // error 14 - leak

    int *p5 = malloc(50);
    if (p5) {
        return;  // error 15 - leak
    }

    int *p6 = malloc(60);
    p6 = malloc(70);  // error 16 - leak (original p6 lost)

    int *p7 = malloc(80);
    free(p7);
    p7 = malloc(90);  // error 17 - leak on second alloc

    char *p8 = malloc(100);
    if (1) {
        return;  // error 18 - leak
    }

    int *p9;
    p9 = malloc(110);  // error 19 - leak

    FILE *f = fopen("test.txt", "r");  // error 20 - leak (not closed)
}

// 错误 21-30: 未使用的变量
void test_unused_variables() {
    int unused1 = 1;  // error 21
    int unused2 = 2;  // error 22
    char unused3 = 'a';  // error 23
    float unused4 = 1.5;  // error 24
    double unused5 = 2.5;  // error 25

    int x = 10;
    int unused6 = x + 5;  // error 26
    char unused7 = 'b';  // error 27

    static int unused8 = 100;  // error 28
    const int unused9 = 200;  // error 29
    register int unused10 = 5;  // error 30
}

// 错误 31-40: 空指针解引用
void test_null_pointer() {
    int *p1 = NULL;
    *p1 = 10;  // error 31

    char *p2 = NULL;
    p2[0] = 'a';  // error 32

    int *p3 = NULL;
    int x = *p3;  // error 33

    FILE *f = NULL;
    fclose(f);  // error 34

    int *p4 = NULL;
    p4[5] = 10;  // error 35

    struct { int a; } *s = NULL;
    s->a = 1;  // error 36

    void *p5 = NULL;
    ((int*)p5)[0] = 1;  // error 37

    int *p6 = 0;
    *p6 = 5;  // error 38

    char *p7 = NULL;
    strcpy(p7, "test");  // error 39

    int *p8 = NULL;
    free(p8);  // error 40
}

// 错误 41-50: 缓冲区溢出
void test_buffer_overflow() {
    char src[20] = "This is a long string";
    char dest[10];

    strcpy(dest, src);  // error 41 - overflow
    sprintf(dest, "%s", src);  // error 42 - overflow

    char buf1[5];
    gets(buf1);  // error 43 - dangerous

    char buf2[10];
    strcat(buf2, "very long string");  // error 44 - overflow

    char dst[8];
    char src2[20] = "overflow here";
    memcpy(dst, src2, 20);  // error 45 - overflow

    char arr[10];
    memset(arr, 0, 20);  // error 46 - overflow

    char buf3[5];
    snprintf(buf3, 10, "too long");  // error 47 - potential overflow

    wchar_t wbuf[5];
    wcscpy(wbuf, L"long wide string");  // error 48

    char str1[10];
    char str2[20];
    sprintf(str1, "%s %s", str1, str2);  // error 49 - overlap
    sprintf(str1, "%s", str1);  // error 50 - self-copy
}

// 错误 51-60: 未初始化变量
void test_uninitialized() {
    int a;
    if (a > 0) {  // error 51 - uninitialized
        printf("%d\n", a);
    }

    int b, c;
    b = c + 1;  // error 52 - c uninitialized

    int arr[10];
    int x = arr[5];  // error 53 - arr not initialized

    int *p;
    *p = 10;  // error 54 - p not initialized

    struct { int x; int y; } s;
    printf("%d\n", s.x);  // error 55 - struct not initialized

    int y;
    int z = y * 2;  // error 56 - y uninitialized

    char ch;
    if (ch == 'a') {  // error 57 - uninitialized
    }

    double d;
    printf("%f\n", d);  // error 58

    float f1;
    f1 = f1 + 1.0;  // error 59

    int nums[5];
    int sum = nums[0] + nums[1];  // error 60
}

// 错误 61-70: 资源泄漏
void test_resource_leaks() {
    FILE *f1 = fopen("file1.txt", "w");  // error 61 - leak
    FILE *f2 = fopen("file2.txt", "r");  // error 62 - leak
    FILE *f3 = fopen("file3.txt", "a");  // error 63 - leak

    FILE *f4 = fopen("file4.txt", "r");
    if (f4) {
        return;  // error 64 - leak
    }

    FILE *f5 = fopen("file5.txt", "r");
    f5 = fopen("file6.txt", "r");  // error 65 - leak (f5 lost)

    FILE *f6 = fopen("file7.txt", "r");
    if (f6) {
        int x = 1;
        if (x > 0) {
            return;  // error 66 - leak
        }
    }

    FILE *f7 = fopen("file8.txt", "r");
    if (f7) {
        if (1) {
            return;  // error 67 - leak
        }
        fclose(f7);
    }
}

// 错误 71-80: 除以零
void test_division_by_zero() {
    int x = 0;
    int y = 10 / x;  // error 68

    int a = 0;
    int b = 100;
    int c = b / a;  // error 69

    int d = 0;
    int e = 5 % d;  // error 70

    int f = 0;
    int g = 15;
    int h = g % f;  // error 71

    int i = 0;
    int j = 20 / i;  // error 72

    int k = 0, l = 30;
    int m = l / k;  // error 73
}

// 错误 74-83: 错误的释放操作
void test_invalid_free() {
    int arr[10];
    free(arr);  // error 74 - freeing stack memory

    int x = 10;
    free(&x);  // error 75 - freeing stack memory

    static int y = 5;
    free(&y);  // error 76 - freeing static memory

    char str[] = "test";
    free(str);  // error 77

    int *p = &x;
    free(p);  // error 78

    char *p2 = "string literal";
    free(p2);  // error 79 - freeing string literal

    int data;
    int *p3 = &data;
    free(p3);  // error 80

    double d = 1.5;
    free(&d);  // error 81
}

// 错误 82-91: 死代码
void test_dead_code() {
    int x = 10;
    if (x > 100) {
        printf("Never executed\n");  // error 82 - dead code
    }

    if (0) {
        printf("Also never executed\n");  // error 83 - dead code
        int y = 5;  // error 84 - dead code
    }

    while (0) {
        printf("Infinite no-op\n");  // error 85 - dead code
    }

    if (1) {
        printf("Always executed\n");
    } else {
        printf("Never here\n");  // error 86 - dead code
    }

    for (;;) {
        break;
        printf("After break\n");  // error 87 - dead code
    }

    return;
    printf("After return\n");  // error 88 - dead code
}

// 错误 89-98: 函数指针问题
void test_function_pointer() {
    void (*fp1)() = NULL;
    fp1();  // error 89 - null function pointer

    void (*fp2)(int) = NULL;
    fp2(10);  // error 90

    void (*fp3)() = NULL;
    (*fp3)();  // error 91

    int (*fp4)(int) = NULL;
    int x = fp4(5);  // error 92

    void (*fp5)() = 0;
    fp5();  // error 93
}

// 错误 94-103: 整数溢出
void test_integer_overflow() {
    int max_int = 2147483647;
    int overflow1 = max_int + 1;  // error 94 - overflow
    int overflow2 = max_int + 10;  // error 95 - overflow

    int min_int = -2147483648;
    int overflow3 = min_int - 1;  // error 96 - overflow
    int overflow4 = min_int - 10;  // error 97 - overflow

    unsigned int u_max = 4294967295;
    unsigned int u_overflow1 = u_max + 1;  // error 98 - overflow
    unsigned int u_overflow2 = u_max + 100;  // error 99 - overflow

    long long ll_max = 9223372036854775807;
    long long ll_overflow = ll_max + 1;  // error 100 - overflow
}

// 错误 101-110: 重复释放
void test_double_free() {
    int *p = malloc(10);
    free(p);
    free(p);  // error 101 - double free

    int *p2 = malloc(20);
    free(p2);
    free(p2);  // error 102 - double free
    free(p2);  // error 103 - triple free

    int *p3 = malloc(30);
    free(p3);
    *p3 = 5;  // error 104 - use after free
    free(p3);  // error 105 - double free after use

    int *p4 = malloc(40);
    free(p4);
    int x = *p4;  // error 106 - use after free
}

// 错误 107-116: 符号转换问题
void test_sign_conversion() {
    unsigned int u = 10;
    int i = -5;
    if (u > i) {  // error 107 - sign comparison
        printf("warning\n");
    }

    unsigned char uc = 200;
    signed char sc = -50;
    if (uc > sc) {  // error 108 - sign comparison
    }

    unsigned int u1 = 5;
    int i1 = -10;
    int result = u1 + i1;  // error 109 - sign mixing

    size_t sz = 10;
    int idx = -1;
    if (sz < idx) {  // error 110 - sign comparison
    }

    unsigned long ul = 100;
    long l = -50;
    if (ul > l) {  // error 111 - sign comparison
    }
}

// 错误 112-120: 位移溢出
void test_shift_overflow() {
    int x = 1;
    int y = x << 32;  // error 112 - shift overflow
    int z = x << 40;  // error 113 - shift overflow

    int a = 100;
    int b = a >> 32;  // error 114 - shift overflow

    int c = 50;
    int d = c << 100;  // error 115 - shift overflow

    int e = -1;
    int f = e << 5;  // error 116 - left shift negative

    int g = 10;
    int h = -1;
    int i = g >> h;  // error 117 - negative shift
}

// 错误 118-127: 未使用的函数返回值
void test_unused_return_values() {
    malloc(10);  // error 118 - ignoring return
    fopen("test.txt", "r");  // error 119 - ignoring return

    sprintf(NULL, "test");  // error 120 - ignoring return

    scanf("%d", NULL);  // error 121 - ignoring return

    getchar();  // error 122 - ignoring return

    atoi("123");  // error 123 - ignoring return

    strcpy("test", "test");  // error 124 - ignoring return (wrong usage)
}

// 错误 125-135: 逻辑错误
void test_logic_errors() {
    int x = 10;
    if (x = 20) {  // error 125 - assignment in condition
        printf("assignment in if\n");
    }

    int a = 5;
    while (a = 10) {  // error 126 - assignment in condition
        break;
    }

    int b = 15;
    if (b = 0) {  // error 127 - assignment in condition
    }

    int c = 20;
    for (int i = 0; i = 10; i++) {  // error 128 - assignment in condition
        break;
    }

    int flag = 0;
    if (flag = 1) {  // error 129 - assignment in condition
    }
}

// 错误 130-140: 类型错误
void test_type_errors() {
    int *p = (int *)100;
    *p = 5;  // error 130 - invalid pointer cast

    char *cp = (char *)1.5;  // error 131 - invalid cast

    int x = (int)NULL;  // error 132 - suspicious cast
    x = x + 1;  // suppress unused

    double d = 1.5;
    int *ip = (int *)&d;  // error 133 - incompatible cast

    float f = 2.5;
    int *fp = (int *)&f;  // error 134 - incompatible cast
}

// 错误 135-145: 结构体问题
void test_struct_issues() {
    struct test1 {
        int x;
    };
    struct test1 t1;
    t1.y = 5;  // error 135 - member not exist

    struct {
        int a;
    } s1;
    s1.b = 10;  // error 136 - member not exist

    struct test2 {
        char name[10];
    } *p2 = NULL;
    strcpy(p2->name, "test");  // error 137 - null deref
}

// 递归函数（用于测试无限递归）
int recursive(int n) {
    return recursive(n - 1);  // error 142 - infinite recursion
}

// 错误 143-150: 其他常见错误
void test_other_errors() {
    int arr1[10];
    arr1[10] = 5;  // error 143 - array index out of bounds
    arr1[-1] = 3;  // error 144 - negative index

    char *null_str = NULL;
    strlen(null_str);  // error 145 - null deref

    char *empty = "";
    strcat(empty, "test");  // error 146 - buffer overflow

    int *wild_ptr;
    *wild_ptr = 10;  // error 147 - uninitialized pointer

    char buf[10];
    sprintf(buf, "%d %d %d %d %d %d %d %d %d %d", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10);  // error 148 - potential overflow

    char *leak = malloc(100);  // error 149 - leak
    if (leak) {
        return;  // error 150 - another leak
    }

    void *vptr = NULL;
    *(int *)vptr = 5;  // null deref

    recursive(100);  // call infinite recursion
}

int main() {
    test_array_bounds();
    test_memory_leak();
    test_unused_variables();
    test_null_pointer();
    test_buffer_overflow();
    test_uninitialized();
    test_resource_leaks();
    test_division_by_zero();
    test_invalid_free();
    test_dead_code();
    test_function_pointer();
    test_integer_overflow();
    test_double_free();
    test_sign_conversion();
    test_shift_overflow();
    test_unused_return_values();
    test_logic_errors();
    test_type_errors();
    test_struct_issues();
    test_other_errors();

    return 0;
}
