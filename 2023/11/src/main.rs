#[derive(Debug)]
struct Galaxy {
    y: usize,
    x: usize,
}

struct Image {
    height: usize,
    width: usize,
    galaxies: Vec<Galaxy>,
}

impl From<&str> for Image {
    fn from(str: &str) -> Self {
        let mut galaxies = Vec::new();

        for (y, line) in str.lines().enumerate() {
            for (x, char) in line.chars().enumerate() {
                match char {
                    '#' => galaxies.push(Galaxy { y, x }),
                      _ => ()
                }
            }
        }

        let height = str.lines().count();
        let width = str.lines().next().unwrap().chars().count();

        let mut image = Self { height, width, galaxies };

        image.expand_space();

        image
    }
}

impl Image {
    fn expand_space(&mut self) {
        let blank_rows: Vec<usize> = (0..self.height).filter(|y|
            !self.galaxies.iter().any(|galaxy| &galaxy.y == y)
        ).collect();

        let blank_columns: Vec<usize> = (0..self.width).filter(|x|
            !self.galaxies.iter().any(|galaxy| &galaxy.x == x)
        ).collect();

        for galaxy in self.galaxies.iter_mut() {
            galaxy.y += blank_rows.iter().filter(|&col| col < &galaxy.y).count();
            galaxy.x += blank_columns.iter().filter(|&col| col < &galaxy.x).count();
        }

        dbg!(&self.galaxies);
    }

    fn permutations(&self) -> Vec<(&Galaxy, &Galaxy)> {
        let mut permutations = Vec::new();

        for (i, first) in self.galaxies.iter().enumerate() {
            for second in self.galaxies.iter().skip(i + 1) {
                let permutation = (first, second);

                permutations.push(permutation);
            }
        }

        permutations
    }

    fn distances(&self) -> Vec<usize> {
        self.permutations().iter().map(|(first, second)|
            (first.y as isize - second.y as isize).abs() as usize +
            (first.x as isize - second.x as isize).abs() as usize
        ).collect()
    }
}

fn part_one(input: &str) -> usize{
    let image = Image::from(input);

    image.distances().iter().sum()
}

fn main() {
    let input = include_str!("../input");

    println!("Part one: {}", part_one(input));
}
