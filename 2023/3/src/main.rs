use std::str::FromStr;

type Matrix<T> = Vec<Vec<T>>;

#[derive(Clone, Debug, PartialEq)]
struct Cell {
    y: usize,
    x: usize,
    value: char,
}

impl<'a> Cell {
    const OFFSETS: [i32; 3] = [-1, 0, 1];

    fn adjacent_cells(&'a self, schematic: &'a Schematic) -> Vec<&Cell> {
        let mut cells: Vec<&Cell> = vec![];

        for y_offset in Self::OFFSETS.iter() {
            for x_offset in Self::OFFSETS.iter() {
                let y = self.y as i32 + *y_offset;
                let x = self.x as i32 + *x_offset;

                if *y_offset == 0 && *x_offset == 0 { continue }

                if !schematic.is_in_bounds(y, x) { continue }

                cells.push(&schematic.matrix[y as usize][x as usize])
            }
        }

        cells
    }

    fn is_digit(&self) -> bool {
        self.value.is_digit(10)
    }

    fn is_symbol(&self) -> bool {
        !self.is_digit() && self.value != '.'
    }
}

#[derive(Clone, Debug)]
struct Number<'a> {
    cells: Vec<&'a Cell>,
    schematic: &'a Schematic,
}

impl<'a> Number<'a> {
    fn value(&self) -> usize {
        self.cells
            .iter()
            .map(|cell| cell.value)
            .collect::<String>()
            .parse()
            .unwrap()
    }

    fn is_part_number(&self) -> bool {
        self.adjacent_cells()
            .iter()
            .any(|cell| cell.is_symbol())
    }

    fn adjacent_cells(&self) -> Vec<Cell> {
        let mut adjacent_cells: Vec<Cell> = self
            .cells
            .iter()
            .flat_map(|cell| cell.adjacent_cells(self.schematic))
            .filter(|cell| !self.cells.contains(cell))
            .cloned()
            .collect::<Vec<Cell>>();

        adjacent_cells.dedup();

        adjacent_cells
    }
}

#[derive(Debug)]
struct Schematic {
    matrix: Matrix<Cell>,
    height: usize,
    width: usize,
}

impl Schematic {
    pub fn new(matrix: Matrix<Cell>) -> Self {
        let height = matrix.len();
        let width = matrix[0].len();

        Self {
            matrix,
            height,
            width,
        }
    }

    pub fn part_numbers(&self) -> Vec<Number> {
        self.scan_numbers()
            .iter()
            .filter(|number| number.is_part_number())
            .cloned()
            .collect::<Vec<Number>>()
    }

    pub fn is_in_bounds(&self, y: i32, x: i32) -> bool {
        y >= 0 && y < self.height as i32 && x >= 0 && x < self.width as i32
    }

    fn scan_numbers(&self) -> Vec<Number> {
        let mut buffer: Vec<&Cell> = vec![];
        let mut numbers: Vec<Number> = vec![];

        for row in self.matrix.iter() {
            for cell in row.iter() {
                if cell.is_digit() {
                    buffer.push(cell)
                } else if !buffer.is_empty() {
                    numbers.push(
                        Number { cells: buffer.clone(), schematic: &self }
                    );
                    buffer.clear();
                }
            }

            if !buffer.is_empty() {
                numbers.push(Number { cells: buffer.clone(), schematic: &self });
                buffer.clear();
            }
        }

        numbers
    }
}

impl FromStr for Schematic {
    type Err = ();

    fn from_str(string: &str) -> Result<Self, Self::Err> {
        let matrix: Matrix<Cell> = string
            .lines()
            .enumerate()
            .map(|(y, line)| {
                line.chars()
                    .enumerate()
                    .map(|(x, value)| Cell { y, x, value })
                    .collect()
            })
            .collect();

        Ok(Schematic::new(matrix))
    }
}

fn part_one(input: &str) -> usize {
    let schematic = Schematic::from_str(input).unwrap();

    schematic
        .part_numbers()
        .iter()
        .map(|part_number| part_number.value())
        .sum()
}

fn main() {
    let input = include_str!("../input");

    println!("Part one: {}", part_one(input));
}
