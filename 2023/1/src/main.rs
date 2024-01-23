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

    pub fn part_one(input: &str) -> u32 {
        input
            .lines()
            .map(|line| DigitScanner { line: line.to_string() })
            .map(|scanner| scanner.value())
            .sum()
    }
}

fn main() {
    let input = include_str!("../input");

    println!("Part one: {}", solution::part_one(&input));
}
