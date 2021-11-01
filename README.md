Bioinformatics problems from http://rosalind.info/ and the https://stepik.org/course/91751/promo contest implemented in Python and Rust.

TODO: turn functions into iterators (i.e. save collect for the last moment.) That way we can chain as many operation together as possible before "finalizing" the complete method chain, at which point the compiler can optimize everything instead of me forcing it to collect each time. 


- At this point it seems like the functions themselves need to implement iterator? Not sure the exact use case so far for actually building an iter. 

Check here for inspo: https://github.com/rust-bio/rust-bio/blob/b6cb8699fb7f16e741a7840f5bcc2d850938a37a/src/alphabets/dna.rs
Also: https://github.com/rust-bio/rust-bio/blob/b6cb8699fb7f16e741a7840f5bcc2d850938a37a/src/alphabets/mod.rs#L359

          something
s - dna <
 


Returning Iterators in Rust

I've been strugging with making functions that return iterators in rust.

I