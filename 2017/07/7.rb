class Program
	attr_accessor :name, :weight, :children, :stack
	def initialize(line)
		ps = line.scan(/\b[a-z]+\b/)
		@name = ps.first.to_s
		@children = ps.drop(1)
		@weight = line.scan(/\d+/).first.to_i
	end
end
class Tree
	attr_accessor :root
	def initialize
	end
	def find_root
	end
	#def weigh(stack = @root)
	#end
end
$file = "input"
solve = Tree.new
solve.find_root
