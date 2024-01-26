use std::str::FromStr;

#[derive(Debug, Clone)]
struct Card {
    id: usize,
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
        let (id_part, numbers_part) = str.split_once(": ").unwrap();
        let (winning_part, own_part) = numbers_part.split_once(" | ").unwrap();

        let id = id_part
            .strip_prefix("Card")
            .unwrap()
            .trim_start()
            .parse()
            .unwrap();

        let winning_numbers: Vec<u32> = winning_part
            .split_whitespace()
            .map(|int| int.parse().unwrap())
            .collect();

        let own_numbers: Vec<u32> = own_part
            .split_whitespace()
            .map(|int| int.parse().unwrap())
            .collect();

        Ok(Self { id, winning_numbers, own_numbers })
    }
}

struct CardQueue {
    cards: Vec<Card>,
    queue: Vec<Card>,
}

impl FromStr for CardQueue {
    type Err = ();

    fn from_str(str: &str) -> Result<Self, Self::Err> {
        let cards: Vec<Card> = str
            .lines()
            .map(|line| Card::from_str(line).unwrap())
            .collect();

        let queue = cards.clone();

        Ok(Self { cards, queue })
    }
}

impl CardQueue {
    fn process(&mut self) -> usize {
        let mut total = 0;

        while !self.queue.is_empty() {
            total += 1;

            let card = self.queue.pop().unwrap();

            match card.number_of_matches() {
                0      => continue,
                num @_ => self.queue.append(&mut self.next_cards(card.id, num)),
            }
        }

        total
    }

    fn next_cards(&self, id: usize, num: usize) -> Vec<Card> {
        self.cards[id..id + num].to_vec()
    }
}

fn part_one(input: &str) -> u32 {
    input
        .lines()
        .map(|line| Card::from_str(line).unwrap())
        .map(|card| card.points())
        .sum()
}

fn part_two(input: &str) -> usize {
    CardQueue::from_str(input).unwrap().process()
}

fn main() {
    let input = include_str!("../input");

    println!("Part one: {}", part_one(input));
    println!("Part two: {}", part_two(input));
}
