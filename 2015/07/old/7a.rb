class Wire
	attr_accessor :name, :value
	def initialize(name)
		@name = name
	end
end
=begin
fo RSHIFT 3 -> fq
hb LSHIFT 1 -> hv
lr AND lt -> lu
cj OR cp -> cq
lx -> a
NOT ax -> ay
=end
class Initializer
end
class Command
	attr_accessor :string, :operator, :operands, :output
	def initialize(string)
		@string = string.split(" ")
		parse
	end
	def parse
		operator_i = @string.index{|e| e =~ /[A-Z]/}
		operands_i = [operator_i - 1, operator_i + 1]
		output_i = @string.index{|e| e == "->"} + 1
		puts output_i
		puts "operator = " + @string[operator_i]
		puts "operands = " + @string[operands_i[0]] + ", " + @string[operands_i[1]]
		puts "output = " + @string[output_i]
	end
end
commands = File.readlines("input").map(&:chomp)
test = commands[0]
cmd = Command.new(test)
#cmds = commands.map{|cmd| Command.new(cmd)}

#class Wires
	#def initialize
		#commands = File.readlines("input").map(&:chomp)

		##@completed = Array.new
	#end
	#def get_all_wires
		#wires = @cmds.map{|l| l.split(" ").select{|p| p =~ /[a-z]/}}
		#@wires = wires.flatten.uniq.map{|wire| Wire.new(wire)}
		#@cmds.select{|cmd| cmd =~ /^[0-9]+\s->/}.each do |cmd|
			#val  = cmd.gsub(/[^0-9]*/, "")
			#dest = cmd.gsub(/^.*->\s/, "")
			#@wires.find{|w| w.name == dest}.value = val
			#@completed << cmd
			#@cmds.delete(cmd)
		#end
	#end
	#def get_next_cmds
		#next_wires = @wires.find_all{|w| w.value != nil}.map{|w| w.name}
		#next_cmds  = next_wires.map do |name| 
			#@cmds.grep(/(?<![a-z])#{name}(?![a-z])/)
		#end.flatten
		#print next_cmds
	#end
	#def get_output

	#end
	#def get_cmd

	#end
	#def run
		#get_next_cmds
	#end
#end
#wires = Wires.new
#wires.get_all_wires
#wires.run
