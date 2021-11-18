use bio_lib_algebraic_rs::StringParsable;
use bio_lib_algebraic_rs::{find_reverse_palindromes as find_reverse_palindromes_alg, DNA};
use bio_lib_string_rs::find_reverse_palindromes_str;
use criterion::{criterion_group, criterion_main, BenchmarkId, Criterion};
use problems_rs::generate_random_dna;

pub fn criterion_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("Reverse Palindromes");
    let test_samples = (0..25).map(|i| generate_random_dna(i32::pow(2, i)));
    for str_dna in test_samples {
        group.bench_with_input(
            BenchmarkId::new("String", str_dna.len()),
            &str_dna,
            |b, i| b.iter(|| find_reverse_palindromes_str(i)),
        );
        group.bench_with_input(BenchmarkId::new("ADT", str_dna.len()), &str_dna, |b, i| {
            let i = DNA::parse_string(i);
            b.iter(|| find_reverse_palindromes_alg(&i))
        });
        group.bench_with_input(
            BenchmarkId::new("ADT with Parsing", str_dna.len()),
            &str_dna,
            |b, i| {
                b.iter(|| {
                    let i = DNA::parse_string(i);
                    find_reverse_palindromes_alg(&i)
                })
            },
        );
    }
    group.finish();
}

criterion_group!(benches, criterion_benchmark);
criterion_main!(benches);
