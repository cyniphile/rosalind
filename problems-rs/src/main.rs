use bio_lib::{
    base_counts, base_counts_functional, hamming_distance, read_and_parse_string_file,
    read_string_file, reverse_complement, transcribe, translate, StringParsable, DNA, RNA,
};

fn get_prob_dominant_phenotype(n_homo_dom: i32, n_hetero: i32, n_homo_recess: i32) -> f32 {
    let n_homo_dom = n_homo_dom as f32;
    let n_hetero = n_hetero as f32;
    let n_homo_recess = n_homo_recess as f32;
    let population = n_homo_dom + n_hetero + n_homo_recess;
    // divide by 2 here and below because we don't care about order
    //TODO: try optimizing by using bitshifting 
    let all_choices = population * (population - 1.0) / 2.0;
    let combs_homo_dom = n_homo_dom * (n_homo_dom - 1.0) / 2.0; 
    let other_combs_homo_dom = n_homo_dom * (population - n_homo_dom);
    let combs_hetero_hetero = n_hetero * (n_hetero - 1.0) / 2.0;
    let combs_hetero_recess = n_homo_recess * n_hetero;
    (
        combs_homo_dom
        + other_combs_homo_dom
        // 3/4 = prob of getting non-homzygous recessive from two hetero parents
        + (combs_hetero_hetero * 3.0 / 4.0) 
        // 1/2 = prob of getting non-homzygous recessive from hetero/homo-recessive parents
        + (combs_hetero_recess / 2.0)
    ) / all_choices
}


fn main() {
    println!();
    println!("DNA");
    println!();
    let file = read_string_file("problems-rs/data/rosalind_dna.txt");
    let answer = base_counts(&file);
    let answer_functional = base_counts_functional(&file);
    fn print_answer(answer: [u32; 4]) {
        println!("{} {} {} {}", answer[0], answer[1], answer[2], answer[3]);
    }
    print_answer(answer);
    print_answer(answer_functional);
    println!();
    println!("RNA");
    println!();
    let input = read_and_parse_string_file::<DNA>("problems-rs/data/rosalind_rna.txt");
    let answer = transcribe(&input);
    println!("{}", answer.to_string());
    println!();
    println!("REVC");
    println!();
    let input = read_and_parse_string_file::<DNA>("problems-rs/data/rosalind_revc.txt");
    let answer = reverse_complement(&input);
    println!("{}", answer.to_string());
    println!();
    println!("PROT");
    println!();
    let input = read_and_parse_string_file::<RNA>("problems-rs/data/rosalind_prot.txt");
    let answer = translate(&input);
    println!("{}", answer.to_string());
    println!();
    println!("HAMM");
    println!();
    let seqs: Vec<DNA> = read_string_file("problems-rs/data/rosalind_hamm.txt")
        .split("\n")
        .map(|s| DNA::parse_string(&s.to_string()))
        .collect();
    let answer = hamming_distance(&seqs[0], &seqs[1]);
    println!("{}", answer.to_string());
    println!();
    println!("IPRB");
    println!();
    let input = read_string_file("problems-rs/data/rosalind_iprb.txt");
    let split: Vec<i32> = input
        .split_whitespace()
        .map(|s| s.parse::<i32>().unwrap())
        .collect();
    assert_eq!(split.len(), 3);
    let answer = get_prob_dominant_phenotype(split[0], split[1], split[2]);
    println!("{}", answer);


}

#[cfg(test)]
mod tests {
    use crate::get_prob_dominant_phenotype;

    #[test]
    fn test_get_prob_dominant_phenotype() {
        let answer = get_prob_dominant_phenotype(2, 2, 2);
        assert_eq!(answer, 0.78333336)
    }
}