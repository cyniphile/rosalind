# Level 3: Using Algebraic Types in Rust

So far we've just represented DNA as strings. This is bad, and here's an example of why. 

``` rust
pub fn dna_base_complement(base: char) -> char {
    match base {
        'A' => 'T',
        'T' => 'A',
        'G' => 'C',
        'C' => 'G',
        // Commented out for now...
        // _ => panic!("Non-DNA base \"{}\" found.", base),
    }
}
```

This little function, given DNA a base, returns the complentary base. Note I had to name it `dna_base_complement`, because it only works with DNA. And if you understand biology, you know the output is also DNA (not RNA, Amino acid). None of this important information is represented in the logic of the program.

This function actually doesn't compile as is. Rust checks pattern matches for exhaustivity, and since and UTF-8 `char` can be passed in to this function, we have to also handle the case where the `base` argument happens to not be "A", "C", "T", or "G". 

![](2021-11-12-08-45-01.png)

So we have to uncomment that last line, which adds a catch-all case. Now if we somehow give a non-DNA character to our function at runtime, the program will panic (and crash if the panic isn't unhandled). Say we accidentally pass in the RNA character "U"...uh oohh! 

Using Rust's type system we can eliminate the possibility of this kind of error. Specifically, we'll make use of _Algebraic Data Types_ or ADTs.

Algebraic data types are simply types composed of other types. There are two main kinds of ADTs: product types and sum types. A product types is an AND group of types: for example tuples, `struct`s, or Python dataclasses. These are pretty obviously useful: sometimes you need to group diversely typed data together into one type, like a `user` type that has a string `name` AND and integer `age`. 

The other common ADT, the sum type, was new to me, but I've realized it's perhaps even more powerful and interesting[^2]. A sum type is an XOR group of different types, so an instance can be one (and only one) type out of a set of given options. In Rust you create sum types with the `enum` keyword. For example:

``` rust
pub enum DnaNucleotide {
    A,
    C,
    G,
    T,
}
```

This defines `DnaNucleotide` as a new type that can be one of four variants[^3] `A`, `C`, `G`, or `T`. Why is this interesting? Well now we can rewrite our `complement` function like so:

``` rust
fn complement(base: DnaNucleotide) -> DnaNucleotide {
    match base {
          DnaNucleotide::A => DnaNucleotide::T,
          DnaNucleotide::T => DnaNucleotide::A,
          DnaNucleotide::C => DnaNucleotide::G,
          DnaNucleotide::G => DnaNucleotide::C,
    }
}
```

Note we droped the `dna_` prefix from the function name: we know we are getting the complement of DNA because the `base` argument is of `DnaNucleotide` type, and so is the return type. It only accepts DNA, not RNA or "!" or "为" or "🌯". And if we try to pass in a character we get a _compile time_ error:

![](2021-11-12-09-45-14.png)

We aren't even allowed to wire up `complement` to anything but its proper DNA input. We also get another neat exhaustivity check at compile time if we forget to handle one of the bases:

![](2021-11-12-09-40-15.png)

This time we don't have to add the catch-all `_ => panic!("Non-DNA base \"{}\" found.", base)` case because the compiler knows there can only be 4 different `DnaNucleotide` variants, and we've properly handled all of them.While this example might seem trivial, what about going from codons to amino acids? If we forget or duplicate one of the 3^4 codons, the compiler tells us!

![](2021-11-12-09-49-10.png)

Note in this example I've made use of both `RnaNucleotide` and `AminoAcid` enums I defined [elsewhere in the code](https://github.com/cyniphile/rosalind/blob/main/bio-lib-algebraic-rs/src/lib.rs). 

This is useful for adapting the software to cutting edge biology work in [alloproteins](https://en.wikipedia.org/wiki/Alloprotein#:~:text=An%20alloprotein%20is%20a%20novel,non%2Dnatural%22%20amino%20acids.&text=The%20usual%20mechanisms%2C%20which%20produce,novel%20proteins%20the%20same%20way.) (proteins with non-natural amino acids) or [artificial base pairs](https://en.wikipedia.org/wiki/D5SICS). All we have to do is add another symbol to the "AminoAcid" or "DnaNucleotide" enums, and then a bunch of exhaustivity checking compiler errors will pop up wherever we now need to handle the new variant type. 

## Speed

Does all this organizational overhead make our code perform less efficiently? Well, theoretically it could actually make it more efficient. Strings (in both Rust and Python), are encoded in UTF-8, which uses a minimum of 8-bits per symbol. DNA has only four symbols, and so only really needs 2 bits. Another consideration is parsing: if our DNA is saved in a file (say [FASTA format](https://en.wikipedia.org/wiki/FASTA_format), which just uses character strings), we have to read the file _and_ parse it into our internal enum representation (which means [more code to write](https://github.com/cyniphile/rosalind/blob/99c3fdb60985b09e9418b308d9bdae4a7657ecbe/bio-lib-algebraic-rs/src/lib.rs#L86) and more computational overhead).

To find out, we'll just benchmark everything using the excellent [criterion](https://github.com/bheisler/criterion.rs) package for Rust. We'll compare the original string `find_reverse_palindromes` function with a reverse palindromes function that operates on a vector of `DnaNucleotide` enums. We'll also time the ADT version including the string -> enum parsing step, and a pre-parsed version where we only time the palindrome searching part. 

![](Schermata-2021-11-16-alle-15.51.28.png)

It looiks like Rust's promise of "zero-cost abstractions" is is a lie, we are actually getting _negative_ cost abstractions here! Even including parsing overhead, the ADT version of our fuction is over twice as fast as the string version. The Rust compiler clearly takes advantage of the `enum` representation to make some key optimizations (though I couldn't really tell what these optimizations actually are when comparing the [emitted assembly and LLVM IR](https://github.com/cyniphile/rosalind/blob/main/bio-lib-algebraic-rs/asm_output/find_reverse_palindromes_adt.asm) of the two functions. I leave that as an excercise for the reader 😃). 

## What About Python?

ADTs sort-of [exist in Python](https://stackoverflow.com/questions/16258553/how-can-i-define-algebraic-data-types-in-python) (while using mypy typechecking) and it even offers hacky-feeling [exhaustivity checks](https://hakibenita.com/python-mypy-exhaustive-checking). However, Enum support is [not quite ready in PyO3](https://github.com/PyO3/pyo3/issues/834), so it's not yet possible to call enum-based Rust functions from Python, which is a decently big negative w.r.t. the goal of incrementally adding Rust speedups only when necessary.

[^2]: [This talk](https://youtu.be/FnBPECrSC7o?t=1867) by Ron Minsky of Jane Street Capital has some really interesting examples of using algebraic data types to write more robust code (using OCaml in the context of securities trading).

[^3]: In Rust, variants of an enum aren't actually types, so you can't so something like `fn f(s: DnaNucleotide::A) {}`. You also can't write polymorphic code with enums like so:
    ```rust
    enum Nucleotide{
        RnaNucleotide,
        DnaNucleotide,
    }

    fn foo(s: Nucleotide) {s.complement();}
    ```
    even if all the variants in the enum implement a `.complement` method. Instead you have to do [some wrapper/destructuring stuff](https://stackoverflow.com/questions/51188460/how-can-i-structure-destructure-an-enum-of-enums) (which is pretty messy) or you have to use [trait bounds](https://doc.rust-lang.org/rust-by-example/generics/bounds.html) like so: 
    ``` rust
    pub trait Nucleotide {
        fn complement(&self) -> Self;
    }

    fn foo(s: impl Nucleotide) {s.complement();}
    ```