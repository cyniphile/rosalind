Five levels of bioinformatics programming
pypy?

# python
- using the Pyo3 crate https://github.com/PyO3/pyo3 to call all our rust code from python. This way we can 1) gather all the profiling tests into one python script and 2) test out the (possibly?) practical use case of using rust to speed up part of a python project.
- Installing and using pyo3, maturin papercuts using their instructions
	- needed to add a mysterious config to get it to compile on mac: https://stackoverflow.com/questions/28124221/error-linking-with-cc-failed-exit-code-1
	- Vscode rust-analyzer has some bugs that show errors in the py03 macros that aren't real: https://github.com/rust-analyzer/rust-analyzer/issues/6716, https://stackoverflow.com/questions/65223576/what-does-the-rust-analyzer-error-could-not-resolve-macro-crateformat-args
- test post-processing interop with python. For example, if all the iters are using enums and stuff, will that work with python?
- ?is transcribe right?
- ?numpy?
- ?dask?
- read, transcribe, translate
- different rust sub projects?

# rust strings
- what is rust
- writing this first code was slow because I didn't know rust at all
- The rust book is very good. Rust is not garbage collected, but the compiler helps you manually manage memory, and as such requires you to write some extra annotations on variables ownership, which functions are using them and how long they are supposed to live (borrowing and lifetimes). I've seen it called "semiautomatic memory management" (as opposed to C/C++ where you have to just know and remember how to manage memory). There are also other low level aspects (usize, int32, etc vs int, strings very complicated). While some of this is rust, part of it is systems programming. Rust is like bowling with the bumpers: can be maddening to be alwys bouncing back and forth down the lane but eventually I will knock some pins over, vs C++ where i'd immideately be in a gutter of weird memory issues.
- With py03 installed the project become pretty slow to compile ~22s (a known problem with rust).
- First test rust is about 30% _slower_! Maybe there's just some overhead, so let's make the file really big? Nope still 
- Try rust only: 
```
   Compiling bio-lib-string-rs v0.1.0 (/Users/luke/projects/rosalind/bio-lib-string-rs)
    Finished bench [optimized] target(s) in 1.40s
     Running unittests (target/release/deps/bio_lib_string_rs-4a9d6b8de2b2b531)


running 1 test
test tests::bench_trascribe_dna_to_rna ... bench: 716,362,489 ns/iter (+/- 66,738,448)

test tests::bench_convert_native ... bench: 1,024,635,980 ns/iter (+/- 29,729,272)

test result: ok. 0 passed; 0 failed; 0 ignored; 2 measured; 4 filtered out;

```
Hmm, according to this benchmark, traslating the entire file takes only ~.72 seconds. There must be something slow about translating the data back and forth to Python. Howver benchmarked Rust code is optimized (as you can see from the compiler message), while the imported lib is debug (less highly optimized).

It's especially not worth it when you realize `convertDNAtoRNA` is basically just syntactic sugar for python's built-in `replace` https://github.com/python/cpython/blob/main/Objects/stringlib/replace.h which is written in C and highly optimized. (plus cpython is compiled with gcc, which can be faster than LLVM https://news.ycombinator.com/item?id=20944403). The rust built-in replace is actually quite slow, even slower than my manual one? The point is comparing apples to apples, not having the best algo (not right now). Yeah, don't try to optimize the standard lib(?builtins). 

This is a lesson: only optimize operations more complex per unit data than the translation process of moving the data back and forth between python and rust. In this case, it's not worth it: the incremental overhead of moving the data to rust and back is less than the incremental saving of doing the processing in rust. 

To test this out, lets make the operation we want to do more complex. Still o(n) but with a bigger constant. We'll now do this rosalind problem. Something >o(n) would be interesting, but I'm interested in constant time opererations as well, because one of the slower things in python is doing a custom .apply to a series of data (which is usually some constant time operation given a fixed window of data) and maybe rust would be useful for writing a fast drop in?

not implenenting in rust is actually pretty similar to python in this case, only the mandator types in the function defs but the rest are inferred. (Note I wanted to try out pythons 3.10s nice new pattern matching, but I could not install some of my dependencies and it seems still unstable, so I had to go back to 3.9) We use structs in rust and dataclasses in python, because using tuples + comments telling you what the two numbers inside are is obviously worse.


Using python is 8ms, python calling rust is 6ms (20% faster) and using rust by itself is ... 0.5 ms!

```
running 1 test
test tests::bench_find_reverse_palindomes ... bench:     559,390 ns/iter (+/- 19,835)

test result: ok. 0 passed; 0 failed; 0 ignored; 1 measured; 6 filtered out; finished in 5.24s


running 1 test
test tests::bench_find_reverse_palindomes_large ... bench:  53,767,386 ns/iter (+/- 2,758,363)

test result: ok. 0 passed; 0 failed; 0 ignored; 1 measured; 7 filtered out; finished in 16.28s
```

Note I didn't use rust structs because I didn't want to spend the time figuring out how to pass them to python via pyo3, a downgrade in terms of code structure.






# rust enums
- https://www.youtube.com/watch?v=FnBPECrSC7o&ab_channel=JaneStreet
- enum are a bit tricky because they aren't types
- Amino acid matching example (completeness and adding novel AAs, vs string code)

# rust iters
- They are fast, and should be even faster when chaining (like spark)
- https://github.com/mike-barber/rust-zero-cost-abstractions/blob/main/README.md
- The rust compiler error messages are often very good. First they tend to nicely try to point out where you went wrong by highlighing the code (I think python has finally decided this is a good idea too new pep?). Second, they tend to anticipate why every errors occured and offer possible solutions. For example mispelling. That said it's not always nice. For example chaining methods sometiems led to me attempting to return a local variable. 
- I stuggled a lot to get them to work. I basically ran into every problem listed in this post. https://depth-first.com/articles/2020/06/22/returning-rust-iterators/ With the sort of root cause that ?statically dispatched traits? can't quite be used like types (and I wanted to avoid dynamic dispatch if possible (though maybe it wasn't necessary?))
- ? is there an example optimiztion that might happen?
- at least demonstrate the power of `take` etc.

# rust par_iter
https://medium.com/@mjschillawski/quick-and-easy-parallelization-in-python-32cb9027e490


https://crates.io/crates/multiversion