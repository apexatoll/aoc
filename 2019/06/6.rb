class Tree
	attr_reader :count, :nodes
	def initialize(file)
		@parents = File.readlines(file)
			.map{|l| l.chomp.split(")")}
			.map{|p, c| [c, p]}.to_h
		@you, @san = [], []
		@count = 0
	end
	def part_one
		@parents.each{|c, p| count_orbits(c)}
		@count
	end
	def part_two
		path("YOU", @you)
		path("SAN", @san)
		[@you, @san]
			.map{|p| p.index((@you & @san).first)}
			.reduce(:+)
	end
	def count_orbits(child)
		if child != "COM"
			@count += 1
			count_orbits(@parents[child])
		end
	end
	def path(child, store)
		if child != "COM"
			store << @parents[child]
			path(@parents[child], store)
		end
	end
end
tree = Tree.new("input")
puts tree.part_one
puts tree.part_two
