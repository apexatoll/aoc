class Opcode
	attr_accessor 
	def initialize
		@cmds = File.read("input").split(",").map(&:to_i)
		@index = 0
		@cmds[1] = 12
		@cmds[2] = 2
	end
	def run
		while
			i1 = @cmds[@index + 1]
			i2 = @cmds[@index + 2]
			i3 = @cmds[@index + 3]
			case @cmds[@index]
			when 1
				@cmds[i3] = @cmds[i1] + @cmds[i2]
			when 2
				@cmds[i3] = @cmds[i1] * @cmds[i2]
			when 99
				break
			end
			@index += 4
		end
		return @cmds[0]
	end
end
op = Opcode.new
puts op.run
