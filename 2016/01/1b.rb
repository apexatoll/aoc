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
	def part_two
		@visited = []
		@cmds.each{|cmd| change_dir(cmd); break if move(cmd)}
		@visited.detect{|e| @visited.count(e) > 1}.map(&:abs).reduce(:+)
	end
	def visited?
		@visited.detect{|e| @visited.count(e) > 1} ? true : false
	end
	def move(cmd)
		case @dir
		when :N then 
			(@y + 1).upto(@y + cmd.values.first){|y| @visited << [@x, y]}
			@y += cmd.values.first
			return true if visited?
		when :E then 
			(@x + 1).upto(@x + cmd.values.first){|x| @visited << [x, @y]}
			@x += cmd.values.first
			return true if visited?
		when :S then 
			(@y - 1).downto(@y - cmd.values.first){|y| @visited << [@x, y]}
			@y -= cmd.values.first
			return true if visited?
		when :W then 
			(@x - 1).downto(@x - cmd.values.first){|x| @visited << [x, @y]}
			@x -= cmd.values.first
			return true if visited?
		end
		false
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
puts solve.part_two
