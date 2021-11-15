# Level 3: Using Algebraic Types in Rust
Note all the function names have types encoded in them so far, in both python and Rust. For example `trascribe_dna_to_rna`. Shouldn't this be encoded more like `translate(sequence: Dna) -> Rna`?

Using Rust's rich type system we can do this[^1]. Right now we operate on raw strings, which is inefficient because strings in Rust are encoded in Utf-8 (which is variable width, but still inefficient for an alphabet of only four symbols like DNA). And strings, since they are not a special purpose DNA type, don't let us take advantage of the type system. 

For example, the string version of the finding the base complement of some DNA

``` rust
pub fn dna_complement(base: char) -> char {
    match base {
        'A' => 'T',
        'T' => 'A',
        'G' => 'C',
        'C' => 'G',
        _ => panic!("Non-DNA base \"{}\" found.", base),
    }
}
```

Rust pattern matching does exhaustivity checking, so since ANY character can be passed in to this function, we have to also handle the case where the `base` argument is not one of four capital "ACTG". Otherwise if we comment out the last case the compiler will give us an error like so:

![](2021-11-12-08-45-01.png)

Great, so now if we somehow give a bad string to our function at runtime, the program will panic (and crash if the panic isn't unhandled). For example say we accidentally pass in an RNA string with "U"s in it, uh oohh! We want to check for these errors at compile time, and prevent the possibility of even wiring up `dna_base_complement` to something that passes it the wrong type. 

To do this we'll use algebraic data types. Algebraic data types are simply types composed  of other types. There are two main kinds: sum types and product types. A product types is an AND group of types, for example tuple, `struct`, or a Python dataclass. These are pretty obviously useful: sometimes you need to group diversely typed data together into one type, like a `user` that has a string `name` AND and integer `age`. 

The other common algebraic type, sum types, were new to me, but I've realized they are perhaps even more powerful and interesting[^2]. A sum type is an XOR group of different types, so an instance can be one (and only one) of the given options. It's kind of like inheritance, but simpler. In Rust you create sum types with the `enum` keyword. For example:

``` rust
pub enum DnaNucleotide {
    A,
    C,
    G,
    T,
}
```

This defines `DnaNucleotide` as a new type that includes the variants[^3] `A`, `C`, `G`, and `T`. Why is this interesting? Well now we can rewrite our function:

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

First we can drop the `dna_` prefix from the function name: we know we are getting the complement of DNA because the `base` argument is of `DnaNucleotide` type, and so is the return type. It only accept DNA, not RNA or "Hello World!" or "为人民服务" or "🌯🍽️💨😬". If you try to pass a string in you get a compile time error

![](2021-11-12-09-45-14.png)

Also if we forget to handle one of the bases, we get a compile time error to really harness the power of exhaustivity checking. 

![](2021-11-12-09-40-15.png)

This is even more useful when converting from codons to amino acids. If we forget or duplicate one of the 3^4 combinations, the compiler tell us!

![](2021-11-12-09-49-10.png)

Notce here I've made use of both `RnaNucleotide` and `AminoAcid` enums I've defined [elsewhere in the code](https://github.com/cyniphile/rosalind/blob/main/bio-lib-algebraic-rs/src/lib.rs). 

This is useful for adapting the software to cutting edge biology work in [alloproteins](https://en.wikipedia.org/wiki/Alloprotein#:~:text=An%20alloprotein%20is%20a%20novel,non%2Dnatural%22%20amino%20acids.&text=The%20usual%20mechanisms%2C%20which%20produce,novel%20proteins%20the%20same%20way.) (proteins with non-natural amino acids) or [artificial base pairs](https://en.wikipedia.org/wiki/D5SICS). All you have to do is add another symbol to the "AminoAcid" or "DnaNulceotide" enums, and then a bunch of exhaustivity checking compiler errors will pop up wherever you now need to handle the new entity type. 

## Speed

Python has an Enum type, but Enum support is [not quite ready in pyo3](https://github.com/PyO3/pyo3/issues/834)

roughtly twice as fast, plus our code is more robust.    
Used the very nice [Criterion](https://github.com/bheisler/criterion.rs) package for Rust.

This doesn't necessarily come for free. For example we have to read parse any input into this `DnaNucleotide` enum format. I wrote a string parser, which add some overhead. That said, we could also parse this representation from a more efficient format. UTF-8 takes 8 bits, while true bp encoding would only need 2. 

- size of enum in memory

- enum are a bit tricky because they aren't true inheritance types. For example this doesn't work



# 4: Using lazy iterators
- can't use with python: https://depth-first.com/articles/2020/08/10/python-extensions-in-pure-rust-with-pyo3/
- They are fast, and should be even faster when chaining (like spark)
- https://github.com/mike-barber/rust-zero-cost-abstractions/blob/main/README.md
- The rust compiler error messages are often very good. First they tend to nicely try to point out where you went wrong by highlighing the code (I think python has finally decided this is a good idea too new pep?). Second, they tend to anticipate why every errors occured and offer possible solutions. For example mispelling. That said it's not always nice. For example chaining methods sometiems led to me attempting to return a local variable. 
- I stuggled a lot to get them to work. I basically ran into every problem listed in this post. https://depth-first.com/articles/2020/06/22/returning-rust-iterators/ With the sort of root cause that ?statically dispatched traits? can't quite be used like types (and I wanted to avoid dynamic dispatch if possible (though maybe it wasn't necessary?))
- ? is there an example optimiztion that might happen?
- at least demonstrate the power of `take` etc.
- read, transcribe, translate

# 5: Going multicore 
https://medium.com/@mjschillawski/quick-and-easy-parallelization-in-python-32cb9027e490
- dask
- rayon 

https://docs.google.com/spreadsheets/d/1-lrlYnfcRzlyVbfqHlM74Bpidv4auIxsR-fQR_o-oKo/edit#gid=0

# TODO:
- Python Rust capitalized. RNA DNA built-in,comment all code blocks
- compare with bio python: https://biopython.org/wiki/Seq
- https://python.land/python-concurrency/python-multiprocessing
- https://crates.io/crates/multiversion


[^1]: Algebraic data types sort of [exist in Python](https://stackoverflow.com/questions/16258553/how-can-i-define-algebraic-data-types-in-python) but without one key piece of support: pattern matching.

[^2]: [This talk](https://youtu.be/FnBPECrSC7o?t=1867) by Ron Minsky of Jane Street Capital has some really interesting examples of using algebraic data types to write more robust code (using OCaml in the context of securities trading).

[^3]: In rust variants of an enum aren't exactly types, so you can't so something like `fn f(s: DnaNucleotide::A) {}`, and thus you can't do inhericants-like things like  

