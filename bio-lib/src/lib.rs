use std::fs;

pub enum DnaNucleotide {
    A,
    C,
    G,
    T,
}

pub enum RnaNucleotide {
    A,
    C,
    G,
    U,
}

pub enum AminoAcid {
    A,
    R,
    N,
    D,
    C,
    Q,
    E,
    G,
    H,
    I,
    L,
    K,
    M,
    F,
    P,
    S,
    T,
    W,
    Y,
    V,
    Stop,
}

trait Nucleotide {
    fn get_base_complement(&self) -> Self;
}

// TODO: is there exhaustivity checking for Bijective maps?
impl Nucleotide for DnaNucleotide {
    fn get_base_complement(&self) -> DnaNucleotide {
        match self {
            DnaNucleotide::A => DnaNucleotide::T,
            DnaNucleotide::T => DnaNucleotide::A,
            DnaNucleotide::C => DnaNucleotide::G,
            DnaNucleotide::G => DnaNucleotide::C,
        }
    }
}

impl Nucleotide for RnaNucleotide {
    fn get_base_complement(&self) -> RnaNucleotide {
        match self {
            RnaNucleotide::A => RnaNucleotide::U,
            RnaNucleotide::U => RnaNucleotide::A,
            RnaNucleotide::G => RnaNucleotide::C,
            RnaNucleotide::C => RnaNucleotide::G,
        }
    }
}

type DNA = Vec<DnaNucleotide>;
type RNA = Vec<RnaNucleotide>;
type Protein = Vec<AminoAcid>;

pub trait StringParsable {
    fn parse_string(seq: &String) -> Self;
    fn to_string(&self) -> String;
}

impl StringParsable for DNA {
    fn parse_string(seq: &String) -> DNA {
        let parser = |base| match base {
            // TODO: make these bijective maps
            'A' => DnaNucleotide::A,
            'C' => DnaNucleotide::C,
            'G' => DnaNucleotide::G,
            'T' => DnaNucleotide::T,
            _ => panic!("\"{}\" is not a recognized DNA base.", base),
        };
        seq.chars().map(parser).collect()
    }
    fn to_string(&self) -> String {
        fn parser(base: &DnaNucleotide) -> char {
            match base {
                DnaNucleotide::A => 'A',
                DnaNucleotide::C => 'C',
                DnaNucleotide::G => 'G',
                DnaNucleotide::T => 'T',
            }
        }
        self.iter().map(parser).collect()
    }
}

impl StringParsable for RNA {
    fn parse_string(seq: &String) -> RNA {
        let parser = |base| match base {
            // TODO: make these bijective maps
            'A' => RnaNucleotide::A,
            'C' => RnaNucleotide::C,
            'G' => RnaNucleotide::G,
            'U' => RnaNucleotide::U,
            _ => panic!("\"{}\" is not a recognized RNA base.", base),
        };
        seq.chars().map(parser).collect()
    }
    fn to_string(&self) -> String {
        fn parser(base: &RnaNucleotide) -> char {
            match base {
                RnaNucleotide::A => 'A',
                RnaNucleotide::C => 'C',
                RnaNucleotide::G => 'G',
                RnaNucleotide::U => 'U',
            }
        }
        self.iter().map(parser).collect()
    }
}

impl StringParsable for Protein {
    fn parse_string(seq: &String) -> Self {
        let parser = |aa| match aa {
            // TODO: make these bijective maps
            'A' => AminoAcid::A,
            'R' => AminoAcid::R,
            'N' => AminoAcid::N,
            'D' => AminoAcid::D,
            'C' => AminoAcid::C,
            'Q' => AminoAcid::Q,
            'E' => AminoAcid::E,
            'G' => AminoAcid::G,
            'H' => AminoAcid::H,
            'I' => AminoAcid::I,
            'L' => AminoAcid::L,
            'K' => AminoAcid::K,
            'M' => AminoAcid::M,
            'F' => AminoAcid::F,
            'P' => AminoAcid::P,
            'S' => AminoAcid::S,
            'T' => AminoAcid::T,
            'W' => AminoAcid::W,
            'Y' => AminoAcid::Y,
            'V' => AminoAcid::V,
            '|' => AminoAcid::Stop,
            _ => panic!("\"{}\" is not a recognized Amino Acid.", aa),
        };
        seq.chars().map(parser).collect()
    }
    fn to_string(&self) -> String {
        fn parser(aa: &AminoAcid) -> char {
            match aa {
                AminoAcid::Stop => '|',
                AminoAcid::V => 'V',
                AminoAcid::Y => 'Y',
                AminoAcid::W => 'W',
                AminoAcid::T => 'T',
                AminoAcid::S => 'S',
                AminoAcid::P => 'P',
                AminoAcid::F => 'F',
                AminoAcid::M => 'M',
                AminoAcid::K => 'K',
                AminoAcid::L => 'L',
                AminoAcid::I => 'I',
                AminoAcid::H => 'H',
                AminoAcid::G => 'G',
                AminoAcid::E => 'E',
                AminoAcid::Q => 'Q',
                AminoAcid::C => 'C',
                AminoAcid::D => 'D',
                AminoAcid::N => 'N',
                AminoAcid::R => 'R',
                AminoAcid::A => 'A',
            }
        }
        self.iter().map(parser).collect()
    }
}

pub fn read_string_file<T: StringParsable>(path: &str) -> T {
    let file = fs::read_to_string(path).expect("Can't parse file to into a string.");
    let seq = file.to_uppercase().trim().to_string();
    T::parse_string(&seq)
}

