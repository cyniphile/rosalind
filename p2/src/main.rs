use bio_lib::{
    hamming_distance, read_and_parse_string_file, read_string_file, reverse_complement, transcribe,
    translate, StringParsable, DNA, RNA,
};

fn main() {
    println!();
    println!("RNA");
    println!();
    let input = read_and_parse_string_file::<DNA>("p2/rosalind_rna.txt");
    let answer = transcribe(&input);
    println!("{}", answer.to_string());
    println!();
    println!("REVC");
    println!();
    let input = read_and_parse_string_file::<DNA>("p2/rosalind_revc.txt");
    let answer = reverse_complement(&input);
    println!("{}", answer.to_string());
    println!();
    println!("PROT");
    println!();
    let input = read_and_parse_string_file::<RNA>("p2/rosalind_prot.txt");
    let answer = translate(&input);
    println!("{}", answer.to_string());
    println!();
    println!("HAMM");
    println!();
    let seqs: Vec<DNA> = read_string_file("p2/rosalind_hamm.txt")
        .split("\n")
        .map(|s| DNA::parse_string(&s.to_string()))
        .collect();
    let answer = hamming_distance(&seqs[0], &seqs[1]);
    println!("{}", answer.to_string());
}
