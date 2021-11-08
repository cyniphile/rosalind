use bio_lib_rs::*;

fn get_prob_dominant_phenotype(n_homo_dom: i32, n_hetero: i32, n_homo_recess: i32) -> f32 {
    let n_homo_dom = n_homo_dom as f32;
    let n_hetero = n_hetero as f32;
    let n_homo_recess = n_homo_recess as f32;
    let population = n_homo_dom + n_hetero + n_homo_recess;
    // divide by 2 here and below because we don't care about order
    //TODO: try optimizing by using bitshifting instead of division
    let all_choices = population * (population - 1.0) / 2.0;
    let combs_homo_dom = n_homo_dom * (n_homo_dom - 1.0) / 2.0; 
    let other_combs_homo_dom = n_homo_dom * (population - n_homo_dom);
    let combs_hetero_hetero = n_hetero * (n_hetero - 1.0) / 2.0;
    let combs_hetero_recess = n_homo_recess * n_hetero;
    (
        combs_homo_dom
        + other_combs_homo_dom
        // 3/4 = prob of getting non-homozygous recessive from two hetero parents
        + (combs_hetero_hetero * 3.0 / 4.0) 
        // 1/2 = prob of getting non-homozygous recessive from hetero/homo-recessive parents
        + (combs_hetero_recess / 2.0)
    ) / all_choices
}


fn main() {
    // TODO: refactor this mess
    println!("==================================");
    println!("DNA");
    println!();
    let file = read_string_file("data/rosalind_dna.txt");
    let file = Dna::parse_string(&file);

    let answer = base_counts(file);
        let answer = [
            answer.get(&DnaNucleotide::A).unwrap().to_owned(),
            answer.get(&DnaNucleotide::C).unwrap().to_owned(),
            answer.get(&DnaNucleotide::G).unwrap().to_owned(),
            answer.get(&DnaNucleotide::T).unwrap().to_owned(),
        ];
    fn print_answer(answer: [u32; 4]) {
        println!("{} {} {} {}", answer[0], answer[1], answer[2], answer[3]);
    }
    print_answer(answer);
    println!();
    println!("RNA");
    println!();
    let input = read_string_file("data/rosalind_rna.txt");
    let input = Dna::parse_string(&input);
    let answer: Rna = convert_dna_to_rna(input).collect();
    println!("{}", answer.to_string());
    println!();
    println!("REVC");
    println!();
    let input = read_string_file("data/rosalind_revc.txt");
    let input = Dna::parse_string(&input);
    let answer: Dna = reverse_complement(input).collect();
    println!("{}", answer.to_string());
    println!();
    println!("PROT");
    println!();
    let input = read_string_file("data/rosalind_prot.txt");
    let input: RnaIter = Rna::parse_string(&input);
    let answer: Protein = input.translate().collect();
    println!("{}", answer.to_string());
    println!();
    println!("HAMM");
    println!();
    let seqs  = read_string_file("data/rosalind_hamm.txt");
    let seqs = seqs.lines();
    let mut seqs = seqs.map( Dna::parse_string);
    let answer = hamming_distance(seqs.next().unwrap(), seqs.next().unwrap());
    println!("{}", answer);
    println!();
    println!("IPRB");
    println!();
    let input = read_string_file("data/rosalind_iprb.txt");
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