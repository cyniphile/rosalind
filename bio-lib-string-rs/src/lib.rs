#![feature(test)]
extern crate test;
use pyo3::prelude::*;
use std::fs;

pub fn read_base_string_file(path: &str) -> String {
    let file = fs::read_to_string(path).expect("Can't find file");
    file.to_uppercase().trim().to_string()
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

fn translate_codon_to_amino_acid(codon: &[u8]) -> char {
    match codon {
        b"UUU" => 'F',
        b"CUU" => 'L',
        b"AUU" => 'I',
        b"GUU" => 'V',
        b"UUC" => 'F',
        b"CUC" => 'L',
        b"AUC" => 'I',
        b"GUC" => 'V',
        b"UUA" => 'L',
        b"CUA" => 'L',
        b"AUA" => 'I',
        b"GUA" => 'V',
        b"UUG" => 'L',
        b"CUG" => 'L',
        b"AUG" => 'M',
        b"GUG" => 'V',
        b"UCU" => 'S',
        b"CCU" => 'P',
        b"ACU" => 'T',
        b"GCU" => 'A',
        b"UCC" => 'S',
        b"CCC" => 'P',
        b"ACC" => 'T',
        b"GCC" => 'A',
        b"UCA" => 'S',
        b"CCA" => 'P',
        b"ACA" => 'T',
        b"GCA" => 'A',
        b"UCG" => 'S',
        b"CCG" => 'P',
        b"ACG" => 'T',
        b"GCG" => 'A',
        b"UAU" => 'Y',
        b"CAU" => 'H',
        b"AAU" => 'N',
        b"GAU" => 'D',
        b"UAC" => 'Y',
        b"CAC" => 'H',
        b"AAC" => 'N',
        b"GAC" => 'D',
        b"UAA" => 'S',
        b"CAA" => 'Q',
        b"AAA" => 'K',
        b"GAA" => 'E',
        b"UAG" => 'S',
        b"CAG" => 'Q',
        b"AAG" => 'K',
        b"GAG" => 'E',
        b"UGU" => 'C',
        b"CGU" => 'R',
        b"AGU" => 'S',
        b"GGU" => 'G',
        b"UGC" => 'C',
        b"CGC" => 'R',
        b"AGC" => 'S',
        b"GGC" => 'G',
        b"UGA" => 'S',
        b"CGA" => 'R',
        b"AGA" => 'R',
        b"GGA" => 'G',
        b"UGG" => 'W',
        b"CGG" => 'R',
        b"AGG" => 'R',
        b"GGG" => 'G',
        _ => panic!("Codon {:?} not in the Genetic Code detected.", codon),
    }
}

pub fn translate_rna_to_amino_acids(rna: &str) -> String {
    rna.as_bytes()
        .chunks(3)
        .map(translate_codon_to_amino_acid)
        .collect()
}

#[pyclass]
pub struct PalindomeLocation {
    pub start_index: usize,
    pub length: usize,
}

// pub fn find_reverse_palindomes(seq: &str) -> Vec<PalindomeLocation> {

#[pyfunction]
pub fn find_reverse_palindomes(seq: &str) -> Vec<[usize; 2]> {
    let min_len = 4;
    let max_len = 12;
    let mut locations = Vec::new();
    // Iterate from start to min_len from the end
    for i in 0..(seq.len() - min_len + 1) {
        for length in (min_len..(max_len + 1)).step_by(2) {
            // seq.len() should be hoisted no?
            // it might be fast to access because I think its part of the str
            // smart pointer
            if i + length > seq.len() {
                continue;
            }
            let test_seq = &seq[i..(i + length)];
            if is_reverse_palindrome(test_seq) {
                // i+1 because rosalind uses 1 index arrays in answer checking
                locations.push(
                    [i + 1, length], //     PalindomeLocation {
                                     //     start_index: i + 1,
                                     //     // Cool rust trick: it's matching the variable with name `length`
                                     //     // to the struct field named `length`
                                     //     length,
                                     // }
                )
            }
        }
    }
    locations
}

pub fn is_reverse_palindrome(seq: &str) -> bool {
    seq == reverse_complement_dna(seq)
}

/*
    TCAATGCATGCGGGTCTATATGCAT
    ATGCATATAGACCCGCATGCATTGA
    | |
    | |
    |   |
*/

#[pyfunction]
pub fn convert_dna_to_rna(dna_seq: &str) -> String {
    dna_seq
        .chars()
        .map(|x| if x == 'T' { 'U' } else { x })
        .collect()
}

#[pyfunction]
pub fn convert_dna_to_rna_native(dna_seq: &str) -> String {
    dna_seq.replace("T", "U")
}

pub fn reverse_complement_dna(dna_seq: &str) -> String {
    dna_seq.chars().rev().map(dna_base_complement).collect()
}

#[cfg(test)]
mod tests {
    use crate::*;
    use std::path::PathBuf;
    use test::Bencher;

    #[test]
    fn test_translate_rna_to_amino_acids() {
        let test_rna = "AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA".to_string();
        let answer = translate_rna_to_amino_acids(&test_rna);
        assert_eq!(answer, "MAMAPRTEINSTRINGS")
    }

    #[bench]
    fn bench_convert(b: &mut Bencher) {
        let mut d = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
        d.push("../data/rosalind_rna.txt");
        let seq = read_base_string_file(d.to_str().unwrap());
        b.iter(|| convert_dna_to_rna(&seq));
    }

    #[bench]
    fn bench_find_reverse_palindomes(b: &mut Bencher) {
        let mut d = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
        d.push("../data/rosalind_revp.txt");
        let path = d.to_str().unwrap();
        let seq = fs::read_to_string(path).expect("Error");
        let mut seq = seq.lines();
        seq.next();
        let seq: Vec<&str> = seq.collect();
        let seq = seq.join("");
        b.iter(|| find_reverse_palindomes(&seq));
    }

    #[bench]
    fn bench_find_reverse_palindomes_large(b: &mut Bencher) {
        let mut d = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
        d.push("../benchmark-data/revp-large.txt");
        let seq = read_base_string_file(d.to_str().unwrap());
        b.iter(|| find_reverse_palindomes(&seq));
    }

    #[bench]
    fn bench_convert_native(b: &mut Bencher) {
        let mut d = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
        d.push("../data/rosalind_rna.txt");
        let seq = read_base_string_file(d.to_str().unwrap());
        b.iter(|| convert_dna_to_rna_native(&seq));
    }

    #[test]
    fn test_convert() {
        let seq = "GATGGAACTTGACTACGTAAATT".to_string();
        let answer = convert_dna_to_rna(&seq);
        assert_eq!(answer, "GAUGGAACUUGACUACGUAAAUU");
        let answer = convert_dna_to_rna_native(&seq);
        assert_eq!(answer, "GAUGGAACUUGACUACGUAAAUU");
    }

    #[test]
    fn test_reverse_complement() {
        let seq = "AAAACCCGGT".to_string();
        let answer = reverse_complement_dna(&seq);
        assert_eq!(answer, "ACCGGGTTTT");
    }

    #[test]
    fn test_find_reverse_palindomes() {
        let seq = "TCAATGCATGCGGGTCTATATGCAT";
        let test_answer = find_reverse_palindomes(seq);
        // let test_answer: Vec<[usize; 2]> = test_answer
        // .iter()
        // .map(|p| [p.start_index, p.length])
        // .collect();
        let true_answer = vec![
            [4, 6],
            [5, 4],
            [6, 6],
            [7, 4],
            [17, 4],
            [18, 4],
            [20, 6],
            [21, 4],
        ];
        assert_eq!(true_answer, test_answer)
    }
}

#[pymodule]
fn bio_lib_string_rs(_py: Python, m: &PyModule) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(convert_dna_to_rna, m)?)?;
    m.add_function(wrap_pyfunction!(convert_dna_to_rna_native, m)?)?;
    m.add_function(wrap_pyfunction!(find_reverse_palindomes, m)?)?;
    m.add_class::<PalindomeLocation>()?;
    Ok(())
}
