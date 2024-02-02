use std::slice::Iter;

type Matrix<T> = Vec<Vec<T>>;

#[derive(Debug)]
enum Direction {
    North,
    South,
    East,
    West,
}

impl Direction {
    fn iter<'a>() -> Iter<'a, Direction> {
        const DIRECTIONS: &'static [Direction; 4] = &[
            Direction::North,
            Direction::East,
            Direction::South,
            Direction::West
        ];

        DIRECTIONS.iter()
    }
}

#[derive(Clone, Debug, Eq, PartialEq)]
enum Tile {
    Vertical,
    Horizontal,
    NorthEast,
    NorthWest,
    SouthWest,
    SouthEast,
    Ground,
    Start,
}

impl Tile {
    fn is_corner(&self) -> bool {
        match self {
            Self::NorthEast |
            Self::NorthWest |
            Self::SouthEast |
            Self::SouthWest => true,
            _ => false
        }
    }

    fn diagonal(&self) -> Option<Self> {
        match self {
            Self::NorthEast => Some(Self::SouthWest),
            Self::NorthWest => Some(Self::SouthEast),
            Self::SouthEast => Some(Self::NorthWest),
            Self::SouthWest => Some(Self::NorthEast),
            _ => None,
        }
    }
}

impl From<char> for Tile {
    fn from(char: char) -> Self {
        match char {
            '|' => Self::Vertical,
            '-' => Self::Horizontal,
            'L' => Self::NorthEast,
            'J' => Self::NorthWest,
            '7' => Self::SouthWest,
            'F' => Self::SouthEast,
            '.' => Self::Ground,
            'S' => Self::Start,
              _ => unreachable!(),
        }
    }
}

#[derive(Clone, Debug)]
struct Cell {
    y: usize,
    x: usize,
    tile: Tile,
}

impl Cell {
    fn new(y: usize, x: usize, char: char) -> Self {
        let tile = Tile::from(char);

        Self { y, x, tile }
    }

    fn is_start(&self) -> bool {
        self.tile == Tile::Start
    }

    fn has_inbound_direction(&self, direction: &Direction) -> bool {
        match direction {
            Direction::North => match self.tile {
                Tile::Vertical | Tile::SouthEast | Tile::SouthWest => true,
                _ => false,
            },
            Direction::South => match self.tile {
                Tile::Vertical | Tile::NorthEast | Tile::NorthWest => true,
                _ => false,
            },
            Direction::East => match self.tile {
                Tile::Horizontal | Tile::NorthWest | Tile::SouthWest => true,
                _ => false,
            },
            Direction::West => match self.tile {
                Tile::Horizontal | Tile::NorthEast | Tile::SouthEast => true,
                _ => false,
            },
        }
    }

    fn new_direction(&self, last_direction: &Direction) -> &Direction {
        match last_direction {
            Direction::North => match self.tile {
                Tile::Vertical => &Direction::North,
                Tile::SouthEast => &Direction::East,
                Tile::SouthWest => &Direction::West,
                _ => unreachable!()
            },
            Direction::South => match self.tile {
                Tile::Vertical => &Direction::South,
                Tile::NorthEast => &Direction::East,
                Tile::NorthWest => &Direction::West,
                _ => unreachable!()
            },
            Direction::East => match &self.tile {
                Tile::Horizontal => &Direction::East,
                Tile::NorthWest => &Direction::North,
                Tile::SouthWest => &Direction::South,
                value => unreachable!("{:?}", value),
            },
            Direction::West => match self.tile {
                Tile::Horizontal => &Direction::West,
                Tile::NorthEast => &Direction::North,
                Tile::SouthEast => &Direction::South,
                _ => unreachable!()
            },
        }
    }
}

struct Map {
    matrix: Matrix<Cell>,
    height: usize,
    width: usize,
}

impl From<&str> for Map {
    fn from(str: &str) -> Self {
        let matrix: Matrix<Cell> = str.lines().enumerate().map(|(y, line)| 
            line.chars().enumerate().map(|(x, char)|
                Cell::new(y, x, char)
            ).collect()
        ).collect();

        let height = matrix.len();
        let width = matrix.first().unwrap().len();

        Self { matrix, height, width }
    }
}

