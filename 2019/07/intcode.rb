class Intcode
	attr_accessor :index, :cmds, :input, :output, :phase, :complete
	def initialize
		@index = 0
		@output = []
		@phased = false
		@complete = false
		load_cmds
	end
	def load_cmds
		@cmds = File.read("input").split(",").map(&:to_i)
	end
	def get_instruction
		ins = @cmds[@index].to_s.split("").reverse.map(&:to_i)
		cmd = [ins[1], ins[0]].join.to_i
		md1 = ins[2] || 0
		md2 = ins[3] || 0
		md3 = ins[4] || 0
		[cmd, md1, md2, md3]
	end
	def get_num(mode, index)
		case mode
		when 0 then @cmds[@cmds[index]]
		when 1 then @cmds[index]
		end
	end
	def get_add(index)
		@cmds[index]
	end
	def write_value(val, addr)
		@cmds[addr] = val
	end
	def run
		while @index < @cmds.length
			cmd, md1, md2, md3 = get_instruction
			case cmd
			when 1
				n1 = get_num(md1, @index + 1)
				n2 = get_num(md2, @index + 2)
				a3 = get_add(@index + 3)
				write_value(n1 + n2, a3)
				@index += 4
			when 2
				n1 = get_num(md1, @index + 1)
				n2 = get_num(md2, @index + 2)
				a3 = get_add(@index + 3)
				write_value(n1 * n2, a3)
				@index += 4
			when 3
				if @phased == false
					n1 = @phase
					@phased = true
				else
					n1 = @input
				end
				a2 = get_add(@index + 1)
				write_value(n1, a2)
				@index += 2
			when 4
				n1 = get_num(md1, @index + 1)
				@output << n1
				@index += 2
			when 5
				n1 = get_num(md1, @index + 1)
				n2 = get_num(md2, @index + 2)
				@index = n1 != 0? n2 : @index + 3
			when 6
				n1 = get_num(md1, @index + 1)
				n2 = get_num(md2, @index + 2)
				@index = n1 == 0? n2 : @index + 3
			when 7
				n1 = get_num(md1, @index + 1)
				n2 = get_num(md2, @index + 2)
				n3 = get_add(@index + 3)
				write_value(n1 < n2 ? 1 : 0, n3)
				@index += 4
			when 8
				n1 = get_num(md1, @index + 1)
				n2 = get_num(md2, @index + 2)
				n3 = get_add(@index + 3)
				write_value(n1 == n2 ? 1 : 0, n3)
				@index += 4
			when 99
				@complete = true
				break
			end
			return @output.join.to_i
		end
	end
end
