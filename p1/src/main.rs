use core::panic;
use std::fs;

fn read_file() -> String {
    let file = fs::read_to_string("p1/rosalind_dna.txt").expect("fuck");
    file.to_uppercase().trim().to_string()
}

fn get_base_counts(seq: String) -> [u32; 4] {
    let mut base_counts = [0; 4];
    for base in seq.chars() {
        match base {
            'A' => base_counts[0] += 1,
            'C' => base_counts[1] += 1,
            'G' => base_counts[2] += 1,
            'T' => base_counts[3] += 1,
            _ => panic!("Input contains '{}' which is not A, T, C, or G", base),
        }
    }
    base_counts
}

fn main() {
    let file = read_file();
    let answer = get_base_counts(file);
    println!("{} {} {} {}", answer[0], answer[1], answer[2], answer[3]);
}

#[cfg(test)]
mod tests {
    use crate::get_base_counts;

    #[test]
    fn test() {
        let seq =
            "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC".to_string();
        let answer = get_base_counts(seq);
        assert_eq!(answer, [20, 12, 17, 21]);
    }
}
