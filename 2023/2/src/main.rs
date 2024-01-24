use std::str::FromStr;

mod solution {
    use super::*;

    struct Set {
        n_red: usize,
        n_green: usize,
        n_blue: usize,
    }

    impl Set {
        const RED_COUNT: usize = 12;
        const GREEN_COUNT: usize = 13;
        const BLUE_COUNT: usize = 14;

        pub fn is_possible(&self) -> bool {
            self.n_red <= Self::RED_COUNT &&
            self.n_green <= Self::GREEN_COUNT &&
            self.n_blue <= Self::BLUE_COUNT
        }
    }

    impl FromStr for Set {
        type Err = ();

        fn from_str(str: &str) -> Result<Self, Self::Err> {
            let mut set = Self { n_red: 0, n_green: 0, n_blue: 0 };

            for tally in str.split(", ") {
                let (count, colour) = tally.split_once(" ").unwrap();

                match colour {
                    "red"   => set.n_red = count.parse().unwrap(),
                    "green" => set.n_green = count.parse().unwrap(),
                    "blue"  => set.n_blue = count.parse().unwrap(),
                    _       => panic!(),
                }
            }

            Ok(set)
        }
    }

    struct Game {
        id: usize,
        sets: Vec<Set>,
    }

    impl Game {
        pub fn is_possible(&self) -> bool {
            self.sets.iter().all(|set| set.is_possible())
        }
    }

    impl FromStr for Game {
        type Err = ();

        fn from_str(str: &str) -> Result<Self, Self::Err> {
            let (id_str, sets_str) = str.split_once(": ").unwrap();

            let id = id_str.strip_prefix("Game ").unwrap().parse().unwrap();

            let sets = sets_str
                .split("; ")
                .map(|set_str| Set::from_str(set_str).unwrap())
                .collect();

            Ok(Self { id, sets })
        }
    }

    pub fn part_one(input: &str) -> usize {
        input
            .lines()
            .map(|line| Game::from_str(line).unwrap())
            .filter(|game| game.is_possible())
            .map(|game| game.id)
            .sum()
    }
}

fn main() {
    let input = include_str!("../input");

    println!("Part one: {}", solution::part_one(input));
}
