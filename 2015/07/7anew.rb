class Command
	attr_reader :operator, :operands, :output
	def initialize(line)
		@operator = line =~ /[A-Z]/ ? 
			line.scan(/[A-Z]+/).first.to_sym : :TO
		@operands = line.gsub(/\s->.*$/, "")
			.split(/\s?\b#{@operator}\b\s?/)
			.map{|o| o =~ /\d/ ? o.to_i : o.to_sym}
			.reject{|o| o == ""}
		@output = line.gsub(/^.*->\s/, "").to_sym
	end
end
class Wires
	def initialize
		@lines = File.readlines("input").map(&:chomp)
		@wires = @lines.flat_map{|l| l.scan(/[a-z]+/)}
			.uniq
			.map{|w| [w.to_sym, nil]}
			.to_h
		@to_run = @lines.dup
	end
	def init_wires
		@to_run.grep(/^\d+[^A-Z]*->.*$/).each do |l| 
			@wires[l.scan(/[a-z]+/)[0].to_sym] = l.scan(/\d+/).first.to_i
			@to_run.delete(l)
		end
	end
	def next_cmds
		@wires.select{|wire, value| value != nil}.keys.flat_map do |wire| 
			@to_run.grep(/^.*\b#{wire}\b.*->/).map do |candidate|
				candidate if candidate
					.scan(/(?=.*->)[a-z]+/)
					.map{|operand| @wires[operand.to_sym] != nil}
					.all?
			end.reject{|line| line == nil}
		end
	end
	def run
		init_wires
		#while @wires.map{|k, v| v == nil}.any?
		while @to_run.length > 0
			next_cmds.each{|line| execute line}
		end
		@wires[:a]
	end
	def run_part_two
		out = run
		@wires = reset
		@wires[:b] = out
		@to_run.grep(/^.*->\sb$/).each{|l| @to_run.delete(l)}
		run
	end
	def get_nums(input)
		input.map{|n| (n.is_a? Symbol)? @wires[n] : n}.reject{|n| n == nil}
	end
	def execute(line)
		cmd = Command.new(line)
		nums = get_nums(cmd.operands)
		case cmd.operator
		when :RSHIFT then @wires[cmd.output] = nums.reduce(:>>)
		when :LSHIFT then @wires[cmd.output] = nums.reduce(:<<)
		when :AND    then @wires[cmd.output] = nums.reduce(:&)
		when :OR     then @wires[cmd.output] = nums.reduce(:|)
		when :NOT    then @wires[cmd.output] = (2**16) - nums.first - 1
		when :TO     then @wires[cmd.output] = nums.first end
		@to_run.delete(line)
	end
	def reset
		@to_run = @lines.dup
		@wires.map{|wire, value| [wire.to_sym, nil]}.to_h
	end
end
puts Wires.new.run_part_two
