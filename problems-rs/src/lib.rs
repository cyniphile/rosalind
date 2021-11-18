// TODO: generating random data should only be done once with data saved to the
// data/benchmark-data dir. Otherwise benches won't be consistent over time.

use rand::{distributions::Uniform, prelude::Distribution};

pub fn generate_random_dna(length: i32) -> String {
    let letters = ["A", "C", "G", "T"];
    let mut rng = rand::thread_rng();
    let u = Uniform::new(0, 4);
    (0..length).map(|_| letters[u.sample(&mut rng)]).collect()
}
