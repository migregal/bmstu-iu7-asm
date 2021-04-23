#include "funcs.h"

int asmstrlen(const char *str)
{
    int len = 0;
    const char *str_copy = str;

    __asm__(
        "mov $0xffffffff, %%ecx\n\t"
        "mov $0, %%al\n\t"
        "mov %1, %%rdi\n\t"
        "repne scasb\n\t"
        "mov $0xffffffff, %%eax\n\t"
        "dec %%eax\n\t"
        "sub %%ecx, %%eax\n\t"
        "mov %%eax, %0"
        : "=r"(len)
        : "r"(str_copy)
        : "%eax", "%ecx", "%rdi", "%al");

    return len;
}
