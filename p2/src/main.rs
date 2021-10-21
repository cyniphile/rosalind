use bio_lib::{
    read_string_file, reverse_complement_dna, transcribe_dna_to_rna,
    translate,
};

fn main() {
    println!("p2");
    let input = read_string_file("p2/rosalind_rna.txt");
    let answer = transcribe_dna_to_rna(&input);
    println!("{}", answer);
    println!("\np3");
    let input = read_string_file("p2/rosalind_revc.txt");
    let answer = reverse_complement_dna(&input);
    println!("{}", answer);
    let input = read_string_file("p2/rosalind_prot.txt");
    let answer = translate(&input);
    println!("{}", answer);
}