// TODO: using a tuple struct added some complexity to the ownership stucture.
// For now just using 3-ples
// struct Codon(RnaNucleotide, RnaNucleotide, RnaNucleotide);

// TODO: do some profiling to compare with 'functional' implementation
// https://crates.io/crates/criterion
pub fn hamming_distance(seq1: &str, seq2: &str) -> i32 {
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

fn translate_codon(codon: (&RnaNucleotide, &RnaNucleotide, &RnaNucleotide)) -> AminoAcid {
    use RnaNucleotide::*;
    match codon {
        (U, U, U) => AminoAcid::F,
        (U, U, C) => AminoAcid::F,
        (U, U, A) => AminoAcid::L,
        (U, U, G) => AminoAcid::L,
        (U, C, A) => AminoAcid::S,
        (U, C, C) => AminoAcid::S,
        (U, C, G) => AminoAcid::S,
        (U, C, U) => AminoAcid::S,
        (U, A, U) => AminoAcid::Y,
        (U, A, C) => AminoAcid::Y,
        (U, A, A) => AminoAcid::Stop,
        (U, A, G) => AminoAcid::Stop,
        (U, G, U) => AminoAcid::C,
        (U, G, C) => AminoAcid::C,
        (U, G, A) => AminoAcid::Stop,
        (U, G, G) => AminoAcid::W,
        (C, U, U) => AminoAcid::L,
        (A, U, U) => AminoAcid::I,
        (G, U, U) => AminoAcid::V,
        (C, U, C) => AminoAcid::L,
        (A, U, C) => AminoAcid::I,
        (G, U, C) => AminoAcid::V,
        (C, U, A) => AminoAcid::L,
        (A, U, A) => AminoAcid::I,
        (G, U, A) => AminoAcid::V,
        (C, U, G) => AminoAcid::L,
        (A, U, G) => AminoAcid::M,
        (G, U, G) => AminoAcid::V,
        (C, C, U) => AminoAcid::P,
        (A, C, U) => AminoAcid::T,
        (G, C, U) => AminoAcid::A,
        (C, C, C) => AminoAcid::P,
        (A, C, C) => AminoAcid::T,
        (G, C, C) => AminoAcid::A,
        (C, C, A) => AminoAcid::P,
        (A, C, A) => AminoAcid::T,
        (G, C, A) => AminoAcid::A,
        (C, C, G) => AminoAcid::P,
        (A, C, G) => AminoAcid::T,
        (G, C, G) => AminoAcid::A,
        (C, A, U) => AminoAcid::H,
        (A, A, U) => AminoAcid::N,
        (G, A, U) => AminoAcid::D,
        (C, A, C) => AminoAcid::H,
        (A, A, C) => AminoAcid::N,
        (G, A, C) => AminoAcid::D,
        (C, A, A) => AminoAcid::Q,
        (A, A, A) => AminoAcid::K,
        (G, A, A) => AminoAcid::E,
        (C, A, G) => AminoAcid::Q,
        (A, A, G) => AminoAcid::K,
        (G, A, G) => AminoAcid::E,
        (C, G, U) => AminoAcid::R,
        (A, G, U) => AminoAcid::S,
        (G, G, U) => AminoAcid::G,
        (C, G, C) => AminoAcid::R,
        (A, G, C) => AminoAcid::S,
        (G, G, C) => AminoAcid::G,
        (C, G, A) => AminoAcid::R,
        (A, G, A) => AminoAcid::R,
        (G, G, A) => AminoAcid::G,
        (C, G, G) => AminoAcid::R,
        (A, G, G) => AminoAcid::R,
        (G, G, G) => AminoAcid::G,
    }
}

pub fn translate(rna: &RNA) -> Protein {
    rna.chunks(3)
        .map(|chunk| (&chunk[0], &chunk[1], &chunk[2]))
        .map(translate_codon)
        .collect()
}

pub fn transcribe(seq: DNA) -> RNA {
    let transcribe = |base: &DnaNucleotide| match base {
        DnaNucleotide::A => RnaNucleotide::A,
        DnaNucleotide::C => RnaNucleotide::C,
        DnaNucleotide::G => RnaNucleotide::G,
        DnaNucleotide::T => RnaNucleotide::U,
    };
    seq.iter().map(transcribe).collect()
}

// pub fn reverse_complement_dna(dna_seq: &String) -> String {
//     dna_seq
//         .chars()
//         .rev()
//         .map(|base| get_dna_base_complement(base))
//         .collect()
// }

#[cfg(test)]
mod tests {
    use crate::hamming_distance;
    use crate::hamming_distance_functional;
    use crate::transcribe;
    use crate::translate;
    use crate::StringParsable;
    use crate::DNA;
    use crate::RNA;

    #[test]
    fn test_translate() {
        let test_rna =
            RNA::parse_string(&"AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA".to_string());
        let answer = translate(&test_rna).to_string();
        assert_eq!(answer, "MAMAPRTEINSTRING|")
    }

    #[test]
    fn test_trascribe_dna_to_rna() {
        let seq = DNA::parse_string(&"GATGGAACTTGACTACGTAAATT".to_string());
        let answer = transcribe(seq).to_string();
        assert_eq!(answer, "GAUGGAACUUGACUACGUAAAUU");
    }

    // #[test]
    // fn test_reverse_complement() {
    //     let seq = "AAAACCCGGT".to_string();
    //     let answer = reverse_complement_dna(&seq);
    //     assert_eq!(answer, "ACCGGGTTTT");
    // }

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
