file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/iter/traits/iterator.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/slice/iter/macros.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/alloc/src/vec/mod.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/alloc/src/raw_vec.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/str/iter.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/ptr/mut_ptr.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/core/src/str/validations.rs does not exist!
file /rustc/00d5e42e776da900049fe19087bc9b0057ec70cd/library/alloc/src/string.rs does not exist!
 pub fn transcribe_str(dna_seq: &str) -> String {
 push    rbp
 mov     rbp, rsp
 push    r15
 push    r14
 push    r12
 push    rbx
 mov     r15, rdx
 mov     rbx, rsi
 mov     r14, rdi
     mov     rax, qword, ptr, [rip, +, L___unnamed_9]
     mov     qword, ptr, [rdi, +, 16], 0
     mov     qword, ptr, [rdi, +, 8], 0
     mov     qword, ptr, [rdi], rax
     add     rdx, 3
     cmp     rdx, 4
     jb      LBB28_2
     shr     rdx, 2
     mov     rdi, r14
     xor     esi, esi
     call    alloc::raw_vec::RawVec<T,A>::reserve::do_reserve_and_handle
LBB28_2:
     test    r15, r15
     je      LBB28_23
 add     r15, rbx
 mov     r12d, 85
LBB28_4:
     lea     rax, [rbx, +, 1]
     movzx   esi, byte, ptr, [rbx]
     test    sil, sil
     js      LBB28_6
     mov     rbx, rax
     jmp     LBB28_21
LBB28_6:
     cmp     rax, r15
     je      LBB28_7
     movzx   eax, byte, ptr, [rbx, +, 1]
     add     rbx, 2
     and     eax, 63
     mov     ecx, esi
     and     ecx, 31
     cmp     sil, -33
     jbe     LBB28_10
LBB28_12:
     cmp     rbx, r15
     je      LBB28_13
     movzx   edx, byte, ptr, [rbx]
     inc     rbx
     and     edx, 63
     shl     eax, 6
     or      eax, edx
     cmp     sil, -16
     jb      LBB28_16
LBB28_17:
     cmp     rbx, r15
     je      LBB28_18
     movzx   edx, byte, ptr, [rbx]
     inc     rbx
     and     edx, 63
     jmp     LBB28_20
LBB28_7:
     xor     eax, eax
     mov     rbx, r15
     mov     ecx, esi
     and     ecx, 31
     cmp     sil, -33
     ja      LBB28_12
LBB28_10:
     shl     ecx, 6
     jmp     LBB28_11
LBB28_13:
     xor     edx, edx
     mov     rbx, r15
     shl     eax, 6
     or      eax, edx
     cmp     sil, -16
     jae     LBB28_17
LBB28_16:
     shl     ecx, 12
LBB28_11:
     or      eax, ecx
     mov     esi, eax
     jmp     LBB28_21
LBB28_18:
     xor     edx, edx
     mov     rbx, r15
LBB28_20:
     and     ecx, 7
     shl     ecx, 18
     shl     eax, 6
     or      eax, ecx
     or      eax, edx
     mov     esi, eax
     cmp     eax, 1114112
     je      LBB28_23
LBB28_21:
 .map(|x| if x == 'T' { 'U' } else { x })
 cmp     esi, 84
 .map(|x| if x == 'T' { 'U' } else { x })
 cmove   esi, r12d
     mov     rdi, r14
     call    alloc::string::String::push
     cmp     rbx, r15
     jne     LBB28_4
LBB28_23:
 }
 mov     rax, r14
 pop     rbx
 pop     r12
 pop     r14
 pop     r15
 pop     rbp
 ret
LBB28_25:
 jmp     LBB28_26
LBB28_24:
LBB28_26:
 mov     rbx, rax
     mov     rdi, r14
     call    core::ptr::drop_in_place<alloc::string::String>
     mov     rdi, rbx
     call    __Unwind_Resume
