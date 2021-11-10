https://docs.google.com/spreadsheets/d/1-lrlYnfcRzlyVbfqHlM74Bpidv4auIxsR-fQR_o-oKo/edit#gid=0

# TODO:
Python Rust capitalized. RNA DNA built-in,comment all code blocks

- do iters seperately
- compare with bio python: https://biopython.org/wiki/Seq
- add rayon NOW just to see how easy it is (can't par replace in python)
- https://python.land/python-concurrency/python-multiprocessing


https://crates.io/crates/multiversion

---------------

Five Levels of Bioinformatics Programming: 1 & 2
=========================================

# Level 1: Python

I've decided I want to make the switch from "data science" (whatever that means amirite?) to bioinformatics. A lot of my data skills will transfer over seamlessly to a new domain, but I've also been trying to learn more about biology by going through a [list of steps I found on LinkedIn](https://www.linkedin.com/pulse/how-learn-bioinformatics-4catalyzers-eric-jonathan-rothberg/) and doing [Rosalind problems](rosalind.info). They are basically [Euler problems](https://projecteuler.net/archives) with a biology focus. I started out solving them in Python, the language I know best.

For example, in the second Rosalind [problem](http://rosalind.info/problems/rna/) we transcribe [^3] DNA to RNA. This is a one liner in Python:

``` python
# python hand rolled
def transcribe_dna_to_rna(s: str) -> str:
    return ''.join(["U" if char == 'T' else char for char in s])
```

# Level 2: Rust

I realized these would be a perfect opportunity to try out [Rust](https://www.rust-lang.org/) to see if I can get some nice speed boosts without too much hassle. That's what Rust is supposed to be about. 


### If You Already Know About Rust, Skip This

Rust is a "low-level language with high-level abstractions". It's supposed to be as fast and fine grained as C, but more "erognomic" (less code to write because of the said high level abstractions) and also much safer from bugs.

Rust is not garbage collected. Instead the compiler helps you manually manage memory, and so requires you, the programmer, to write some extra bookeeping annotations about which functions are using which variables ("ownership", "borrowing", and "lifetimes"). I've seen this called "semiautomatic memory management" (as opposed to C/C++ where you have to just know and remember how to manage memory; the compiler doesn't stop you from making mistakes). This is why people often complain about "fighting the compiler" with Rust because it's always pointing out inconsistencies in your variable management (in addition to all the type errors you get from normal compilers). That said, once something does compile you should have a memory safe, robust, and probably very fast program.

There are also other low level aspects of the language, for example there is not one `int` type but _eight_ depending if you want the integer to be signed and how many bits you want to represent it with.

The [Rust book](https://doc.rust-lang.org/book/) is a very good resource for learning the language. It has a steep learning curve, though I've not really done low-level or systems programming before, so a lot of the effort for me was/is learning _that_. Overall I've found Rust is like bowling with the bumpers: can be maddening to be alwys bouncing back and forth down the lane but eventually I will knock some pins over, vs C++ where i'd immideately be in a gutter of weird memory issues.


## Rust Implementation

The Rust implementation is pretty similar to the Python one (especially since we used Python type hints), except for the `&` borrow notation and the `.collect()` we have to explicity call on the `.chars` iterator (more on iterators in another post).  

``` rust
// rust hand rolled
#[pyfunction]
fn transcribe_dna_to_rna(dna_seq: &str) -> String {
    dna_seq
        .chars()
        .map(|x| if x == 'T' { 'U' } else { x })
        .collect()
}
```

Additionally I added the `#[pyfunction]` line which is a decorator-looking thing (actually a Rust macro) from the [Pyo3 Rust package](https://github.com/PyO3/pyo3) which makes it really easy to use Rust with python.  You more or less just add such a prefix and can then call the Rust function from Python like so:

``` python
# calling rust functions from python
import bio_lib_string_rs

dna = "ACTGACTC"
bio_lib_string_rs.transcribe_dna_to_rna(dna)
```

This way we can test out the practicality of using Rust incrementally to speed up part of a python project. Since the Rust version is nicely callable from python, I can easily wrap them in [pytest benchmarks](https://github.com/cyniphile/rosalind/blob/main/tests/test_benchmark.py). I benchmarked them on a small DNA file of ~1000 bases for the following result:
![](2021-11-09-17-54-55.png)

Woot. The Rust version is nearly 20x faster [^1]. This is including the overhead of transforming the python DNA string input to be usable by Rust. For example if we run a pure Rust profile on the same data (no Python involved) the function runs over 50x faster.

## More Thorough Performance Comparisons

Now some of you pythonistas might be foaming at the mouth and swearing at your screen right now because the way I implemented `transcribe` wasn't pythonic. I hand-rolled the following function:

 ``` python
# python hand-rolled 
def transcribe_dna_to_rna(s: str) -> str:
    return ''.join(["U" if char == 'T' else char for char in s])
```

when I could have just used the built-in `.replace` function:

``` python
# python built-in
def transcribe_dna_to_rna_builtin(s: str) -> str:
    return s.replace("T", "U")
```

Sure, Rust is a lot faster if we compare apples to apples implementations of the same algorithm, but it's not quite fair in this case because you'd never actually use that algo. So let's also profile the Python built-in, and also the Rust built-in:

``` rust
// rust built-in
#[pyfunction]
fn transcribe_dna_to_rna_builtin(dna_seq: &str) -> String {
    dna_seq.replace("T", "U")
}
```

And also the Python numpy package:

``` python
# numpy 
import numpy as np

def transcribe_dna_to_rna_np(s: str) -> str:
    return str(np.char.replace(s, "T", "U"))  # type: ignore
```
I also set up some seperate benchmarks of the Rust functions called directly in Rust, no Python of PyO3 involved. 
![](2021-11-09-18-22-16.png)

The python builtin `.replace` function is actually the fastest by far, over twice as fast as my Rust function and the Rust `.replace` builtin. 

This sort of makes sense since python's `.replace` is actually just [a highly optimized C function](https://github.com/python/cpython/blob/main/Objects/stringlib/replace.h), though it's still surprising that the Rust `.replace` built-in is so slow [^2]. 

The same ranking holds true over different sizes of data, though numpy seems to eventually overcome some fixed initialization overhead. 
![](2021-11-09-17-27-36.png)
This chart (and subsequent such charts) were made using a [`perfplot`](https://github.com/nschloe/perfplot) Python script, so the pure rust performance couldn't be included.

## Actually Speeding Something Up

Let try out a more custom task that isn't a Python built-in. This next Rosalind problem is to [identify reverse palindromes](http://rosalind.info/problems/revp/) in a DNA sequence. 



not implenenting in rust is actually pretty similar to python in this case, only the mandator types in the function defs but the rest are inferred. (Note I wanted to try out pythons 3.10s nice new pattern matching, but I could not install some of my dependencies and it seems still unstable, so I had to go back to 3.9) We use structs in rust and dataclasses in python, because using tuples + comments telling you what the two numbers inside are is obviously worse.

in creating this plot I happened upon a weird GIL error if I used mutable variables or references in conjunction with multithreded python code. Using the function with 

![](output.png)

# Appendix

[^3]: DNA sequence data are stored as the coding strand (not the template strand), so "transcription" really does mean "replace T with U" not "find the RNA complement strand"

[^1]: It's important to use the super-optimized (and slow compiling) `--release` flag here, otherwise Rust compiles using the default fast-compiling/slow-performing "debug" settings. Check out the performance differeance for `transcribe_dna_to_rna`![](2021-11-09-12-46-33.png)

[^2]: Perhaps this is because cpython is compiled with gcc, [which can sometimes emit faster instructions than Rust's LLVM-based compiler.](https://news.ycombinator.com/item?id=20944403). Or perhaps something else; I didn't look into it too closely.

[^4]: pypy: Just not ready https://scikit-learn.org/stable/faq.html#do-you-support-pypy

- Installing and using pyo3, maturin papercuts using their instructions
	- needed to add a mysterious config to get it to compile on mac: https://stackoverflow.com/questions/28124221/error-linking-with-cc-failed-exit-code-1
	- Vscode rust-analyzer has some bugs that show errors in the py03 macros that aren't real: https://github.com/rust-analyzer/rust-analyzer/issues/6716, https://stackoverflow.com/questions/65223576/what-does-the-rust-analyzer-error-could-not-resolve-macro-crateformat-args
- test post-processing interop with python. For example, if all the iters are using enums and stuff, will that work with python?
- ?is transcribe right?
- ?numpy?
- ?dask?
- read, transcribe, translate
- different rust sub projects?

# 
- With py03 installed the project become pretty slow to compile ~22s (a known problem with rust).









# rust enums
- note all the function names have types encoded in them
- https://www.youtube.com/watch?v=FnBPECrSC7o&ab_channel=JaneStreet
- enum are a bit tricky because they aren't types
- Amino acid matching example (completeness and adding novel AAs, vs string code)
- sort of exist in python but without the key piece of support: pattern matching
   https://stackoverflow.com/questions/16258553/how-can-i-define-algebraic-data-types-in-python

# rust iters
- They are fast, and should be even faster when chaining (like spark)
- https://github.com/mike-barber/rust-zero-cost-abstractions/blob/main/README.md
- The rust compiler error messages are often very good. First they tend to nicely try to point out where you went wrong by highlighing the code (I think python has finally decided this is a good idea too new pep?). Second, they tend to anticipate why every errors occured and offer possible solutions. For example mispelling. That said it's not always nice. For example chaining methods sometiems led to me attempting to return a local variable. 
- I stuggled a lot to get them to work. I basically ran into every problem listed in this post. https://depth-first.com/articles/2020/06/22/returning-rust-iterators/ With the sort of root cause that ?statically dispatched traits? can't quite be used like types (and I wanted to avoid dynamic dispatch if possible (though maybe it wasn't necessary?))
- ? is there an example optimiztion that might happen?
- at least demonstrate the power of `take` etc.

# rust par_iter
https://medium.com/@mjschillawski/quick-and-easy-parallelization-in-python-32cb9027e490

