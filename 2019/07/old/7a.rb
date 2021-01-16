class Command
	attr_accessor :cmds, :index, :cmd, :type, :modes, :nums
	def initialize(commands, index, input, phase)
		@cmds  = commands
		@index = index
		@input = input
		@phase = phase
		@cmd = commands[index].to_s.split("").map(&:to_i).reverse
		decode
	end
	def decode
		@type = [@cmd[1], @cmd[0]].join.to_i
		@modes = Hash.new
		@nums  = Array.new
		case @type
		when 1, 2, 5..8
			@modes[:n1] = @cmd[2].nil? ? 0 : @cmd[2]
			@modes[:n2] = @cmd[3].nil? ? 0 : @cmd[3]
			get_nums
			@nums << @cmds[@index + 3]
		when 3
			@nums[0] = @cmds[@index + 1]
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
			output[:add] = @nums[0]
			output[:ind] = @index += 2
		when 4
			output[:val] = @nums[0]
			output[:add] = false
			output[:ind] = @index += 2
		when 5
			output[:ind] = @nums[0] != 0? @nums[1] : @index+=3
		when 6
			output[:ind] = @nums[0] == 0? @nums[1] : @index+= 3
		when 7
			output[:val] = @nums[0] < @nums[1]? 1 : 0
			output[:add] = @nums[2]
			output[:ind] = @index += 4
		when 8
			output[:val] = @nums[0] == @nums[1]? 1 : 0
			output[:add] = @nums[2]
			output[:ind] = @index += 4
		end
		return output
	end
end
class Opcode
	attr_accessor :output
	def initialize
		load_commands
	end
	def run(input, phase)
		initiated = false
		while
			cmd = Command.new(@cmds, @index, input, phase)
			out = cmd.execute
			return @output if cmd.type == 99
			if out[:add] == false
				@output = out[:val]
			elsif cmd.type == 3
				if initiated == false
					@cmds[out[:add]] = phase
					initiated = true
				else
					@cmds[out[:add]] = input
				end
			elsif not out[:val].nil?
				@cmds[out[:add]] = out[:val]
			end
			@index = out[:ind]
		end
	end
	def load_commands
		@cmds = File.read("input").split(",").map(&:to_i)
		@index = 0
	end
end
class Amplifiers
	attr_accessor :opcode
	def initialize
		@opcode = Opcode.new
	end
	def run
		@signals = Array.new
		@perm = [4, 3, 2, 1, 0].permutation(5).to_a.each do |p|
			@signal = 0 
			p.each do |phase|
				@signal = @opcode.run(@signal, phase)
				@signals << @signal
				@opcode.load_commands
			end
		end
		print @signals.sort.last
	end
end
amps = Amplifiers.new
amps.run
