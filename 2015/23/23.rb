class Solve
	def initialize
		@lines = File.readlines("input")
			.map.with_index{|l, i| [i, l.chomp] }.to_h
	end
	def part_one
		@regs = {:a => 0, :b => 0}
		@i = 0
		run
	end
	def part_two
		@regs = {:a => 1, :b => 0}
		@i = 0
		run
	end
	def run
		while @i < @lines.count
			l = @lines[@i]
			cmd = l.scan(/^(\w+)(?:\s)/).flatten.first.to_sym
			reg = l.gsub(/^#{cmd}\s(\w).*$/, "\\1").to_sym
			ind = l.scan(/[-+]\d+/).flatten.first.to_i
			case cmd
			when :hlf then @i += 1
				@regs[reg] /= 2
			when :tpl then @i += 1
				@regs[reg] *= 3
			when :inc then @i += 1
				@regs[reg] += 1
			when :jmp 
				@i += ind
			when :jie 
				@regs[reg].even? ? @i += ind : @i += 1
			when :jio 
				@regs[reg] == 1  ? @i += ind : @i += 1
			end
		end
		@regs[:b]
	end
end
solve = Solve.new
puts solve.part_one
puts solve.part_two
