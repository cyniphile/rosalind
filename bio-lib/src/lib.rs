#![feature(type_alias_impl_trait)]
#![feature(generic_associated_types)]

use std::{collections::HashMap, fs};

#[derive(PartialEq, Eq, Hash)]
pub enum DnaNucleotide {
    A,
    C,
    G,
    T,
}

// TODO: possibly use https://docs.rs/strum/0.13.0/strum/ to make all the to string mapping easier
#[derive(PartialEq, Eq, Hash)]
pub enum RnaNucleotide {
    A,
    C,
    G,
    U,
}

#[derive(PartialEq, Eq, Hash)]
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

pub type DnaIter<'a> = impl Iterator<Item = DnaNucleotide> + 'a + DoubleEndedIterator;
pub type RnaIter<'a> = impl Iterator<Item = RnaNucleotide> + 'a + DoubleEndedIterator;
pub type ProteinIter<'a> = impl Iterator<Item = AminoAcid> + 'a;

pub type Protein = Vec<AminoAcid>;
pub type Dna = Vec<DnaNucleotide>;
pub type Rna = Vec<RnaNucleotide>;

pub trait Nucleotide {
    fn complement(&self) -> Self;
}

// TODO: is there exhaustivity checking for Bijective maps?
impl Nucleotide for DnaNucleotide {
    fn complement(&self) -> DnaNucleotide {
        match self {
            DnaNucleotide::A => DnaNucleotide::T,
            DnaNucleotide::T => DnaNucleotide::A,
            DnaNucleotide::C => DnaNucleotide::G,
            DnaNucleotide::G => DnaNucleotide::C,
        }
    }
}

impl Nucleotide for RnaNucleotide {
    fn complement(&self) -> RnaNucleotide {
        match self {
            RnaNucleotide::A => RnaNucleotide::U,
            RnaNucleotide::U => RnaNucleotide::A,
            RnaNucleotide::G => RnaNucleotide::C,
            RnaNucleotide::C => RnaNucleotide::G,
        }
    }
}

pub trait StringParsable {
    type Item;
    type Iter<'a>;
    // TODO: should be way to have default implementations of parse/to _string
    // So far causing type problems
    fn parse_string<'a>(seq: &'a str) -> Self::Iter<'a>;
    fn parse_char(c: &char) -> Self::Item;
    fn to_string(&self) -> String;
    fn to_char(c: &Self::Item) -> char;
}

impl StringParsable for Dna {
    type Item = DnaNucleotide;
    type Iter<'a> = DnaIter<'a>;
    fn parse_char(c: &char) -> Self::Item {
        match c {
            // TODO: make these bijective maps
            'A' => DnaNucleotide::A,
            'C' => DnaNucleotide::C,
            'G' => DnaNucleotide::G,
            'T' => DnaNucleotide::T,
            _ => panic!("\"{}\" is not a recognized DNA base.", c),
        }
    }
    fn parse_string<'a>(seq: &'a str) -> DnaIter {
        seq.chars().map(|c| Self::parse_char(&c))
    }
    fn to_char(c: &DnaNucleotide) -> char {
        match c {
            DnaNucleotide::A => 'A',
            DnaNucleotide::C => 'C',
            DnaNucleotide::G => 'G',
            DnaNucleotide::T => 'T',
        }
    }
    // TODO: also make iterator
    fn to_string(&self) -> String {
        self.iter().map(Self::to_char).collect()
    }
}

impl StringParsable for Rna {
    type Item = RnaNucleotide;
    type Iter<'a> = RnaIter<'a>;
    fn parse_char(c: &char) -> Self::Item {
        match c {
            // TODO: make these bijective maps
            'A' => RnaNucleotide::A,
            'C' => RnaNucleotide::C,
            'G' => RnaNucleotide::G,
            'U' => RnaNucleotide::U,
            _ => panic!("\"{}\" is not a recognized RNA base.", c),
        }
    }
    fn parse_string(seq: &str) -> RnaIter {
        seq.chars().map(|c| Self::parse_char(&c))
    }
    fn to_char(c: &Self::Item) -> char {
        match c {
            RnaNucleotide::A => 'A',
            RnaNucleotide::C => 'C',
            RnaNucleotide::G => 'G',
            RnaNucleotide::U => 'U',
        }
    }

    fn to_string(&self) -> String {
        self.iter().map(Self::to_char).collect()
    }
}

impl StringParsable for Protein {
    type Item = AminoAcid;
    type Iter<'a> = ProteinIter<'a>;
    fn parse_char(c: &char) -> Self::Item {
        match c {
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
            _ => panic!("\"{}\" is not a recognized Amino Acid symbol.", c),
        }
    }
    fn parse_string(seq: &str) -> ProteinIter {
        seq.chars().map(|c| Self::parse_char(&c))
    }
    fn to_char(aa: &Self::Item) -> char {
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
    fn to_string(&self) -> String {
        self.iter().map(Self::to_char).collect()
    }
}

fn transcribe_base(base: &DnaNucleotide) -> RnaNucleotide {
    match base {
        DnaNucleotide::A => RnaNucleotide::A,
        DnaNucleotide::C => RnaNucleotide::C,
        DnaNucleotide::G => RnaNucleotide::G,
        DnaNucleotide::T => RnaNucleotide::U,
    }
}

// Can't make return type RnaIter because type alias locks to a concrete type
// and so can't be used with different closures.
// https://stackoverflow.com/questions/57937436/how-to-alias-an-impl-trait
pub fn transcribe<'a>(seq: DnaIter<'a>) -> impl Iterator<Item = RnaNucleotide> + 'a
where
    DnaIter<'a>: 'a,
{
    seq.map(|b| transcribe_base(&b))
}

