use std::str::FromStr;

#[derive(Debug)]
struct Record {
    time: usize,
    distance: usize,
}

impl Record {
    fn from_kerning_str(str: &str) -> Self {
        let (time_str, dist_str) = str.split_once("\n").unwrap();

        let time = time_str
            .strip_prefix("Time:")
            .unwrap()
            .replace(" ", "")
            .trim()
            .parse()
            .unwrap();

        let distance = dist_str
            .strip_prefix("Distance:")
            .unwrap()
            .replace(" ", "")
            .trim()
            .parse()
            .unwrap();

        Self { time, distance }
    }
}

struct Race {
    time: usize,
}

impl Race {
    fn new(time: usize) -> Self {
        Self { time }
    }

    fn distance_travelled(&self, hold_time: usize) -> usize {
        let move_time = self.time - hold_time;

        hold_time * move_time
    }
}

#[derive(Debug)]
struct Calculator {
    records: Vec<Record>,
}

impl Calculator {
    fn calculate_product(&self) -> usize {
        self.records
            .iter()
            .map(|record| self.number_of_new_records(record))
            .product()
    }

    fn number_of_new_records(&self, record: &Record) -> usize {
        let race = Race::new(record.time);

        (0..=race.time).filter(|&hold_time|
            race.distance_travelled(hold_time) > record.distance
        ).count()
    }
}

impl FromStr for Calculator {
    type Err = ();

    fn from_str(str: &str) -> Result<Self, Self::Err> {
        let (time_str, dist_str) = str.split_once("\n").unwrap();

        let times: Vec<usize> = time_str
            .split_whitespace()
            .skip(1)
            .map(|str| str.parse().unwrap()) .collect();

        let distances: Vec<usize> = dist_str
            .split_whitespace()
            .skip(1)
            .map(|str| str.parse().unwrap())
            .collect();

        let records: Vec<Record> = times
            .iter()
            .zip(distances)
            .map(|(&time, distance)| Record { time, distance })
            .collect();

        Ok(Self { records })
    }
}

fn part_one(input: &str) -> usize {
    Calculator::from_str(input).unwrap().calculate_product()
}

fn part_two(input: &str) -> usize {
    let records = vec![Record::from_kerning_str(input)];

    Calculator { records }.calculate_product()
}

fn main() {
    let input = include_str!("../input");

    println!("Part one: {}", part_one(input));
    println!("Part two: {}", part_two(input));
}

mod tests {
    #[cfg(test)]
    use super::*;

    #[test]
    fn it_solves_part_one() {
        let example = include_str!("../example");

        assert_eq!(part_one(example), 288);
    }

    #[test]
    fn it_solves_part_two() {
        let example = include_str!("../example");

        assert_eq!(part_two(example), 71503);
    }
}
