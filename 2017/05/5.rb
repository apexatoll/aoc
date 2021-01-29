class Solve
	def initialize
		@cmds = File.readlines("input").map(&:chomp).map(&:to_i)
		@i, @steps = 0, 0
	end
	def part_one
		while @i >= 0 && @i < @cmds.count
			index = @i
			@i += @cmds[index]
			@cmds[index] += 1
			@steps += 1
		end
		@steps
	end
	def part_two
		initialize
		while @i >= 0 && @i < @cmds.count
			index = @i
			@i += @cmds[index]
			@cmds[index] >= 3 ? 
				@cmds[index] -= 1 :
				@cmds[index] += 1
			@steps += 1
		end
		@steps
	end
end
solve = Solve.new
puts solve.part_one
puts solve.part_two
