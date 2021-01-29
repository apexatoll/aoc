class Solve
	def initialize
		@x, @y, @dir = 0, 0, :N
		@cmds = File.read("input").split(", ")
			.map{|c| c.gsub(/([LR])(\d+)/, "\\1;\\2").split(";")}
			.map{|d, n| {d.to_sym => n.to_i}}
	end
	def part_one
		@cmds.map{|cmd| change_dir(cmd); move(cmd)}
		[@x.abs, @y.abs].reduce(:+)
	end
	def move(cmd)
		case @dir
		when :N then @y += cmd.values.first
		when :E then @x += cmd.values.first
		when :S then @y -= cmd.values.first
		when :W then @x -= cmd.values.first
		end
	end
	def change_dir(cmd)
		case @dir
		when :N then @dir = cmd.keys.first == :L ? :W : :E
		when :E then @dir = cmd.keys.first == :L ? :N : :S
		when :S then @dir = cmd.keys.first == :L ? :E : :W
		when :W then @dir = cmd.keys.first == :L ? :S : :N
		end
	end
end
solve = Solve.new
puts solve.part_one
