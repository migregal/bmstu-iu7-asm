#include "funcs.h"

size_t asmstrlen(const char *str)
{
    size_t len = 0;
    const char *str_copy = str;

    __asm__(
        ".intel_syntax noprefix\n"
        "mov rcx, 0xffffffffffffffff\n"
        "mov al, 0\n"
        "mov rdi, %1\n"
        "repne scasb\n"
        "mov rax, 0xffffffffffffffff\n"
        "dec rax\n"
        "sub rax, rcx\n"
        "mov %0, rax\n"
        : "=r"(len)
        : "r"(str_copy)
        : "%rax", "%rcx", "%rdi", "%al");

    return len;
}
