file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/alloc/src/vec/mod.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/ptr/mod.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/alloc/src/alloc.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/alloc/src/vec/set_len_on_drop.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/alloc/src/raw_vec.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/ptr/mut_ptr.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/iter/traits/iterator.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/slice/iter/macros.rs does not exist!
 pub fn transcribe(seq: &DNASlice) -> RNA {
 push    rbp
 mov     rbp, rsp
 push    r15
 push    r14
 push    r12
 push    rbx
 mov     r15, rdx
 mov     r12, rsi
 mov     r14, rdi
     test    rdx, rdx
     je      LBB27_1
     mov     esi, 1
     mov     rdi, r15
     call    ___rust_alloc
     test    rax, rax
     jne     LBB27_3
     mov     esi, 1
     mov     rdi, r15
     call    alloc::alloc::handle_alloc_error
LBB27_1:
     mov     eax, 1
LBB27_3:
     mov     qword, ptr, [r14], rax
     mov     qword, ptr, [r14, +, 8], r15
     mov     qword, ptr, [r14, +, 16], 0
     test    r15, r15
     je      LBB27_9
     lea     rdi, [r15, -, 1]
     mov     rsi, r15
     mov     rcx, r12
     and     rsi, 7
     je      LBB27_6
LBB27_5:
     movzx   edx, byte, ptr, [rcx]
     inc     rcx
     mov     byte, ptr, [rax], dl
     inc     rax
     dec     rsi
     jne     LBB27_5
LBB27_6:
     cmp     rdi, 7
     jb      LBB27_9
     add     r12, r15
     xor     edx, edx
LBB27_8:
     movzx   ebx, byte, ptr, [rcx, +, rdx]
     mov     byte, ptr, [rax, +, rdx], bl
     movzx   ebx, byte, ptr, [rcx, +, rdx, +, 1]
     mov     byte, ptr, [rax, +, rdx, +, 1], bl
     movzx   ebx, byte, ptr, [rcx, +, rdx, +, 2]
     mov     byte, ptr, [rax, +, rdx, +, 2], bl
     movzx   ebx, byte, ptr, [rcx, +, rdx, +, 3]
     mov     byte, ptr, [rax, +, rdx, +, 3], bl
     movzx   ebx, byte, ptr, [rcx, +, rdx, +, 4]
     mov     byte, ptr, [rax, +, rdx, +, 4], bl
     movzx   ebx, byte, ptr, [rcx, +, rdx, +, 5]
     mov     byte, ptr, [rax, +, rdx, +, 5], bl
     movzx   ebx, byte, ptr, [rcx, +, rdx, +, 6]
     mov     byte, ptr, [rax, +, rdx, +, 6], bl
     movzx   ebx, byte, ptr, [rcx, +, rdx, +, 7]
     mov     byte, ptr, [rax, +, rdx, +, 7], bl
     lea     rsi, [rcx, +, rdx, +, 8]
     add     rdx, 8
     cmp     rsi, r12
     jne     LBB27_8
LBB27_9:
     mov     qword, ptr, [r14, +, 16], r15
 }
 mov     rax, r14
 pop     rbx
 pop     r12
 pop     r14
 pop     r15
 pop     rbp
 ret
