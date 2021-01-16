class Wire
	attr_accessor :name, :val
	def initialize(name)
		@name = name
	end
end
class Solve
	attr_accessor :cmds
	def initialize
		@cmds = Array.new
		File.readlines("example").map(&:chomp).each{|l| parse(l)}
	end
	def parse(line)
		cmd = Hash.new
		line = line.split(" ")
		arr_i = line.index{|e| e == "->"}
		cmd[:out] = line[arr_i + 1]
		case line.length
		when 3
			cmd[:type] = :io
			cmd[:in] = line[arr_i - 1]
		when 4
			cmd[:type] = :un
			op_i = line.index{|e| e =~ /[A-Z]/}
			cmd[:in] = [line[op_i + 1]]
			cmd[:op] = line[op_i]
		when 5
			cmd[:type] = :bin
			op_i = line.index{|e| e =~ /[A-Z]/}
			cmd[:in] = [line[op_i - 1], line[op_i + 1]]
			cmd[:op] = line[op_i]
		end
		@cmds << cmd
	end
	def init_wires
		@wires = @cmds.map{|cmd| [cmd[:in], cmd[:out]]}
			.flatten
			.reject{|n| n =~ /\d/}
			.uniq
			.map{|w| Wire.new(w)}
		puts @wires
	end
end
slve = Solve.new
slve.init_wires
