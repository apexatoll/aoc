$commands = File.open("input").read.to_s.chomp.split(",")
input = 1.to_i
index = 0

class Command
	attr_accessor :index, :op, :num1, :num2, :num3, :ioIndex, :num1mode, :num2mode
	def initialize(index)
		@index = index
	end
	def getOpcode
		#@op = $commands[@index]
		#@op = "1001"
		split = @op.split("").reverse
		case @op
		when /.*[12]$/
			num1index = $commands[@index + 1].to_i
			num2index = $commands[@index + 2].to_i
			@num3 = $commands[@index + 3].to_i
			if split.length > 2; then
				self.getModes(split)
				case @num1mode
					when 0; @num1 = $commands[num1index]
					when 1; @num1 = num1index
				end
				case @num2mode
					when 0; @num2 = $commands[num2index]
					when 1; @num2 = num2index
				end
			else
				@num1 = $commands[num1index]
				@num2 = $commands[num2index]
			end
		when /.*[34]$/
			@ioIndex = $commands[@index + 1].to_i
		end
	end
	def getModes(split)
		if split[2].empty? ? num1mode = 0 : @num1mode = split[2]; end
		if split[3].empty? ? num1mode = 0 : @num2mode = split[3]; end
	end
end

command = $commands[index]
#if command.to_i == 99; then break end
cmd = Command.new(index)
cmd.getOpcode()
puts cmd.num1mode
puts cmd.num2mode
#puts cmd.ioIndex

