class Command
	attr_accessor :cmds, :index, :cmd, :type, :modes, :nums
	def initialize(commands, index, input)
		@cmds  = commands
		@index = index
		@input = input
		@cmd = commands[index].to_s.split("").map(&:to_i).reverse
		decode
	end
	def get_addr

	end
	def decode
		@type = [@cmd[1], @cmd[0]].join.to_i
		@modes = Hash.new
		@nums  = Array.new
		case @type
		when 1, 2
			@modes[:n1] = @cmd[2].nil? ? 0 : @cmd[2]
			@modes[:n2] = @cmd[3].nil? ? 0 : @cmd[3]
			get_nums
			@nums << @cmds[@index + 3]
		when 3
			mode = @cmd[2].nil? ? 0 : @cmd[2]
			case mode
			when 0
				@nums[0] = @cmds[@cmds[@index + 1]]
			when 1
				@nums[0] = @cmds[@index + 1]
			end
		when 4
			mode = @cmd[2].nil? ? 0 : @cmd[2]
			case mode
			when 0
				@nums[0] = @cmds[@cmds[@index + 1]]
			when 1
				@nums[0] = @cmds[@index + 1]
			end
		end
	end
	def get_nums
		@modes.values.each.with_index(1) do |mode, i|
			if mode == 1
				@nums << @cmds[@index + i]
			elsif mode == 0
				@nums << @cmds[@cmds[@index + i]]
			end
		end
	end
	def execute
		output = Hash.new
		case @type
		when 1
			output[:val] = @nums[0] + @nums[1]
			output[:add] = @nums[2]
			output[:ind] = @index += 4
		when 2
			output[:val] = @nums[0] * @nums[1]
			output[:add] = @nums[2]
			output[:ind] = @index += 4
		when 3
			output[:val] = @input
			output[:add] = @cmds[@index + 1]
			output[:ind] = @index += 2
		when 4
			output[:val] = @nums[0]
			output[:add] = false
			output[:ind] = @index += 2
		when 99
			output[:stop] = true
		end
		return output
	end
end
class Opcode
	attr_accessor :output
	def initialize
		@cmds = File.read("input").split(",").map(&:to_i)
		@index = 0
	end
	def run(input)
		while
			cmd = Command.new(@cmds, @index, input)
			out = cmd.execute
			return if cmd.type == 99
			if out[:add] == false
				puts out[:val]
			else
				@cmds[out[:add]] = out[:val]
			end
			@index = out[:ind]
		end
	end
end
op = Opcode.new
op.run(1)
