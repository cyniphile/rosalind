# 3: Algebraic typing in rust
- note all the function names have types encoded in them so far, in both python and rust.
- https://www.youtube.com/watch?v=FnBPECrSC7o&ab_channel=JaneStreet
- enum are a bit tricky because they aren't types
- Amino acid matching example (completeness and adding novel AAs, vs string code)
- sort of exist in python but without the key piece of support: pattern matching
   https://stackoverflow.com/questions/16258553/how-can-i-define-algebraic-data-types-in-python

# 4: Using lazy iterators
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
Python Rust capitalized. RNA DNA built-in,comment all code blocks

- do iters seperately
- compare with bio python: https://biopython.org/wiki/Seq
- add rayon NOW just to see how easy it is (can't par replace in python)
- https://python.land/python-concurrency/python-multiprocessing


https://crates.io/crates/multiversion

---------------



