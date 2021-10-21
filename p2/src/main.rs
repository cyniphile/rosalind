use bio_lib::{
    read_and_parse_string_file, reverse_complement, transcribe, translate, StringParsable, DNA, RNA,
};

fn main() {
    println!("RNA");
    let input = read_and_parse_string_file::<DNA>("p2/rosalind_rna.txt");
    let answer = transcribe(&input);
    println!("{}", answer.to_string());
    println!("REVC");
    let input = read_and_parse_string_file::<DNA>("p2/rosalind_revc.txt");
    let answer = reverse_complement(&input);
    println!("{}", answer.to_string());
    println!("PROT");
    let input = read_and_parse_string_file::<RNA>("p2/rosalind_prot.txt");
    let answer = translate(&input);
    println!("{}", answer.to_string());
}
