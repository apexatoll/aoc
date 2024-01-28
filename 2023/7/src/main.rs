use itertools::Itertools;

#[derive(Debug, Eq, PartialEq, Hash, Ord, PartialOrd)]
enum Card {
    Two,
    Three,
    Four,
    Five,
    Six,
    Seven,
    Eight,
    Nine,
    Ten,
    Jack,
    Queen,
    King,
    Ace,
}

impl From<char> for Card {
    fn from(char: char) -> Self {
        match char {
            '2' => Self::Two,
            '3' => Self::Three,
            '4' => Self::Four,
            '5' => Self::Five,
            '6' => Self::Six,
            '7' => Self::Seven,
            '8' => Self::Eight,
            '9' => Self::Nine,
            'T' => Self::Ten,
            'J' => Self::Jack,
            'Q' => Self::Queen,
            'K' => Self::King,
            'A' => Self::Ace,
            _   => unreachable!(),
        }
    }
}

#[derive(Debug, Eq, PartialEq, Ord, PartialOrd)]
enum HandType {
    HighCard,
    OnePair,
    TwoPair,
    ThreeOfAKind,
    FullHouse,
    FourOfAKind,
    FiveOfAKind,
}

impl From<&Vec<Card>> for HandType {
    fn from(cards: &Vec<Card>) -> Self {
        let card_counts = cards.iter().counts();

        let occurrences: [usize; 5] = cards
            .iter()
            .map(|card| card_counts.get(card).unwrap())
            .cloned()
            .sorted()
            .collect::<Vec<_>>()
            .try_into()
            .unwrap();

        match occurrences {
            [1, 1, 1, 1, 1] => Self::HighCard,
            [1, 1, 1, 2, 2] => Self::OnePair,
            [1, 2, 2, 2, 2] => Self::TwoPair,
            [1, 1, 3, 3, 3] => Self::ThreeOfAKind,
            [2, 2, 3, 3, 3] => Self::FullHouse,
            [1, 4, 4, 4, 4] => Self::FourOfAKind,
            [5, 5, 5, 5, 5] => Self::FiveOfAKind,
            value => unreachable!("Value is {:?}", value),
        }
    }
}

#[derive(Debug, Eq, PartialEq, PartialOrd)]
struct Hand {
    cards: Vec<Card>,
    bid: usize,
    hand_type: HandType,
}

impl From<&str> for Hand {
    fn from(str: &str) -> Self {
        let (cards_str, bid_str) = str.split_once(" ").unwrap();

        let cards = cards_str.chars().map(|char| Card::from(char)).collect();
        let bid = bid_str.parse().unwrap();
        let hand_type = HandType::from(&cards);

        Self { cards, bid, hand_type }
    }
}

impl Ord for Hand {
    fn cmp(&self, other: &Hand) -> std::cmp::Ordering {
        if self.hand_type != other.hand_type {
            return self.hand_type.cmp(&other.hand_type);
        }

        let cards_iter = self.cards.iter().zip(other.cards.iter());

        for (card, other_card) in cards_iter {
            if card != other_card { return card.cmp(other_card) }
        }

        std::cmp::Ordering::Equal
    }
}

impl Hand {
    fn winnings(&self, rank: usize) -> usize {
        self.bid * rank
    }
}

struct Game {
    hands: Vec<Hand>,
}

impl Game {
    fn new(input: String) -> Self {
        let mut hands: Vec<Hand> = input
            .lines()
            .map(|line| Hand::from(line))
            .collect();

        hands.sort_by(|a, b| a.cmp(b));

        Self { hands }
    }

    fn total_winnings(&self) -> usize {
        self.hands
            .iter()
            .enumerate()
            .map(|(position, card)| card.winnings(position + 1))
            .sum()
    }
}

fn part_one(input: &str) -> usize {
    Game::new(input.to_string()).total_winnings()
}

fn main() {
    let input = include_str!("../input");

    println!("Part one: {}", part_one(input));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_parses_five_of_a_kind() {
        let hand = Hand::from("AAAAA 0");

        assert_eq!(hand.hand_type, HandType::FiveOfAKind);
    }

    #[test]
    fn it_parses_four_of_a_kind() {
        let hand = Hand::from("AAKAA 0");

        assert_eq!(hand.hand_type, HandType::FourOfAKind);
    }

    #[test]
    fn it_parses_full_house() {
        let hand = Hand::from("KAKAA 0");

        assert_eq!(hand.hand_type, HandType::FullHouse);
    }

    #[test]
    fn it_parses_three_of_a_kind() {
        let hand = Hand::from("KAQAA 0");

        assert_eq!(hand.hand_type, HandType::ThreeOfAKind);
    }

    #[test]
    fn it_parses_two_pair() {
        let hand = Hand::from("QAQKA 0");

        assert_eq!(hand.hand_type, HandType::TwoPair);
    }

    #[test]
    fn it_parses_one_pair() {
        let hand = Hand::from("QTQKA 0");

        assert_eq!(hand.hand_type, HandType::OnePair);
    }

    #[test]
    fn it_parses_high_card() {
        let hand = Hand::from("QT7KA 0");

        assert_eq!(hand.hand_type, HandType::HighCard);
    }

    #[test]
    fn it_solves_part_one() {
        let example = include_str!("../example");
        let game = Game::new(example.to_string());

        assert_eq!(game.total_winnings(), 6440)
    }
}
