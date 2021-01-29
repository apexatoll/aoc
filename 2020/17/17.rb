class Cubes
	def initialize
		@cubes = {}
		@cubes[0] = File.readlines("example").map{|l| l.chomp.split("")}
		@coord_map = [-1, 0, 1].repeated_permutation(3).to_a
		@coord_map.delete([0, 0, 0])
		@l = @cubes[0].count
		@z = 0
	end
	def add_empty
		@l+=2
		@cubes.each{|n, slice| slice.each{|row| row.prepend(".")
			row.push(".")}
			slice.prepend(Array.new(@l, "."));
			slice.push(Array.new(@l, "."))}
		[1, -1].each{|i| @cubes[@z + i] = Array.new(@l){Array.new(@l, ".")}}
	end
	def count_neighbours(slice, row, col)
		@coord_map.map{|c| [slice + c[0], row + c[1], col + c[2]]}
			.select{|c| @cubes.key?(c[0])}
			.select{|c| c[1] < @l && c[2] < @l}
			.select{|c| c[1] >= 0 && c[2] >= 0}
			.map{|c| @cubes[c[0]][c[1]][c[2]]}
			.select{|c| c == "#"}
			.count
	end
	def run
		#2.times do
		add_empty
		next_block = {}
		@cubes.each do |n, slice|
			next_block[n] = slice.map.with_index do |row, r|
				row.map.with_index do |cube, c|
					count = count_neighbours(n, r, c)
					case cube
					when "." then count == 3 ? "#" : "."
					when "#" then count == 2 || count == 3 ? "#" : "." end
				end
			end
		end
		@cubes = next_block
		#end
		@cubes.each{|n, slice| slice.each{|r| print r; puts}; puts}
	end
end
Cubes.new.run
