use std::collections::HashMap;
use std::collections::VecDeque;
use regex::Regex;

type Nodes<'a> = HashMap<&'a str, Node<'a>>;

#[derive(Debug)]
struct Node<'a> {
    name: &'a str,
    left: &'a str,
    right: &'a str,
}

impl<'a> From<&'a str> for Node<'a> {
    fn from(str: &'a str) -> Self {
        let template = Regex::new(
            r"^([A-Z]{3}) = \(([A-Z]{3}), ([A-Z]{3})\)$"
        ).unwrap();

        let (_, [name, left, right]) = template
            .captures(&str)
            .unwrap()
            .extract();

        Self { name, left, right }
    }
}

#[derive(Clone, Debug)]
enum Command { Left, Right }

impl From<char> for Command {
    fn from(char: char) -> Self {
        match char {
            'L' => Self::Left,
            'R' => Self::Right,
            _ => unreachable!(),
        }
    }
}

#[derive(Debug)]
struct Tree<'a> {
    nodes: Nodes<'a>,
    commands: Vec<Command>,
}

impl<'a> From<&'a str> for Tree<'a> {
    fn from(str: &'a str) -> Self {
        let (cmd_str, tree_str) = str.split_once("\n\n").unwrap();

        let commands = cmd_str
            .chars()
            .map(|char| Command::from(char))
            .collect();

        let mut nodes = Nodes::new();

        for line in tree_str.lines() {
            let node = Node::from(line);

            nodes.insert(node.name, node);
        }

        Self { nodes, commands }
    }
}

impl<'a> Tree<'a> {
    fn node(&self, name: &str) -> &Node {
        self.nodes.get(name).unwrap()
    }

    fn next(&self, current: &Node, command: Command) -> Option<&Node> {
        match command {
            Command::Left  => self.next_left(current),
            Command::Right => self.next_right(current),
        }
    }

    fn next_left(&self, current: &Node) -> Option<&Node> {
        if current.name == current.left { return None }

        Some(self.node(current.left))
    }

    fn next_right(&self, current: &Node) -> Option<&Node> {
        if current.name == current.right { return None }

        Some(self.node(current.right))
    }

    fn step_until<F>(&self, from: &str, condition_met: F) -> usize where 
        F: Fn(&Node) -> bool
    {
        let mut steps_taken = 0;
        let mut current_node = self.node(from);

        loop {
            let mut queue: VecDeque<Command> = self.commands.clone().into();

            while let Some(command) = queue.pop_front() {
                if condition_met(&current_node) { return steps_taken }

                steps_taken += 1;
                current_node = self.next(current_node, command).unwrap();
            }
        }
    }
}

fn part_one(input: &str) -> usize {
    let tree = Tree::from(input);

    tree.step_until("AAA", |node| node.name == "ZZZ")
}

fn main() {
    let input = include_str!("../input");

    println!("Part one: {}", part_one(input));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_solves_part_one() {
        let input = include_str!("../example");

        assert_eq!(part_one(input), 6);
    }
}
