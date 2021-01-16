class Wire
	attr_accessor :name, :value
	def initialize(name)
		@name = name
	end
end
class Command
	attr_accessor :string, :input, :operator, :operands, :output
	def initialize(string)
		@string = string.split(" ")
		out_i = string.index{|i| i == "->"} + 1
		@output = string[out_i]
	end
	def parse_cmd
		operator_i = string.index{|i| i =~ /[A-Z]/}
		@operator = stricmdng[opr_i]
		case @operator
		when "NOT"
			@operands = [cmd[opr_i + 1]]
		else
			@operands = [cmd[opr_i - 1], cmd[opr_i + 1]]
		end
	end
	def parse_init
	end
end
class Solve
	attr_accessor :cmds, :wires
	def initialize
		@cmds = Array.new
		@inits = Array.new
		File.readlines("input").map(&:chomp).each do |cmd|
			if cmd =~ /[A-Z]/
				parse(cmd) 
			else
				@inits << cmd
			end
		end
	end
	def parse(cmd)
		@cmds << Command.new(cmd)
	end
	def get_wires
		wires = @cmds.map{|l| l.split(" ").select{|p| p =~ /[a-z]/}}
		@wires = wires.flatten.uniq.map{|wire| Wire.new(wire)}
		@cmds.select{|cmd| cmd =~ /^[0-9]+\s->/}.each do |cmd|
			val  = cmd.gsub(/[^0-9]*/, "")
			dest = cmd.gsub(/^.*->\s/, "")
			@wires.find{|w| w.name == dest}.value = val
		end
	end
	def run
	end
end
solve = Solve.new
solve.get_wires
print solve.wires
#print solve.cmds
