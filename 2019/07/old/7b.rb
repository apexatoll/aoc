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
	attr_accessor :output, :continue
	def initialize
		load_commands
	end
	def run(input, phase)
		initiated = false
		while
			cmd = Command.new(@cmds, @index, input, phase)
			out = cmd.execute
			if cmd.type == 99
				#return {:stop => true, :out => @output}
			end
			if out[:add] == false
				@output = out[:val]
				#return @output
				#return {:stop => false, :out => @output}
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
		@cmds = File.read("example").split(",").map(&:to_i)
		@index = 0
		@continue = true
	end
end
class Amplifier
	attr_accessor :opcode
	def initialize(phase, input)
		@opcode = Opcode.new
		@phase = phase
		@input = input
	end
end
class Amplifiers
	attr_accessor :opcode
	def initialize
		@opcode = Opcode.new
		@opcodes = 5.times.map{|oc| oc = Opcode.new}
	end
	def load_permutation
		@amps = Array.new
		
	end
	def run
		@signals = Array.new
		#@perm = (5..9).to_a.permutation(5).to_a.each do |p|
		@signal = 0 
		run = true
		#while @opcode.continue == true
		while run == true
			[9, 8, 7, 6, 5].each_with_index do |phase, i|
				@signal = @opcodes[i].run(@signal[:out].to_i, phase)
				if @signal[:stop] == true
					@signals << @signal[:out]
					run = false
					break
				end
			end
		end
		print @signals
	end
end
amps = Amplifiers.new
amps.run
