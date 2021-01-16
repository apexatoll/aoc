class Opcode
	attr_accessor 
	def initialize
		@cmds = File.read("input").split(",").map(&:to_i)
		@target = 19690720
	end
	def run(noun, verb)
		local = @cmds.dup
		local[1] = noun
		local[2] = verb
		index = 0
		while
			i1 = local[index + 1]
			i2 = local[index + 2]
			i3 = local[index + 3]
			case local[index]
			when 1
				local[i3] = local[i1] + local[i2]
			when 2
				local[i3] = local[i1] * local[i2]
			when 99
				return local[0]
			end
			index += 4
		end
	end
	def part_two
		for i in 0..99
			for j in 0..99
				return (100 * i) + j if self.run(i, j) == @target
			end
		end
	end
end
op = Opcode.new
puts op.part_two
