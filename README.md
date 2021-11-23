Bioinformatics problems from http://rosalind.info/ and the https://stepik.org/course/91751/promo contest implemented in Python and Rust.

- Install [Rust](https://www.rust-lang.org/tools/install).
- Install [poetry](https://github.com/python-poetry/poetry).
- Build Rust code: `cargo b` and install Python packages `poetry install`. 
- Build Python-Rust `maturin develop --relase` in the various Rust libs. 
- Generate large data: `python generate_large_test_data.py`.
- Run `pytest` and `cargo criterion` to generate benchmarks.

- add rayon to vector implementation