impl Map {
    fn extract_path(&self) -> Vec<Cell>{
        let mut path = vec![];
        let mut cell = self.first_cell();
        let mut dir  = self.first_directions()[0];

        while path.is_empty() || !cell.is_start() {
            path.push(cell.clone());

            cell = self.adjacent_cell(cell, dir).unwrap();

            if cell.is_start() { break }

            dir = cell.new_direction(dir);
        }

        let first_tile = self.first_tile();

        dbg!(&first_tile);

        path[0].tile = first_tile;

        path
    }

    fn first_cell(&self) -> &Cell{
        self.matrix
            .iter()
            .find(|row| row.iter().any(|cell| cell.is_start()))
            .unwrap()
            .iter()
            .find(|cell| cell.is_start())
            .unwrap()
    }

    fn first_directions(&self) -> [&Direction; 2] {
        let cell = self.first_cell();
        let mut dirs = vec![];

        for direction in Direction::iter() {
            if let Some(adjacent) = self.adjacent_cell(cell, direction) {
                if adjacent.has_inbound_direction(direction) {
                    dirs.push(direction)
                }
            }
        }

        dirs.try_into().unwrap()
    }

    fn first_tile(&self) -> Tile {
        let [first, second] = self.first_directions();

        match (first, second) {
            (Direction::North, Direction::South) |
            (Direction::South, Direction::North) => Tile::Vertical,
            (Direction::East, Direction::West) |
            (Direction::West, Direction::East) => Tile::Horizontal,
            (Direction::North, Direction::East) |
            (Direction::East, Direction::North) => Tile::NorthEast,
            (Direction::North, Direction::West) |
            (Direction::West, Direction::North) => Tile::NorthWest,
            (Direction::South, Direction::East) |
            (Direction::East, Direction::South) => Tile::SouthEast,
            (Direction::South, Direction::West) |
            (Direction::West, Direction::South) => Tile::SouthWest,
            _ => unreachable!(),
        }
    }

    fn adjacent_cell(&self, cell: &Cell, dir: &Direction) -> Option<&Cell> {
        match dir {
            Direction::North if cell.y > 0 =>  {
                Some(&self.matrix[cell.y - 1][cell.x])
            },

            Direction::South if cell.y <= self.height - 1  =>  {
                Some(&self.matrix[cell.y + 1][cell.x])
            },

            Direction::East if cell.x <= self.width - 1  =>  {
                Some(&self.matrix[cell.y][cell.x + 1])
            },

            Direction::West if cell.x > 0 =>  {
                Some(&self.matrix[cell.y][cell.x - 1])
            },

            _ => None,
        }
    }
}

struct AreaScanner {
    path: Vec<Cell>,
    height: usize,
    width: usize,
}

impl From<&str> for AreaScanner {
    fn from(str: &str) -> Self {
        let map = Map::from(str);

        Self {
            path: map.extract_path(),
            height: map.height,
            width: map.width
        }
    }
}

impl AreaScanner {
    fn calculate(&self) -> usize {
        (0..self.height).fold(0, |sum, y| sum + self.scan_row(y))
    }

    fn scan_row(&self, y: usize) -> usize {
        let mut in_loop = false;
        let mut count = 0;
        let mut last_corner = None;

        for x in 0..self.width {
            let tile = self.get_tile(y, x);

            match (tile, last_corner) {
                (Tile::Ground, _) if in_loop => {
                    count += 1
                },

                (Tile::Vertical, _) => {
                    in_loop = !in_loop
                },

                (this, None) if this.is_corner() => {
                    last_corner = Some(this);
                },

                (this, Some(last)) if this.is_corner() => {
                    last_corner = None;

                    if last == &this.diagonal().unwrap() {
                        in_loop = !in_loop
                    }
                },

                _ => (),
            }
        }

        count
    }

    fn get_tile(&self, y: usize, x: usize) -> &Tile {
        self.path
            .iter()
            .find(|cell| cell.y == y && cell.x == x)
            .and_then(|cell| Some(&cell.tile))
            .unwrap_or(&Tile::Ground)
    }
}

fn part_one(input: &str) -> usize {
    let map = Map::from(input);
    let path = map.extract_path();

    path.len() / 2
}

fn part_two(input: &str) -> usize {
    let scanner = AreaScanner::from(input);

    scanner.calculate()
}

fn main() {
    let input = include_str!("../input");

    println!("Part one: {}", part_one(input));
    println!("Part two: {}", part_two(input));
}
