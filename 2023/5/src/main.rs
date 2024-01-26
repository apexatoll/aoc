use std::str::FromStr;

#[derive(Debug, PartialEq)]
enum Category {
    Seed,
    Soil,
    Fertilizer,
    Water,
    Light,
    Temperature,
    Humidity,
    Location,
}

impl FromStr for Category {
    type Err = ();

    fn from_str(str: &str) -> Result<Self, Self::Err> {
        match str {
            "seed"        => Ok(Category::Seed),
            "soil"        => Ok(Category::Soil),
            "fertilizer"  => Ok(Category::Fertilizer),
            "water"       => Ok(Category::Water),
            "light"       => Ok(Category::Light),
            "temperature" => Ok(Category::Temperature),
            "humidity"    => Ok(Category::Humidity),
            "location"    => Ok(Category::Location),
            _ => Err(()),
        }
    }
}

#[derive(Debug)]
struct MapRange {
    destination_start: u64,
    source_start: u64,
    length: u64,
}

impl MapRange {
    fn includes(&self, value: u64) -> bool {
        (self.source_start..self.source_start + self.length).contains(&value)
    }

    fn resolve(&self, value: u64) -> u64 {
        self.destination_start + (value - self.source_start)
    }
}

impl FromStr for MapRange {
    type Err = ();

    fn from_str(str: &str) -> Result<Self, Self::Err> {
        let [destination_start, source_start, length] = str
            .split_whitespace()
            .map(|int| int.parse::<u64>().unwrap())
            .collect::<Vec<u64>>()
            .try_into()
            .unwrap();

        Ok(Self { destination_start, source_start, length })
    }
}

#[derive(Debug)]
struct Map {
    source_category: Category,
    destination_category: Category,
    ranges: Vec<MapRange>,
}

impl Map {
    fn resolve(&self, value: u64) -> u64 {
        let range = self.ranges.iter().find(|range| range.includes(value));

        match range {
            Some(range) => range.resolve(value),
            None => value,
        }

    }
}

impl FromStr for Map {
    type Err = ();

    fn from_str(str: &str) -> Result<Self, Self::Err> {
        let lines: Vec<&str> = str.lines().collect();
        let (categories_str, range_strs) = lines.split_at(1);

        let raw_categories: [&str; 2] = categories_str
            .first()
            .unwrap()
            .strip_suffix("map:")
            .unwrap()
            .trim()
            .split_once("-to-")
            .unwrap()
            .try_into()
            .unwrap();

        let [source_category, destination_category] = raw_categories
            .iter()
            .map(|str| Category::from_str(str).unwrap())
            .collect::<Vec<Category>>()
            .try_into()
            .unwrap();

        let ranges = range_strs
            .iter()
            .map(|line| MapRange::from_str(line).unwrap())
            .collect();

        Ok(Self { source_category, destination_category, ranges })
    }
}

#[derive(Debug)]
struct Almanac {
    seeds: Vec<u64>,
    maps: Vec<Map>,
}

impl Almanac {
    fn location_numbers(&self) -> Vec<u64> {
        self.seeds.iter().map(|seed| self.resolve(*seed)).collect()
    }

    fn resolve(&self, seed: u64) -> u64 {
        let mut value = seed;
        let mut source = &Category::Seed;

        while let Some(next_map) = self.next_map(source) {
            source = &next_map.destination_category;
            value = next_map.resolve(value);
        }
        
        value
    }

    fn next_map(&self, source_category: &Category) -> Option<&Map> {
        self.maps.iter().find(|map| map.source_category == *source_category)
    }

    fn expand_seed_ranges(&mut self) {
        let seeds = self
            .seeds
            .chunks(2)
            .flat_map(|slice| (slice[0]..slice[0] + slice[1]).collect::<Vec<_>>())
            .collect::<Vec<u64>>();

        self.seeds = seeds;
    }
}

impl FromStr for Almanac {
    type Err = ();

    fn from_str(str: &str) -> Result<Self, Self::Err> {
        let groups: Vec<&str> = str.split("\n\n").collect();

        let (seed_str, maps_strs) = groups.split_at(1);

        let seeds = seed_str
            .first()
            .unwrap()
            .strip_prefix("seeds:")
            .unwrap()
            .trim_start()
            .split_whitespace()
            .map(|str| str.parse().unwrap())
            .collect();

        let maps = maps_strs
            .iter()
            .map(|str| Map::from_str(str).unwrap())
            .collect();

        Ok(Self { seeds, maps })
    }
}

fn part_one(input: &str) -> u64 {
    *Almanac::from_str(input).unwrap().location_numbers().iter().min().unwrap()
}

fn part_two(input: &str) -> u64 {
    let mut almanac = Almanac::from_str(input).unwrap();

    almanac.expand_seed_ranges();

    *almanac.location_numbers().iter().min().unwrap()
}

fn main() {
    let input = include_str!("../input");

    println!("Part one: {}", part_one(input));
    println!("Part two: {}", part_two(input));
}