pub fn read_string_file(path: &str) -> String {
    let file = fs::read_to_string(path).expect("File not found.");
    file.to_uppercase().trim().to_string()
}

/*TODO: using a named tuple struct added some complexity to the ownership stucture.
  For now just using simple 3-ples
*/
// struct Codon(RnaNucleotide, RnaNucleotide, RnaNucleotide);

//   TODO: Handle unequal length
pub fn hamming_distance<I, U: PartialEq>(seq1: I, seq2: I) -> i32
where
    I: Iterator<Item = U>,
{
    seq1.zip(seq2)
        .fold(0, |acc, (x, y)| if x != y { acc + 1 } else { acc })
}

pub fn translate_codon(codon: (&RnaNucleotide, &RnaNucleotide, &RnaNucleotide)) -> AminoAcid {
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
        (U, G, A) => AminoAcid::Stop,
        (U, G, U) => AminoAcid::C,
        (U, G, C) => AminoAcid::C,
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

pub struct Translator<I: Iterator<Item = RnaNucleotide>> {
    inner: I,
}

impl<I: Iterator<Item = RnaNucleotide>> Iterator for Translator<I> {
    type Item = AminoAcid;
    fn next(&mut self) -> Option<AminoAcid> {
        let s1 = match self.inner.next() {
            Some(s) => s,
            None => return None,
        };
        let err_msg = "Cannot translate: sequence is not divisible by 3";
        let s2 = self.inner.next().expect(err_msg);
        let s3 = self.inner.next().expect(err_msg);
        Some(translate_codon((&s1, &s2, &s3)))
    }
}

pub trait TranscribeIteratorExt: Iterator<Item = RnaNucleotide> + Sized {
    fn translate(self) -> Translator<Self>;
}

impl<I: Iterator<Item = RnaNucleotide>> TranscribeIteratorExt for I {
    fn translate(self) -> Translator<Self> {
        Translator { inner: self }
    }
}

pub fn reverse_complement<T: Nucleotide>(
    seq: impl Iterator<Item = T> + std::iter::DoubleEndedIterator,
) -> impl Iterator<Item = T> {
    seq.rev().map(|base| base.complement())
}

pub fn base_counts<T>(seq: impl Iterator<Item = T>) -> HashMap<T, u32>
where
    T: Eq + std::hash::Hash,
{
    let counts = HashMap::new();
    seq.fold(counts, |mut acc, item| {
        *acc.entry(item).or_insert(0) += 1 as u32;
        acc
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_trascribe() {
        let string = "GATGGAACTTGACTACGTAAATT";
        let seq = Dna::parse_string(string);
        let answer: Rna = transcribe(seq).collect();
        let answer = answer.to_string();
        assert_eq!(answer, "GAUGGAACUUGACUACGUAAAUU");
        let string = "GATGGAACTTGACTACGTAAATTT".to_string();
        let seq = Dna::parse_string(&string);
        let answer = transcribe(seq).translate();
        let _: Protein = answer.collect();
    }

    #[test]
    fn test_translate() {
        let string = "AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA".to_string();
        let test_rna: RnaIter = Rna::parse_string(&string);
        let answer: Protein = test_rna.translate().collect();
        let answer = answer.to_string();
        assert_eq!(answer, "MAMAPRTEINSTRING|");
    }

    #[test]
    #[should_panic(expected = "Cannot translate: sequence is not divisible by 3")]
    fn test_non_mod_3_rna_translate() {
        let string = "AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUG".to_string();
        let test_rna = Rna::parse_string(&string);
        let _protein_iter: Protein = test_rna.translate().collect();
    }

    #[test]
    fn test_reverse_complement() {
        let string = "AAAACCCGGT".to_string();
        let seq = Dna::parse_string(&string);
        let answer: Dna = reverse_complement(seq).collect();
        let answer = answer.to_string();
        assert_eq!(answer, "ACCGGGTTTT");
        let string = "AAAACCCGGU".to_string();
        let seq = Rna::parse_string(&string);
        let answer: Rna = reverse_complement(seq).collect();
        let answer = answer.to_string();
        assert_eq!(answer, "ACCGGGUUUU");
    }

    #[test]
    fn test_hamming_distance() {
        let string1 = "GAGCCTACTAACGGGAT".to_string();
        let string2 = "CATCGTAATGACGGCCT".to_string();
        let seq1 = Dna::parse_string(&string1);
        let seq2 = Dna::parse_string(&string2);
        let answer = hamming_distance(seq1, seq2);
        assert_eq!(answer, 7);
    }

    #[test]
    fn test_base_counts() {
        let string =
            "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC".to_string();
        let seq = Dna::parse_string(&string);
        let answer = base_counts(seq);
        let answer = [
            answer.get(&DnaNucleotide::A).unwrap().to_owned(),
            answer.get(&DnaNucleotide::C).unwrap().to_owned(),
            answer.get(&DnaNucleotide::G).unwrap().to_owned(),
            answer.get(&DnaNucleotide::T).unwrap().to_owned(),
        ];
        assert_eq!(answer, [20, 12, 17, 21]);
    }
}
