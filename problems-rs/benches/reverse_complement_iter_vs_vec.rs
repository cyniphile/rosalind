use bio_lib_algebraic_rs::reverse_complement as reverse_complement_vec;
use bio_lib_algebraic_rs::{StringParsable, DNA};
use bio_lib_rs::reverse_complement as reverse_complement_iter;
use bio_lib_rs::{Dna, StringParsable as _};
use criterion::{criterion_group, criterion_main, BenchmarkId, Criterion};
use problems_rs::generate_random_dna;

pub fn criterion_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("Reverse Complement");
    let test_samples = (0..25).map(|i| generate_random_dna(i32::pow(2, i)));
    for str_dna in test_samples {
        group.bench_with_input(BenchmarkId::new("Vec", str_dna.len()), &str_dna, |b, i| {
            b.iter(|| {
                let i = DNA::parse_string(i);
                let _ = reverse_complement_vec(&i);
            })
        });
        group.bench_with_input(BenchmarkId::new("Iter", str_dna.len()), &str_dna, |b, i| {
            b.iter(|| {
                let i = Dna::parse_string(i);
                let _: Dna = reverse_complement_iter(i).collect();
            })
        });
        // group.bench_with_input(
        //     BenchmarkId::new("Vec multiple", str_dna.len()),
        //     &str_dna,
        //     |b, i| {
        //         b.iter(|| {
        //             let i = DNA::parse_string(i);
        //             let one = reverse_complement_vec(&i);
        //             let two = reverse_complement_vec(&one);
        //             let _: DNA = reverse_complement_vec(&two);
        //         })
        //     },
        // );
        // group.bench_with_input(
        //     BenchmarkId::new("Iter multiple", str_dna.len()),
        //     &str_dna,
        //     |b, i| {
        //         b.iter(|| {
        //             let i = Dna::parse_string(i);
        //             let one = reverse_complement_iter(i);
        //             let two = reverse_complement_iter(one);
        //             let _: Dna = reverse_complement_iter(two).collect();
        //         })
        //     },
        // );
    }
    group.finish();
}

criterion_group!(benches, criterion_benchmark);
criterion_main!(benches);
