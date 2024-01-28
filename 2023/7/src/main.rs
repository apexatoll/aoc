use itertools::Itertools;

#[derive(Debug, Eq, PartialEq, Hash, Ord, PartialOrd)]
enum Card {
    Joker,
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
            '*' => Self::Joker,
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
        let joker_count = card_counts.get(&Card::Joker).unwrap_or(&0);

        let occurrences: [usize; 5] = cards
            .iter()
            .map(|card| card_counts.get(card).unwrap())
            .cloned()
            .sorted()
            .collect::<Vec<_>>()
            .try_into()
            .unwrap();

        match occurrences {
            [1, 1, 1, 1, 1] => match joker_count {
                0 => Self::HighCard,
                1 => Self::OnePair,
                _ => unreachable!(),
            },

            [1, 1, 1, 2, 2] => match joker_count {
                0   => Self::OnePair,
                1|2 => Self::ThreeOfAKind,
                _   => unreachable!(),
            },

            [1, 2, 2, 2, 2] => match joker_count {
                0 => Self::TwoPair,
                1 => Self::FullHouse,
                2 => Self::FourOfAKind,
                _ => unreachable!(),
            },

            [1, 1, 3, 3, 3] => match joker_count {
                0   => Self::ThreeOfAKind,
                1|3 => Self::FourOfAKind,
                _   => unreachable!(),
            },

            [2, 2, 3, 3, 3] => match joker_count {
                0   => Self::FullHouse,
                2|3 => Self::FiveOfAKind,
                _   => unreachable!(),
            },

            [1, 4, 4, 4, 4] => match joker_count {
                0   => Self::FourOfAKind,
                1|4 => Self::FiveOfAKind,
                _   => unreachable!(),
            }, 

            [5, 5, 5, 5, 5] => Self::FiveOfAKind,

            _ => unreachable!(),
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

    fn with_jokers(input: String) -> Self {
        let input = input.replace("J", "*");

        Self::new(input)
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

fn part_two(input: &str) -> usize {
    Game::with_jokers(input.to_string()).total_winnings()
}

fn main() {
    let input = include_str!("../input");

    println!("Part one: {}", part_one(input));
    println!("Part two: {}", part_two(input));
}

#[cfg(test)]
mod tests {
    use super::*;

    fn assert_hand_type(hands: Vec<&str>, hand_type: HandType) {
        let hands: Vec<Hand> = hands
            .iter()
            .map(|&line| Hand::from(line))
            .collect();

        for hand in hands.iter() {
            assert_eq!(hand.hand_type, hand_type);
        }
    }

    #[test]
    fn it_parses_five_of_a_kind() {
        let hands = vec![
            "AAAAA 0", "AAAA* 0", "AAA** 0", "AA*** 0", "A**** 0", "***** 0"
        ];

        assert_hand_type(hands, HandType::FiveOfAKind);
    }

    #[test]
    fn it_parses_four_of_a_kind() {
        let hands = vec!["AQAAA 0", "AATA* 0", "AA**Q 0", "A*T** 0"];

        assert_hand_type(hands, HandType::FourOfAKind);
    }

    #[test]
    fn it_parses_full_house() {
        let hands = vec!["KAKAA 0", "KAKA* 0"];

        assert_hand_type(hands, HandType::FullHouse);
    }

    #[test]
    fn it_parses_three_of_a_kind() {
        let hands = vec!["KAQAA 0", "KAQA* 0", "KAQ** 0"];

        assert_hand_type(hands, HandType::ThreeOfAKind);
    }

    #[test]
    fn it_parses_two_pair() {
        let hands = vec!["QAQKA 0"];

        assert_hand_type(hands, HandType::TwoPair);
    }

    #[test]
    fn it_parses_one_pair() {
        let hands = vec!["QTQKA 0", "QT*KA 0"];

        assert_hand_type(hands, HandType::OnePair);
    }

    #[test]
    fn it_parses_high_card() {
        let hands = vec!["QT7KA 0"];

        assert_hand_type(hands, HandType::HighCard);
    }

    #[test]
    fn it_solves_part_one() {
        let example = include_str!("../example");
        let game = Game::new(example.to_string());

        assert_eq!(game.total_winnings(), 6440)
    }

    #[test]
    fn it_solves_part_two() {
        let example = include_str!("../example");
        let game = Game::with_jokers(example.to_string());

        assert_eq!(game.total_winnings(), 5905)
    }
}
