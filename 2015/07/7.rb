class Wire
	attr_accessor :name, :value
	def initialize(name)
		@name = name
	end
end
class Command
	attr_accessor :type, :operands, :output, :number
	def initialize(line)
		@line = line
		parse
	end
	def parse
		case @line
		when /[A-Z]/
			@operator = @line.scan(/[A-Z]+/).first
			@type = :op
		when /^\d+(?!.*[A-Z])/
			@type = :init
		else
			@type = :io
		end
		@output   = @line.gsub(/^.*->\s/, "")
		@number   = @line.scan(/\d+/).map(&:to_i).first
		@operands = @line.scan(/[a-z]+/).reject{|o| o == @output}
	end
end
class Solve
	attr_accessor :cmds
	def initialize
		@cmds = File.readlines("example").map{|cmd| Command.new(cmd.chomp)}
	end
	def init_wires
		wires = @cmds.map{|cmd| [cmd.operands, cmd.output]}.flatten.uniq
		@wires = wires.map{|w| Wire.new(w)}
		@cmds.find_all{|cmd| cmd.type == :init}.each do |cmd|
			wire = @wires.find{|wire| wire.name == cmd.output}
			wire.value = cmd.number
			#print wire.inspect
		end
	end
	def get_next
		@wires.find_all{|wire| wire.value != nil}.each do |wire|
			puts wire.name
			next_cmds  = @cmds.find_all{|cmd| cmd.operands == wire.name}
			print next_cmds
		end
	end
end
solve = Solve.new
solve.init_wires
solve.get_next
