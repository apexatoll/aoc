class Solve
	def initialize
		@input = 277678
		#@input = 1024
		#@grid = Hash.new
		#@grid = Array.new(100000){Array.new(100000)}

		#@grid[100,20.to_s] = 1
		#print @grid
		#@x, @y = 50000, 50000
		@x, @y = 0, 0
		@dirs = [:L, :U, :R, :D]
		@l, @n = 1, 1
	end
	def part_one
		dir = @dirs.first
		#@grid[@y][@x] = @n
		@n+=1
		while @n < @input
			2.times do
				@l.times do |i|
					#puts @n
					case dir
					when :L then @x += 1
					when :U then @y += 1
					when :R then @x -= 1
					when :D then @y -= 1
					end
					#@grid[@y][@x] = @n
					if @n == @input
						@targ = @x, @y
					end
					@n += 1
				end
				dir = @dirs.rotate!.first
			end
			@l += 1
		end
		puts @targ.map{|c| c.abs}.reduce(:+)
		#@grid.each{|row| print row; puts}
	end
	def find_target
		#@grid.select{|row| row.include? @input}.index
		#@grid.index(@input)
	end
end
solve = Solve.new
solve.part_one
#puts solve.find_target
