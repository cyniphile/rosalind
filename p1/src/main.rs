use bio_lib::read_string_file;
use core::panic;

fn get_base_counts(seq: &String) -> [u32; 4] {
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

fn get_base_counts_functional(seq: &String) -> [u32; 4] {
    seq.chars().fold([0; 4], |mut base_counts, base| {
        match base {
            'A' => base_counts[0] += 1,
            'C' => base_counts[1] += 1,
            'G' => base_counts[2] += 1,
            'T' => base_counts[3] += 1,
            _ => panic!("Input contains '{}' which is not A, T, C, or G", base),
        }
        base_counts
    })
}

fn main() {
    let file = read_string_file("p1/rosalind_dna.txt");
    let answer = get_base_counts(&file);
    let answer_functional = get_base_counts_functional(&file);
    fn print_answer(answer: [u32; 4]) {
        println!("{} {} {} {}", answer[0], answer[1], answer[2], answer[3]);
    }
    print_answer(answer);
    print_answer(answer_functional);
}

#[cfg(test)]
mod tests {
    use crate::{get_base_counts, get_base_counts_functional};

    #[test]
    fn test() {
        let seq =
            "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC".to_string();
        let answer = get_base_counts(&seq);
        assert_eq!(answer, [20, 12, 17, 21]);
        let answer = get_base_counts_functional(&seq);
        assert_eq!(answer, [20, 12, 17, 21]);
    }
}
