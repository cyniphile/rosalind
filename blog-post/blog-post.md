Five Levels of Bioinformatics Programming: Part 1 
=========================================

# Level 1: Python

I've decided I want to make the switch from "data science" (whatever that means amirite?) to bioinformatics. A lot of my data skills will transfer over seamlessly to a new domain, but I've also been trying to learn more about biology by going through a [list of steps I found on LinkedIn](https://www.linkedin.com/pulse/how-learn-bioinformatics-4catalyzers-eric-jonathan-rothberg/) and doing [Rosalind problems](rosalind.info). They are basically [Euler problems](https://projecteuler.net/archives) with a biology focus. I started out solving them in Python, the language I know best.

For example, in the second Rosalind [problem](http://rosalind.info/problems/rna/) we transcribe[^3] DNA to RNA. This is a one-liner in Python:

``` python
# python hand-rolled
def transcribe(dna: str) -> str:
    return ''.join(["U" if char == 'T' else char for char in dna])
```

# Level 2: Rust

I realized these would be a perfect opportunity to try out [Rust](https://www.rust-lang.org/) to see if I can get some nice speed boosts without too much hassle. That's what Rust is supposed to be about. 


### If You Already Know About Rust, Skip This

Rust is a "low-level language with high-level abstractions." It's supposed to be as fast and fine-grained as C, but more "ergonomic" (less code to write because of the said high-level abstractions) and also much safer from bugs.

Rust is not garbage collected. Instead, the compiler helps you manually manage memory and so requires you, the programmer, to write some extra bookkeeping annotations about which functions are using which variables ("ownership", "borrowing", and "lifetimes"). I've seen this called "semiautomatic memory management" (as opposed to C/C++ where you have to just know how to manage memory; the compiler doesn't stop you from making mistakes). This is why people often complain about "fighting the compiler" with Rust: it's always pointing out inconsistencies in your variable management (in addition to all the type errors you get from more typical compilers). That said, once something does compile, you should have a memory-safe, robust, and probably very fast program.

There are also other low-level aspects of the language. For example, there is not one `int` type but _eight_, depending if you want the integer to be signed and how many bits you want to represent it with.

The [Rust book](https://doc.rust-lang.org/book/) is a very good resource for learning the language. It has a steep learning curve, but I've also not really done low-level programming before, so a lot of the effort for me was learning _that_. Overall I've found Rust is like bowling with the bumpers: it can be maddening to be always bouncing back and forth down the lane, but eventually I will knock some pins over, vs C++ where I'd immediately be in a gutter of weird silent errors.


## Rust Implementation

The Rust implementation is pretty similar to the Python one (especially since we used Python type hints), except for the `&` borrow notation and the `.collect` we have to explicitly call on the `.chars` iterator (more on iterators in another post).  

``` rust
// rust hand rolled
#[pyfunction]
fn transcribe(dna: &str) -> String {
    dna
        .chars()
        .map(|x| if x == 'T' { 'U' } else { x })
        .collect()
}
```

Additionally, I added the decorator-looking `#[pyfunction]` thing (actually a Rust macro) from the [PyO3 Rust package](https://github.com/PyO3/pyo3) which makes it really easy to use Rust with Python[^7].  You (more or less) just add such a prefix and then call the Rust function from Python like so:

``` python
# calling rust functions from python
import bio_lib_string_rs

dna = "ACTGACTC"
bio_lib_string_rs.transcribe(dna)
```

This way we can test out the practicality of using Rust incrementally to speed up part of a Python project. Since the Rust version is nicely callable from Python, I can easily wrap them in [pytest benchmarks](https://github.com/cyniphile/rosalind/blob/main/tests/test_benchmark.py). For an initial test I used a small DNA file of ~1000 bp for the following result:
![](2021-11-09-17-54-55.png)

Woot. The Rust version is nearly 20x faster[^1], including the overhead of transforming the Python DNA string input to be usable by Rust. If we run a [pure Rust benchmark on the same data](https://github.com/cyniphile/rosalind/blob/04885c9644e1cff2287a43dce94763e80f482c39/bio-lib-string-rs/src/lib.rs#L195) (no Python involved) it jumps to 50x faster.

## More Thorough Performance Comparisons

Now some of you Pythonistas might be foaming at the mouth and swearing at your screen right now because the way I implemented `transcribe` wasn't very Pythonic. I hand-rolled the following function:

 ``` python
# python hand-rolled 
def transcribe(dna: str) -> str:
    return ''.join(["U" if char == 'T' else char for char in dna])
```

when I could have just used the built-in `.replace` function:

``` python
# python built-in
def transcribe_builtin(dna: str) -> str:
    return dna.replace("T", "U")
```

Sure, Rust is a lot faster if we compare apples-to-apples implementations of the same algorithm, but it's not quite fair in this case because you'd never actually use that such an algo in Python, or Rust (which also has a built-in `.replace`). So let's also [benchmark the built-ins](https://github.com/cyniphile/rosalind/blob/main/tests/test_benchmark.py) as well: 

``` rust
// rust built-in
#[pyfunction]
fn transcribe_builtin(dna: &str) -> String {
    dna.replace("T", "U")
}
```

And also the Python numpy package built-in:


``` python
# numpy 
import numpy as np

def transcribe_np(dna: str) -> str:
    return str(np.char.replace(dna, "T", "U"))  # type: ignore
```
I also set up some [separate benchmarks](https://github.com/cyniphile/rosalind/blob/f8f0c3b89a34f269cdbce05e74fed93c198ace35/bio-lib-string-rs/src/lib.rs#L213) of the Rust functions called directly in Rust, no Python of PyO3 involved. 
![](2021-11-09-18-22-16.png)

The python built-in `.replace` function is actually the fastest by far, over twice as fast as my Rust function and the Rust `.replace` built-in. 

This sort of makes sense since Python's `.replace` is actually just [a highly optimized C function](https://github.com/python/cpython/blob/5f9247e36a0213b0dcfd43533db5cf6570895cfd/Objects/stringlib/transmogrify.h#L678), though it's still surprising that the Rust `.replace` built-in is a lot slower[^2]. 

The same ranking holds true over different sizes of data, though numpy seems to eventually overcome some fixed initialization overhead. 
![](2021-11-09-17-27-36.png)
This chart (and subsequent such charts) were made using a [`perfplot`](https://github.com/nschloe/perfplot) Python script, so the pure Rust performance couldn't be included.

## Actually Speeding Something Up

Let's try out a more custom task that isn't already a Python built-in. This next Rosalind problem is to [identify reverse palindromes](http://rosalind.info/problems/revp/) in a DNA sequence.[^6] 

``` python
@dataclass
class PalindromeLocation:
    start_index: int
    length: int


def find_reverse_palindromes(seq: str) -> List[PalindromeLocation]:
    min_len = 4
    max_len = 12
    locations = []
    for i in range(0, len(seq) - min_len + 1):
        for length in range(min_len, max_len + 1, 2):
            if i + length > len(seq):
                continue
            test_seq = seq[i:(i + length)]
            if is_reverse_palindrome(test_seq):
                locations.append(
                    PalindromeLocation(start_index=i + 1, length=length)
                )
    return locations


def is_reverse_palindrome(seq: str) -> bool:
    return seq == reverse_complement_dna(seq)


def reverse_complement_dna(dna_seq: str) -> str:
    return ''.join([dna_base_complement(b) for b in dna_seq[::-1]])


def dna_base_complement(base: str) -> str: 
    if base == "A":
        return "T"
    elif base == "T":
        return "A"
    elif base == "G":
        return "C"
    elif base == "C":
        return "G"
    else:
        raise Exception("Non-DNA base \"{}\" found.".format(base))
```

The Rust implementation is very similar but uses a slightly more functional style (`.fold` instead of an outer `for` loop) [^5].  

``` rust
#[pyclass]
pub struct PalindromeLocation {
    #[pyo3(get, set)]
    pub start_index: usize,
    #[pyo3(get, set)]
    pub length: usize,
}

#[pyfunction]
pub fn find_reverse_palindromes(seq: &str) -> Vec<PalindromeLocation> {
    let min_len = 4;
    let max_len = 12;
    seq.chars()
        .take(seq.len() - min_len + 1)
        .enumerate()
        .fold(Vec::new(), |mut acc, (i, _)| {
            for length in (min_len..(max_len + 1)).step_by(2) {
                if i + length > seq.len() {
                    continue;
                }
                let test_seq = &seq[i..(i + length)];
                if is_reverse_palindrome(test_seq) {
                    acc.push(PalindromeLocation {
                        start_index: i + 1,
                        length,
                    });
                }
            }
            acc
        })
}

pub fn is_reverse_palindrome(seq: &str) -> bool {
    seq == reverse_complement_dna(seq)
}

pub fn reverse_complement_dna(dna_seq: &str) -> String {
    dna_seq.chars().rev().map(dna_base_complement).collect()
}

pub fn dna_base_complement(base: char) -> char {
    match base {
        'A' => 'T',
        'T' => 'A',
        'G' => 'C',
        'C' => 'G',
        _ => panic!("Non-DNA base \"{}\" found.", base),
    }
}
```

And I also added a small Python wrapper to map the Rust `PalindromeLocation` `struct` to the Python `dataclass`, which adds even more overhead[^7].

``` python
def find_reverse_palindromes_rs(seq: str) -> List[PalindromeLocation]:
    ps = bio_lib_string_rs.find_reverse_palindromes(seq)
    return [ 
        PalindromeLocation(
            start_index=p.start_index,
            length=p.length
        )
        for p in ps 
    ]
```

I also made a Python implementation that uses Numpy arrays [(see the repo for details)](https://github.com/cyniphile/rosalind/blob/04885c9644e1cff2287a43dce94763e80f482c39/bio-lib-py/bio_lib_py/bio_lib.py#L82).

How do things pan out this time?

![](output.png)

Rust is about 15x faster than base Python, even with all the conversion overhead! Was it worth the effort? I'd say "yes!". Writing these relatively simple Rust functions is frankly pretty easy (Rust definitely gets harder! But that's for a later post). And the PyO3 crate makes it pretty straightforward to incrementally add the extra "Rust thrust" (new viral hashtag?) when you need it. This wasn't without papercuts or headscratchers (as detailed below in the notes), but if this was for heavily reused code (perhaps part of some data pipeline), I think it's well worth the price.[^4] 

# Notes 

[^3]: DNA sequence data are stored as the coding strand (not the template strand), so "transcription" really does mean "replace T with U" not "find the RNA complement strand"

[^7]: For a more detailed tutorial [see this guide](https://depth-first.com/articles/2020/08/10/python-extensions-in-pure-rust-with-pyo3/). Installing and using PyO3 had some papercuts: 
	- I needed to add [a mysterious config](https://stackoverflow.com/questions/28124221/error-linking-with-cc-failed-exit-code-1) to get it to compile on Mac: 
	- The VSCode [rust-analyzer](https://marketplace.visualstudio.com/items?itemName=matklad.rust-analyzer) has a bug where it [shows](https://github.com/rust-analyzer/rust-analyzer/issues/6716) fake [errors](https://stackoverflow.com/questions/65223576/what-does-the-rust-analyzer-error-could-not-resolve-macro-crateformat-args) in PyO3 macros.  
	-  With PyO3 installed, my project began to show some of Rust's infamous slow compile times (it went from a couple of seconds ~22s).

[^1]: It's important to use the super-optimized (and slow compiling) `--release` flag here, otherwise Rust compiles using the default fast-compiling/slow-performing "debug" settings. Check out the performance difference for `transcribe`![](2021-11-09-12-46-33.png)

[^2]: Perhaps this is because CPython is compiled with gcc, [which can sometimes emit faster instructions than Rust's LLVM-based compiler](https://news.ycombinator.com/item?id=20944403). Or perhaps something else; I didn't look into it too closely.
 <!-- [@Jgavris](https://github.com/jgavris) pointed out the Rust replace is copy-based while Python does an inplace. Using this Rust lib [could help](https://docs.rs/ascii/1.0.0/ascii/index.html)   -->

[^7]: We could define the Python dataclass [purely in Rust](https://depth-first.com/articles/2020/08/10/python-extensions-in-pure-rust-with-pyo3/), but I wanted to simulate the effect of adding Rust to an existing Python project, where maybe you don't want to move a class definition to Rust. 

[^6]: Yes, I know, this is not the best algorithm. That's not the point. The point is to compare the same algo in Rust and Python. Side note: I wanted to try out Python 3.10's new [pattern matching](https://www.python.org/dev/peps/pep-0636/), but I could not install some of my dependencies (SciPy) and it still seems unstable, so I had to go back to 3.9.

[^5]: This was the first time I ran into not-so-nice problems with PyO3. I started with a Rust implementation [nearly identical to the Python one](https://github.com/cyniphile/rosalind/blob/04885c9644e1cff2287a43dce94763e80f482c39/bio-lib-string-rs/src/lib.rs#L139) but I ran into a weird GIL deadlock when benchmarking with `perfplot` (which apparently does some multithreaded stuff). I managed to resolve this by not having any `mut` or borrowed variables in the function body, but this was a quick hack fix. I have not yet gone deep on the [GIL and mutability](https://pyo3.rs/v0.15.0/types.html?highlight=gil#gil-lifetimes-mutability-and-python-object-types) w.r.t. PyO3.

[^4]: What about pypy? I didn't try it because it still just [don't seem ready.](https://scikit-learn.org/stable/faq.html#do-you-support-pypy) 

