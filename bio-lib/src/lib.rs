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
    match codon {
        (RnaNucleotide::U, RnaNucleotide::U, RnaNucleotide::U) => AminoAcid::F,
        (RnaNucleotide::U, RnaNucleotide::U, RnaNucleotide::C) => AminoAcid::F,
        (RnaNucleotide::U, RnaNucleotide::U, RnaNucleotide::A) => AminoAcid::L,
        (RnaNucleotide::U, RnaNucleotide::U, RnaNucleotide::G) => AminoAcid::L,
        (RnaNucleotide::U, RnaNucleotide::C, RnaNucleotide::A) => AminoAcid::S,
        (RnaNucleotide::U, RnaNucleotide::C, RnaNucleotide::C) => AminoAcid::S,
        (RnaNucleotide::U, RnaNucleotide::C, RnaNucleotide::G) => AminoAcid::S,
        (RnaNucleotide::U, RnaNucleotide::C, RnaNucleotide::U) => AminoAcid::S,
        (RnaNucleotide::U, RnaNucleotide::A, RnaNucleotide::U) => AminoAcid::Y,
        (RnaNucleotide::U, RnaNucleotide::A, RnaNucleotide::C) => AminoAcid::Y,
        (RnaNucleotide::U, RnaNucleotide::A, RnaNucleotide::A) => AminoAcid::Stop,
        (RnaNucleotide::U, RnaNucleotide::A, RnaNucleotide::G) => AminoAcid::Stop,
        (RnaNucleotide::U, RnaNucleotide::G, RnaNucleotide::U) => AminoAcid::C,
        (RnaNucleotide::U, RnaNucleotide::G, RnaNucleotide::C) => AminoAcid::C,
        (RnaNucleotide::U, RnaNucleotide::G, RnaNucleotide::A) => AminoAcid::Stop,
        (RnaNucleotide::U, RnaNucleotide::G, RnaNucleotide::G) => AminoAcid::W,
        (RnaNucleotide::C, RnaNucleotide::U, RnaNucleotide::U) => AminoAcid::L,
        (RnaNucleotide::A, RnaNucleotide::U, RnaNucleotide::U) => AminoAcid::I,
        (RnaNucleotide::G, RnaNucleotide::U, RnaNucleotide::U) => AminoAcid::V,
        (RnaNucleotide::C, RnaNucleotide::U, RnaNucleotide::C) => AminoAcid::L,
        (RnaNucleotide::A, RnaNucleotide::U, RnaNucleotide::C) => AminoAcid::I,
        (RnaNucleotide::G, RnaNucleotide::U, RnaNucleotide::C) => AminoAcid::V,
        (RnaNucleotide::C, RnaNucleotide::U, RnaNucleotide::A) => AminoAcid::L,
        (RnaNucleotide::A, RnaNucleotide::U, RnaNucleotide::A) => AminoAcid::I,
        (RnaNucleotide::G, RnaNucleotide::U, RnaNucleotide::A) => AminoAcid::V,
        (RnaNucleotide::C, RnaNucleotide::U, RnaNucleotide::G) => AminoAcid::L,
        (RnaNucleotide::A, RnaNucleotide::U, RnaNucleotide::G) => AminoAcid::M,
        (RnaNucleotide::G, RnaNucleotide::U, RnaNucleotide::G) => AminoAcid::V,
        (RnaNucleotide::C, RnaNucleotide::C, RnaNucleotide::U) => AminoAcid::P,
        (RnaNucleotide::A, RnaNucleotide::C, RnaNucleotide::U) => AminoAcid::T,
        (RnaNucleotide::G, RnaNucleotide::C, RnaNucleotide::U) => AminoAcid::A,
        (RnaNucleotide::C, RnaNucleotide::C, RnaNucleotide::C) => AminoAcid::P,
        (RnaNucleotide::A, RnaNucleotide::C, RnaNucleotide::C) => AminoAcid::T,
        (RnaNucleotide::G, RnaNucleotide::C, RnaNucleotide::C) => AminoAcid::A,
        (RnaNucleotide::C, RnaNucleotide::C, RnaNucleotide::A) => AminoAcid::P,
        (RnaNucleotide::A, RnaNucleotide::C, RnaNucleotide::A) => AminoAcid::T,
        (RnaNucleotide::G, RnaNucleotide::C, RnaNucleotide::A) => AminoAcid::A,
        (RnaNucleotide::C, RnaNucleotide::C, RnaNucleotide::G) => AminoAcid::P,
        (RnaNucleotide::A, RnaNucleotide::C, RnaNucleotide::G) => AminoAcid::T,
        (RnaNucleotide::G, RnaNucleotide::C, RnaNucleotide::G) => AminoAcid::A,
        (RnaNucleotide::C, RnaNucleotide::A, RnaNucleotide::U) => AminoAcid::H,
        (RnaNucleotide::A, RnaNucleotide::A, RnaNucleotide::U) => AminoAcid::N,
        (RnaNucleotide::G, RnaNucleotide::A, RnaNucleotide::U) => AminoAcid::D,
        (RnaNucleotide::C, RnaNucleotide::A, RnaNucleotide::C) => AminoAcid::H,
        (RnaNucleotide::A, RnaNucleotide::A, RnaNucleotide::C) => AminoAcid::N,
        (RnaNucleotide::G, RnaNucleotide::A, RnaNucleotide::C) => AminoAcid::D,
        (RnaNucleotide::C, RnaNucleotide::A, RnaNucleotide::A) => AminoAcid::Q,
        (RnaNucleotide::A, RnaNucleotide::A, RnaNucleotide::A) => AminoAcid::K,
        (RnaNucleotide::G, RnaNucleotide::A, RnaNucleotide::A) => AminoAcid::E,
        (RnaNucleotide::C, RnaNucleotide::A, RnaNucleotide::G) => AminoAcid::Q,
        (RnaNucleotide::A, RnaNucleotide::A, RnaNucleotide::G) => AminoAcid::K,
        (RnaNucleotide::G, RnaNucleotide::A, RnaNucleotide::G) => AminoAcid::E,
        (RnaNucleotide::C, RnaNucleotide::G, RnaNucleotide::U) => AminoAcid::R,
        (RnaNucleotide::A, RnaNucleotide::G, RnaNucleotide::U) => AminoAcid::S,
        (RnaNucleotide::G, RnaNucleotide::G, RnaNucleotide::U) => AminoAcid::G,
        (RnaNucleotide::C, RnaNucleotide::G, RnaNucleotide::C) => AminoAcid::R,
        (RnaNucleotide::A, RnaNucleotide::G, RnaNucleotide::C) => AminoAcid::S,
        (RnaNucleotide::G, RnaNucleotide::G, RnaNucleotide::C) => AminoAcid::G,
        (RnaNucleotide::C, RnaNucleotide::G, RnaNucleotide::A) => AminoAcid::R,
        (RnaNucleotide::A, RnaNucleotide::G, RnaNucleotide::A) => AminoAcid::R,
        (RnaNucleotide::G, RnaNucleotide::G, RnaNucleotide::A) => AminoAcid::G,
        (RnaNucleotide::C, RnaNucleotide::G, RnaNucleotide::G) => AminoAcid::R,
        (RnaNucleotide::A, RnaNucleotide::G, RnaNucleotide::G) => AminoAcid::R,
        (RnaNucleotide::G, RnaNucleotide::G, RnaNucleotide::G) => AminoAcid::G,
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
