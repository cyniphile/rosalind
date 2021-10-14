use bio_lib::read_base_string_file;
use num::integer::binomial;

fn get_prob_dominant_phenotype(n_homo_dom: i32, n_hetero: i32, n_homo_recess: i32) -> f32 {
    let n_homo_dom = n_homo_dom as f32;
    let n_hetero = n_hetero as f32;
    let n_homo_recess = n_homo_recess as f32;
    let population = n_homo_dom + n_hetero + n_homo_recess;
    let choices = binomial(population as i32, 2) as f32;
    let combs_homo_dom = n_homo_dom * (n_homo_dom - 1.0) / 2.0;
    let other_combs_homo_dom = n_homo_dom * (population - n_homo_dom);
    let combs_hetero_hetero = n_hetero * (n_hetero - 1.0) / 2.0;
    let combs_hetero_recess = n_homo_recess * n_hetero;
    (
        combs_homo_dom
        + other_combs_homo_dom
        + (combs_hetero_hetero * 3.0 / 4.0) // 3/4 is prob of getting non-homzygous recessive two hetero parents
        + (combs_hetero_recess / 2.0)
        // 1/2 is prob of getting non-homzygous recessive hetero/homo-recessive parents
    ) / choices
}
fn main() {
    let input = read_base_string_file("mendels1stlaw/rosalind_iprb.txt");
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
