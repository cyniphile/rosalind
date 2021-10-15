use std::fs;

pub fn read_base_string_file(path: &str) -> String {
    let file = fs::read_to_string(path).expect("fuck");
    file.to_uppercase().trim().to_string()
}

pub fn get_dna_base_complement(base: char) -> char {
    match base {
        'A' => 'T',
        'T' => 'A',
        'G' => 'C',
        'C' => 'G',
        _ => panic!("Non-DNA base \"{}\" found.", base),
    }
}

pub fn hamming_distance(seq1: &String, seq2: &String) -> i32 {
    assert_eq!(
        seq1.len(),
        seq2.len(),
        "This implementation of Hamming distance only works for strings of equal size."
    );
    let mut dist = 0;
    for (x, y) in seq1.chars().zip(seq2.chars()) {
        if x != y {
            dist += 1;
        }
    }
    dist
}

pub fn hamming_distance_functional(seq1: &String, seq2: &String) -> i32 {
    assert_eq!(
        seq1.len(),
        seq2.len(),
        "This implementation of Hamming distance only works 
        for strings of equal size."
    );
    seq1.chars()
        .zip(seq2.chars())
        .fold(0, |acc, (x, y)| if x != y { acc + 1 } else { acc })
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

pub fn translate_rna_to_amino_acids(rna: &String) -> String {
    rna.as_bytes()
        .chunks(3)
        .map(|codon| translate_codon_to_amino_acid(codon))
        .collect()
}

pub fn transcribe_dna_to_rna(dna_seq: &String) -> String {
    dna_seq
        .chars()
        .map(|x| if x == 'T' { 'U' } else { x })
        .collect()
}

pub fn reverse_complement_dna(dna_seq: &String) -> String {
    dna_seq
        .chars()
        .rev()
        .map(|base| get_dna_base_complement(base))
        .collect()
}

#[cfg(test)]
mod tests {
    use crate::hamming_distance;
    use crate::hamming_distance_functional;
    use crate::reverse_complement_dna;
    use crate::transcribe_dna_to_rna;
    use crate::translate_rna_to_amino_acids;

    #[test]
    fn test_translate_rna_to_amino_acids() {
        let test_rna = "AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA".to_string();
        let answer = translate_rna_to_amino_acids(&test_rna);
        assert_eq!(answer, "MAMAPRTEINSTRINGS")
    }

    #[test]
    fn test_trascribe_dna_to_rna() {
        let seq = "GATGGAACTTGACTACGTAAATT".to_string();
        let answer = transcribe_dna_to_rna(&seq);
        assert_eq!(answer, "GAUGGAACUUGACUACGUAAAUU");
    }

    #[test]
    fn test_reverse_complement() {
        let seq = "AAAACCCGGT".to_string();
        let answer = reverse_complement_dna(&seq);
        assert_eq!(answer, "ACCGGGTTTT");
    }

    #[test]
    fn test_hamming_distance() {
        let seq1 = "GAGCCTACTAACGGGAT".to_string();
        let seq2 = "CATCGTAATGACGGCCT".to_string();
        let answer = hamming_distance(&seq1, &seq2);
        assert_eq!(answer, 7);
        let answer = hamming_distance_functional(&seq1, &seq2);
        assert_eq!(answer, 7);
    }
}
