use bio_lib::read_base_string_file;

fn transcribe_dna_to_rna(dna_seq: String) -> String {
    dna_seq
        .chars()
        .map(|x| if x == 'T' { 'U' } else { x })
        .collect()
}

fn main() {
    let input = read_base_string_file("p2/rosalind_rna.txt");
    let answer = transcribe_dna_to_rna(input);
    println!("{}", answer)
}

#[cfg(test)]
mod tests {
    use crate::transcribe_dna_to_rna;

    #[test]
    fn test() {
        let seq = "GATGGAACTTGACTACGTAAATT".to_string();
        let answer = transcribe_dna_to_rna(seq);
        assert_eq!(answer, "GAUGGAACUUGACUACGUAAAUU");
    }
}
