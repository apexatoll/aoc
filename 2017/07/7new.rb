class Node
	attr_accessor :name, :children, :weight, :stack_weight
	def initialize(name)
		@name = name
		line = File.readlines("input").grep(/^#{@name}/).first
		@weight   = line.scan(/\d+/).first.to_i
		@children = line.match(/(?<=->\s).*$/).to_s.split(", ")
	end
	def has_children?
		@children.count > 0 
	end
end
class Tree
	attr_accessor :root, :nodes
	def initialize
		@nodes = File.read("input").scan(/[a-z]+/).uniq.map{|p| Node.new(p)}
		@root = find_root
		@prev_stacks = []
	end
	def find_root
		has_children = @nodes.select{|n| n.has_children?}
		root_name = (has_children.map{|n| n.name} - 
			 has_children.flat_map{|n| n.children}.uniq).first
		get_node(root_name)
	end
	def get_node(name)
		@nodes.find{|node| node.name == name}
	end
	def weigh_stack(node)
		node.has_children? ?
			node.stack_weight = node.weight + node.children.map{|c| weigh_stack(get_node(c))}.reduce(:+) :
			node.stack_weight = node.weight
	end
	def find_fault(node = @root)
		children = node.children.map{|c| get_node(c)}
		weights = children.map{|c| c.stack_weight}
		fault = weights.detect{|w| weights.count(w) == 1} 
		if fault != nil
			@prev_stacks << weights.detect{|w| weights.count(w) > 1}
			find_fault(children.select{|c| c.stack_weight == fault}.first) 
		else node.weight - (node.stack_weight - @prev_stacks.last) end
	end
end
class Solve
	def initialize
		@tree = Tree.new
	end
	def part_one
		"Root node = #{@tree.root.name}"
	end
	def part_two
		@tree.nodes.each{|node| @tree.weigh_stack(node)}
		"New weight = #{@tree.find_fault}"
	end
end
solve = Solve.new
puts solve.part_one
puts solve.part_two
