use std::str::FromStr;

struct Card {
    winning_numbers: Vec<u32>,
    own_numbers: Vec<u32>,
}

impl Card {
    fn number_of_matches(&self) -> usize {
        self.own_numbers
            .iter()
            .filter(|number| self.winning_numbers.contains(&number))
            .count()
    }

    fn points(&self) -> u32 {
        match self.number_of_matches() {
            0 => 0,
            matches @_ => (2 as u32).pow(matches as u32 - 1),
        }
    }
}

impl FromStr for Card {
    type Err = ();

    fn from_str(str: &str) -> Result<Self, Self::Err> {
        let (_, numbers_part) = str.split_once(": ").unwrap();
        let (winning_part, own_part) = numbers_part.split_once(" | ").unwrap();

        let winning_numbers: Vec<u32> = winning_part
            .split_whitespace()
            .map(|int| int.parse().unwrap())
            .collect();

        let own_numbers: Vec<u32> = own_part
            .split_whitespace()
            .map(|int| int.parse().unwrap())
            .collect();

        Ok(Self { winning_numbers, own_numbers })
    }
}

fn part_one(input: &str) -> u32 {
    input
        .lines()
        .map(|line| Card::from_str(line).unwrap())
        .map(|card| card.points())
        .sum()
}

fn main() {
    let input = include_str!("../input");

    println!("Part one: {}", part_one(input));
}
