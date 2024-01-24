mod solution {
    trait Scanner {
        fn value(&self) -> u32 {
            10 * self.first_value().unwrap() + self.last_value().unwrap()
        }

        fn first_value(&self) -> Option<u32>;

        fn last_value(&self) -> Option<u32>;
    }

    struct DigitScanner {
        line: String,
    }

    impl Scanner for DigitScanner {
        fn first_value(&self) -> Option<u32> {
            self.line
                .chars()
                .find(|char| char.is_digit(10))
                .unwrap()
                .to_digit(10)
        }

        fn last_value(&self) -> Option<u32> {
            self.line
                .chars()
                .rfind(|char| char.is_digit(10))
                .unwrap()
                .to_digit(10)
        }
    }

    struct DigitAndWordScanner {
        line: String,
    }

    impl DigitAndWordScanner {
        const WORDS: [&'static str; 9] = [
            "one",
            "two",
            "three",
            "four",
            "five",
            "six",
            "seven",
            "eight",
            "nine",
        ];
    }

    impl Scanner for DigitAndWordScanner {
        fn first_value(&self) -> Option<u32> {
            for (char_index, char) in self.line.chars().enumerate() {
                if char.is_digit(10) { return char.to_digit(10) }

                for (word_index, &word) in Self::WORDS.iter().enumerate() {
                    let value = word_index as u32 + 1;

                    if self.line.len() - char_index < word.len() { continue }

                    let slice = &self.line[char_index..char_index + word.len()];

                    if slice == word { return Some(value) }
                }
            }

            None
        }

        fn last_value(&self) -> Option<u32> {
            for (index, char) in self.line.chars().rev().enumerate() {
                if char.is_digit(10) { return char.to_digit(10) }

                for (word_index, &word) in Self::WORDS.iter().enumerate() {
                    let char_index = self.line.len() - index - 1;
                    let value = word_index as u32 + 1;

                    if self.line.len() - char_index < word.len() { continue }

                    let slice = &self.line[char_index..char_index + word.len()];

                    if slice == word { return Some(value) }
                }
            }

            None
        }
    }

    pub fn part_one(input: &str) -> u32 {
        input
            .lines()
            .map(|line| DigitScanner { line: line.to_string() })
            .map(|scanner| scanner.value())
            .sum()
    }

    pub fn part_two(input: &str) -> u32 {
        input
            .lines()
            .map(|line| DigitAndWordScanner { line: line.to_string() })
            .map(|scanner| scanner.value())
            .sum()
    }
}

fn main() {
    let input = include_str!("../input");

    println!("Part one: {}", solution::part_one(&input));
    println!("Part two: {}", solution::part_two(&input));
}

#[cfg(test)]
mod tests {
    use super::solution::*;

    #[test]
    fn it_completes_part_one() {
        let input = include_str!("../example_one");

        let answer = part_one(&input);

        assert_eq!(answer, 142);
    }

    #[test]
    fn it_completes_part_two() {
        let input = include_str!("../example_two");

        let answer = part_two(&input);

        assert_eq!(answer, 281);
    }
}
