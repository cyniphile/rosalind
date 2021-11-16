file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/iter/range.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/alloc/src/string.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/iter/adapters/step_by.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/alloc/src/raw_vec.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/alloc/src/vec/mod.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/slice/index.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/cmp.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/ptr/mod.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/num/uint_macros.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/alloc/src/alloc.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/str/traits.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/str/mod.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/slice/cmp.rs does not exist!
 pub fn find_reverse_palindromes_str(seq: &str) -> Vec<PalindromeLocation> {
 push    rbp
 mov     rbp, rsp
 push    r15
 push    r14
 push    r13
 push    r12
 push    rbx
 sub     rsp, 120
 mov     qword, ptr, [rbp, -, 48], rsi
     mov     rax, qword, ptr, [rip, +, L___unnamed_14]
     mov     qword, ptr, [rbp, -, 80], rax
     mov     qword, ptr, [rbp, -, 72], 0
     mov     qword, ptr, [rbp, -, 64], 0
 if seq.len() < min_len {
 cmp     rdx, 4
 jae     LBB29_8
     mov     qword, ptr, [rdi], rax
     mov     qword, ptr, [rdi, +, 8], 0
     mov     qword, ptr, [rdi, +, 16], 0
     jmp     LBB29_7
LBB29_8:
     mov     r14, rdx
     mov     qword, ptr, [rbp, -, 88], rax
     mov     qword, ptr, [rbp, -, 112], rdi
 for i in 0..(seq.len() - min_len + 1) {
 lea     rax, [rdx, -, 3]
 mov     qword, ptr, [rbp, -, 120], rax
 xor     eax, eax
 mov     qword, ptr, [rbp, -, 96], rax
 xor     ebx, ebx
 jmp     LBB29_9
LBB29_13:
 mov     rbx, qword, ptr, [rbp, -, 104]
     cmp     rbx, qword, ptr, [rbp, -, 120]
     je      LBB29_6
LBB29_9:
     lea     rax, [rbx, +, 1]
     mov     qword, ptr, [rbp, -, 104], rax
     mov     rax, qword, ptr, [rbp, -, 48]
     add     rax, rbx
     mov     qword, ptr, [rbp, -, 56], rax
     mov     r13d, 4
     xor     eax, eax
     mov     qword, ptr, [rbp, -, 128], rbx
     jmp     LBB29_10
LBB29_33:
 if is_reverse_palindrome_str(test_seq) {
 test    r14b, r14b
 mov     r14, rbx
 mov     rbx, qword, ptr, [rbp, -, 128]
 mov     al, 1
 jne     LBB29_34
LBB29_10:
     test    al, 1
     je      LBB29_12
     inc     r13
 for length in (min_len..(max_len + 1)).step_by(2) {
 je      LBB29_13
LBB29_12:
 mov     r15, r13
 cmp     r13, 13
 jae     LBB29_13
 lea     r13, [r15, +, 1]
 if i + length > seq.len() {
 lea     rcx, [r15, +, rbx]
 mov     al, 1
 cmp     rcx, r14
 ja      LBB29_10
     cmp     rcx, rbx
     jb      LBB29_27
     test    rbx, rbx
     je      LBB29_20
     cmp     rbx, r14
     jae     LBB29_18
     mov     rax, qword, ptr, [rbp, -, 56]
     cmp     byte, ptr, [rax], -64
     jge     LBB29_20
     jmp     LBB29_27
LBB29_18:
     jne     LBB29_27
LBB29_20:
     test    rcx, rcx
     je      LBB29_23
     cmp     rcx, r14
     jae     LBB29_22
     mov     rax, qword, ptr, [rbp, -, 48]
     cmp     byte, ptr, [rax, +, rcx], -65
     jg      LBB29_23
     jmp     LBB29_27
LBB29_22:
     jne     LBB29_27
LBB29_23:
 seq == reverse_complement_dna_str(seq)
 lea     rdi, [rbp, -, 152]
 mov     rsi, qword, ptr, [rbp, -, 56]
 mov     rdx, r15
 call    bio_lib_algebraic_rs::reverse_complement_dna_str
 mov     rbx, r14
     cmp     qword, ptr, [rbp, -, 136], r15
     jne     LBB29_25
     mov     r12, qword, ptr, [rbp, -, 152]
     mov     rdi, qword, ptr, [rbp, -, 56]
     mov     rsi, r12
     mov     rdx, r15
     call    _memcmp
     test    eax, eax
     sete    r14b
     mov     rsi, qword, ptr, [rbp, -, 144]
     test    rsi, rsi
     jne     LBB29_31
     jmp     LBB29_33
LBB29_25:
     mov     r12, qword, ptr, [rbp, -, 152]
     xor     r14d, r14d
     mov     rsi, qword, ptr, [rbp, -, 144]
     test    rsi, rsi
     je      LBB29_33
LBB29_31:
     test    r12, r12
     je      LBB29_33
     mov     edx, 1
     mov     rdi, r12
     call    ___rust_dealloc
     jmp     LBB29_33
LBB29_34:
     mov     rsi, qword, ptr, [rbp, -, 96]
     cmp     rsi, qword, ptr, [rbp, -, 72]
     jne     LBB29_35
     lea     rdi, [rbp, -, 80]
     call    alloc::raw_vec::RawVec<T,A>::reserve::do_reserve_and_handle
     mov     rcx, qword, ptr, [rbp, -, 80]
     mov     rdx, qword, ptr, [rbp, -, 64]
     jmp     LBB29_38
LBB29_35:
     mov     rdx, rsi
     mov     rcx, qword, ptr, [rbp, -, 88]
LBB29_38:
     mov     rax, rdx
     shl     rax, 4
     mov     rsi, qword, ptr, [rbp, -, 104]
     mov     qword, ptr, [rcx, +, rax], rsi
     mov     qword, ptr, [rbp, -, 88], rcx
     mov     qword, ptr, [rcx, +, rax, +, 8], r15
     inc     rdx
     mov     rax, rdx
     mov     qword, ptr, [rbp, -, 96], rdx
     mov     qword, ptr, [rbp, -, 64], rdx
     mov     al, 1
     jmp     LBB29_10
LBB29_6:
 locations
 mov     rax, qword, ptr, [rbp, -, 64]
 mov     rdi, qword, ptr, [rbp, -, 112]
 mov     qword, ptr, [rdi, +, 16], rax
 mov     rax, qword, ptr, [rbp, -, 80]
 mov     rcx, qword, ptr, [rbp, -, 72]
 mov     qword, ptr, [rdi, +, 8], rcx
 mov     qword, ptr, [rdi], rax
LBB29_7:
 }
 mov     rax, rdi
 add     rsp, 120
 pop     rbx
 pop     r12
 pop     r13
 pop     r14
 pop     r15
 pop     rbp
 ret
LBB29_27:
     lea     r8, [rip, +, l___unnamed_15]
     mov     rdi, qword, ptr, [rbp, -, 48]
     mov     rsi, r14
     mov     rdx, rbx
     call    core::str::slice_error_fail
     ud2
LBB29_3:
     jmp     LBB29_5
LBB29_2:
     jmp     LBB29_5
LBB29_4:
LBB29_5:
     mov     rbx, rax
     lea     rdi, [rbp, -, 80]
 }
 call    core::ptr::drop_in_place<alloc::vec::Vec<bio_lib_algebraic_rs::PalindromeLocation>>
 mov     rdi, rbx
 call    __Unwind_Resume
