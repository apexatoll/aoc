class Node
	attr_accessor
	def initialize(x, y)
		
	end
end
class Solve
	def initialize
		@number = 10
		@queue = [{:x => 0, :y => 0}]
	end
	def coord_to_type(coord)
		([x * x, 3 * x, 2 * x * y, y, y * y]
			.reduce(:+) + @number)
			.to_s(2).split("").map(&:to_i)
			.select{|b| b == 1}.count.even? ? "." : "#"
	end
	#def make_grid
		#@grid = Array.new(7){Array.new(10, 0)}
			#.map.with_index{|row, i| row.map
			#.with_index{|space, col| coord_to_type(col, i)}}
		#@grid.each{|row| print row; puts}
	#end
	def find_path(coord = @queue.first)
		puts coord
	end
end
Solve.new.find_path
