file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/ptr/mod.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/alloc/src/vec/mod.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/num/uint_macros.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/alloc/src/raw_vec.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/slice/index.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/ptr/mut_ptr.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/ptr/const_ptr.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/slice/iter/macros.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/alloc/src/alloc.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/iter/adapters/step_by.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/iter/adapters/zip.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/iter/range.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/cmp.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/iter/traits/iterator.rs does not exist!
 pub fn find_reverse_palindromes(seq: &DNASlice) -> Vec<PalindromeLocation> {
 push    rbp
 mov     rbp, rsp
 push    r15
 push    r14
 push    r13
 push    r12
 push    rbx
 sub     rsp, 104
     mov     rax, qword, ptr, [rip, +, L___unnamed_14]
     mov     qword, ptr, [rbp, -, 64], rax
     mov     qword, ptr, [rbp, -, 56], 0
     mov     qword, ptr, [rbp, -, 48], 0
 if seq.len() < min_len {
 cmp     rdx, 4
 jae     LBB33_7
     mov     qword, ptr, [rdi], rax
     mov     qword, ptr, [rdi, +, 8], 0
     mov     qword, ptr, [rdi, +, 16], 0
     jmp     LBB33_6
LBB33_7:
     mov     qword, ptr, [rbp, -, 72], rax
     mov     qword, ptr, [rbp, -, 96], rdi
 for i in 0..(seq.len() - min_len + 1) {
 lea     rax, [rdx, -, 3]
 mov     qword, ptr, [rbp, -, 104], rax
 xor     eax, eax
 mov     qword, ptr, [rbp, -, 80], rax
 mov     r15, rsi
 xor     ebx, ebx
 mov     qword, ptr, [rbp, -, 136], rdx
 mov     qword, ptr, [rbp, -, 112], rsi
 jmp     LBB33_8
LBB33_12:
     inc     r15
     mov     rbx, qword, ptr, [rbp, -, 88]
     cmp     rbx, qword, ptr, [rbp, -, 104]
     mov     rsi, qword, ptr, [rbp, -, 112]
     je      LBB33_5
LBB33_8:
     lea     rax, [rbx, +, 1]
     mov     qword, ptr, [rbp, -, 88], rax
     lea     r12, [rsi, +, rbx]
     mov     r13d, 4
     xor     eax, eax
     mov     qword, ptr, [rbp, -, 128], rbx
     mov     qword, ptr, [rbp, -, 120], r12
     jmp     LBB33_9
LBB33_29:
     cmp     r14, r12
     mov     rbx, qword, ptr, [rbp, -, 128]
     mov     r12, qword, ptr, [rbp, -, 120]
     mov     al, 1
 if is_reverse_palindrome(test_seq) {
 je      LBB33_30
LBB33_9:
     test    al, 1
     je      LBB33_11
     inc     r13
 for length in (min_len..(max_len + 1)).step_by(2) {
 je      LBB33_12
LBB33_11:
 mov     r14, r13
 cmp     r13, 13
 jae     LBB33_12
 lea     r13, [r14, +, 1]
 if i + length > seq.len() {
 lea     rsi, [r14, +, rbx]
 mov     al, 1
 cmp     rsi, qword, ptr, [rbp, -, 136]
 ja      LBB33_9
     cmp     rsi, rbx
     jb      LBB33_15
     test    r14, r14
     je      LBB33_18
     mov     esi, 1
     mov     rdi, r14
     call    ___rust_alloc
     test    rax, rax
     je      LBB33_35
     lea     rcx, [r12, +, r14]
 match self {
 lea     rsi, [r14, -, 1]
 mov     rdi, r14
 mov     rdx, rax
 and     rdi, 7
 je      LBB33_22
LBB33_21:
 mov     bl, 3
 sub     bl, byte, ptr, [rcx, -, 1]
     dec     rcx
     mov     byte, ptr, [rdx], bl
     inc     rdx
     dec     rdi
     jne     LBB33_21
LBB33_22:
 cmp     rsi, 7
 jb      LBB33_24
LBB33_23:
 mov     bl, 3
 sub     bl, byte, ptr, [rcx, -, 1]
     mov     byte, ptr, [rdx], bl
 mov     bl, 3
 sub     bl, byte, ptr, [rcx, -, 2]
     mov     byte, ptr, [rdx, +, 1], bl
 mov     bl, 3
 sub     bl, byte, ptr, [rcx, -, 3]
     mov     byte, ptr, [rdx, +, 2], bl
 mov     bl, 3
 sub     bl, byte, ptr, [rcx, -, 4]
     mov     byte, ptr, [rdx, +, 3], bl
 mov     bl, 3
 sub     bl, byte, ptr, [rcx, -, 5]
     mov     byte, ptr, [rdx, +, 4], bl
 mov     bl, 3
 sub     bl, byte, ptr, [rcx, -, 6]
     mov     byte, ptr, [rdx, +, 5], bl
 mov     bl, 3
 sub     bl, byte, ptr, [rcx, -, 7]
     mov     byte, ptr, [rdx, +, 6], bl
 mov     bl, 3
 sub     bl, byte, ptr, [rcx, -, 8]
     add     rcx, -8
     mov     byte, ptr, [rdx, +, 7], bl
     add     rdx, 8
     cmp     rcx, r12
     jne     LBB33_23
     jmp     LBB33_24
LBB33_18:
     mov     eax, 1
LBB33_24:
     xor     ecx, ecx
LBB33_25:
     mov     r12, rcx
     cmp     r14, rcx
     je      LBB33_27
     lea     rcx, [r12, +, 1]
     movzx   edx, byte, ptr, [rax, +, r12]
 #[derive(PartialEq, Eq, Hash, Debug)]
 cmp     dl, byte, ptr, [r15, +, r12]
     je      LBB33_25
LBB33_27:
     test    r14, r14
     je      LBB33_29
     mov     edx, 1
     mov     rdi, rax
     mov     rsi, r14
     call    ___rust_dealloc
     jmp     LBB33_29
LBB33_30:
     mov     rsi, qword, ptr, [rbp, -, 80]
     cmp     rsi, qword, ptr, [rbp, -, 56]
     jne     LBB33_31
     lea     rdi, [rbp, -, 64]
     call    alloc::raw_vec::RawVec<T,A>::reserve::do_reserve_and_handle
     mov     rcx, qword, ptr, [rbp, -, 64]
     mov     rsi, qword, ptr, [rbp, -, 48]
     jmp     LBB33_34
LBB33_31:
     mov     rcx, qword, ptr, [rbp, -, 72]
LBB33_34:
     mov     rax, rsi
     shl     rax, 4
     mov     rdx, qword, ptr, [rbp, -, 88]
     mov     qword, ptr, [rcx, +, rax], rdx
     mov     qword, ptr, [rbp, -, 72], rcx
     mov     qword, ptr, [rcx, +, rax, +, 8], r14
     inc     rsi
     mov     rax, rsi
     mov     qword, ptr, [rbp, -, 80], rsi
     mov     qword, ptr, [rbp, -, 48], rsi
     mov     al, 1
     jmp     LBB33_9
LBB33_5:
 locations
 mov     rax, qword, ptr, [rbp, -, 48]
 mov     rdi, qword, ptr, [rbp, -, 96]
 mov     qword, ptr, [rdi, +, 16], rax
 mov     rax, qword, ptr, [rbp, -, 64]
 mov     rcx, qword, ptr, [rbp, -, 56]
 mov     qword, ptr, [rdi, +, 8], rcx
 mov     qword, ptr, [rdi], rax
LBB33_6:
 }
 mov     rax, rdi
 add     rsp, 104
 pop     rbx
 pop     r12
 pop     r13
 pop     r14
 pop     r15
 pop     rbp
 ret
LBB33_15:
     lea     rdx, [rip, +, l___unnamed_18]
     mov     rdi, rbx
     call    core::slice::index::slice_index_order_fail
     ud2
LBB33_35:
     mov     esi, 1
     mov     rdi, r14
     call    alloc::alloc::handle_alloc_error
LBB33_2:
     jmp     LBB33_4
LBB33_3:
LBB33_4:
     mov     rbx, rax
     lea     rdi, [rbp, -, 64]
 }
 call    core::ptr::drop_in_place<alloc::vec::Vec<bio_lib_algebraic_rs::PalindromeLocation>>
 mov     rdi, rbx
 call    __Unwind_Resume
