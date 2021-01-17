class Command
	attr_accessor :cmd, :x1, :x2, :y1, :y2
	def initialize(line)
		@cmd  = line.scan(/(on|off|toggle)/).flatten.first.to_sym
		@x1, @y1, @x2, @y2 = line.scan(/\d+/).map(&:to_i)
	end
end
class Lights
	def initialize
		@grid = Array.new(1000){Array.new(1000,0)}
		@cmds = File.readlines("input").map{|l| Command.new(l.chomp)}
	end
	def run
		@cmds.each do |cmd|
			for row in cmd.y1..cmd.y2
				for col in cmd.x1..cmd.x2
					case cmd.cmd
					when :on  then @grid[row][col] = 1
					when :off then @grid[row][col] = 0
					when :toggle 
						@grid[row][col] = @grid[row][col] == 0 ? 1 : 0
					end
				end
			end
		end
		@grid.flatten.select{|c| c == 1}.count
	end
end
lights = Lights.new
puts lights.run
