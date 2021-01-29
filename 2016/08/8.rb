class Screen
	attr_accessor :pixels
	def initialize(w, h)
		@pixels = Array.new(h){Array.new(w, ".")}
	end
	def execute(line)
		case line
		when /rect/ then rect line
		when /rotate/ then rotate line end
	end
	def rect(line)
		line.scan(/\d+/).map(&:to_i).tap{|l, w| (0...w).to_a
			.each{|row| (0...l).to_a
			.each{|cell| @pixels[row][cell] = "#"}}}
	end
	def rotate(line)
		index, offset = line.scan(/\d+/).map(&:to_i)
		offset *= -1
		case line
		when /column/ then 
			@pixels = @pixels.transpose
			@pixels[index] = @pixels[index].rotate(offset)
			@pixels = @pixels.transpose
		when /row/
			@pixels[index] = @pixels[index].rotate(offset)
		end
	end
	def print_screen
		@pixels.each{|row| puts row.join}
		puts
	end
end
class Solve
	def initialize(file, w, h)
		@cmds = File.readlines(file).map(&:chomp)
		@screen = Screen.new(w, h)
	end
	def run
		@cmds.each{|cmd| @screen.execute cmd; @screen.print_screen}
		@screen.pixels.flatten.select{|p| p == "#"}.count
	end
end
solve = Solve.new("input", 50, 6)
puts solve.run
