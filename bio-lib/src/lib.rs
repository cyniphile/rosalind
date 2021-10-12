use std::fs;

pub fn read_base_string_file(path: &str) -> String {
    let file = fs::read_to_string(path).expect("fuck");
    file.to_uppercase().trim().to_string()
}
