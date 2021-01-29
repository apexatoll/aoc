class Grid
	attr_accessor :grid, :target
	def initialize
		@iterations = [20151125]
		@target = [:row, :col].zip(File.read("input").scan(/\d+/).map(&:to_i)).to_h
	end
	def run
		n = coord_to_iteration(@target)
		puts get_iteration(n)
	end
	def coord_to_iteration(coord)
		iteration = (1..coord[:col]).to_a.reduce(:+)
		(coord[:row] - 1).times{|i| iteration += coord[:col] + i}
		iteration
	end
	def get_iteration(n)
		(n-1).times{@iterations << (@iterations.last * 252533) % 33554393}
		@iterations.last
	end
end
Grid.new.run
