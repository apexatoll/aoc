struct Sequence {
    values: Vec<i64>,
}

impl From<&str> for Sequence {
    fn from(str: &str) -> Self {
        let values = str
            .split_whitespace()
            .map(|int| int.parse().unwrap())
            .collect();

        Self { values }
    }
}

impl Sequence {
    fn extrapolate(&self) -> i64 {
        if self.is_all_zero() { return 0 }

        self.last_value() + self.differentiate().extrapolate()
    }

    fn differentiate(&self) -> Self {
        let values = self
            .values
            .windows(2)
            .map(|slice| slice[1] - slice[0])
            .collect();

        Self { values }
    }

    fn is_all_zero(&self) -> bool {
        self.values.iter().all(|val| val == &0)

    }

    fn last_value(&self) -> i64 {
        *self.values.last().unwrap()
    }
}

fn part_one(input: &str) -> i64 {
    let sequences: Vec<Sequence> = input
        .lines()
        .map(|line| Sequence::from(line))
        .collect();

    sequences.iter().map(|seq| seq.extrapolate()).sum()
}

fn main() {
    let input = include_str!("../input");

    println!("Part one: {}", part_one(input));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_solves_part_one() {
        let input = include_str!("../example");

        assert_eq!(part_one(input), 114);
    }
}
