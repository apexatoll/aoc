class Grid
	def initialize
		@grid = File.readlines("input").map{|l| l.chomp.split("")}
		@l = @grid.length
		@corners = [[0, 0], [0, @l - 1], [@l - 1, 0], [@l - 1, @l - 1]]
		@corners.each{|c| x, y = c; @grid[x][y] = "#"}
	end
	def solve(n)
		n.times{tick}
		count_on
	end
	def tick
		@grid = @grid.map.with_index do |row, y|
			row.map.with_index do |cell, x|
				n_on = count_neighbours(x, y)
				if @corners.include? [x, y] then "#"
				else case cell
					when "#" then n_on == 2 || n_on == 3 ? "#" : "."
					when "." then n_on == 3 ? "#" : "." end
				end
			end
		end
	end
	def count_neighbours(x, y)
		range = [-1, 0, 1]
		range.map{|row| range.map{|col| [x + col, y + row]}}
			.flatten(1)
			.reject{|x1, y1| x1 < 0 || x1 >= @l || y1 < 0 || y1 >= @l}
			.reject{|x1, y1| x1 == x && y1 == y}
			.map{|x1, y1| [x1, y1] - @corners}
			.map{|x1, y1| @grid[y1][x1]}
			.select{|c| c == "#"}
			.count
	end
	def count_on
		@grid.flatten.select{|c| c == "#"}.count
	end
end
grid = Grid.new
puts grid.solve(100)
