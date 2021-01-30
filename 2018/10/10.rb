class Point
	attr_accessor :pos
	def initialize(id, line)
		@id = id
		@pos, @vel = line.scan(/<.*?>/)
			.map{|i| i.scan(/-?\d+/).map(&:to_i)}
	end
	def tick
		@pos = [@pos[0] + @vel[0], @pos[1] + @vel[1]]
	end
	def apply_offset(x, y)
		@pos = [@pos[0] - y, @pos[1] - x]
	end
end
class Points
	def initialize
		@points = File.readlines("input")
			.map.with_index{|l, i| Point.new(i, l)}
	end
	def calc_grid_size
		#max_x = @points.map{|p| p.pos[0]}.max
		#min_x = @points.map{|p| p.pos[0]}.min
		#max_y = @points.map{|p| p.pos[1]}.max
		#min_y = @points.map{|p| p.pos[1]}.min
		#max_x = @points.max_by{|p| p.pos[0]}.pos[0]
		#min_x = @points.min_by{|p| p.pos[0]}.pos[0].abs
		#max_y = @points.max_by{|p| p.pos[1]}.pos[1]
		#min_y = @points.min_by{|p| p.pos[1]}.pos[1].abs
		x_ofst = @points.map{|p| p.pos[0]}.min
		y_ofst = @points.map{|p| p.pos[1]}.min
		x_l = @points.max_by{|p| p.pos[0]}.pos[0] - x_ofst
		y_l = @points.max_by{|p| p.pos[1]}.pos[1] - y_ofst

		#x = @points.map{|p| p.pos[0] < 0}.any? ? "some x neg": "none x neg"
		#y = @points.map{|p| p.pos[1] < 0}.any? ? "some y neg": "none y neg"
		#+=j
		#+=j
		#puts x, y
		#[(max_x - min_x).abs + 1, (max_y - min_y).abs + 1, [min_x.abs, min_y.abs]]
	end
	def show
		begin
			lx, ly, zero = calc_grid_size
			puts lx, ly, zero
			if lx <= 500 
				grid = Array.new(ly){Array.new(lx, ".")}
				@points.each{|p| grid[zero[1] + p.pos[1]][zero[0] + p.pos[0]] = "#"}
				grid.map{|l| puts l.join}
			end
		rescue NoMethodError
			@points.map{|p| print p.pos; puts}
			puts "lx = #{lx}"
			puts "ly = #{ly}"
			puts "zero coords = #{zero[0]}, #{zero[1]}"
			exit
		end
	end
	def tick_points
		@points.each{|p| p.tick}
	end
	def run
		10346.times do  |i|
		#10.times do  |i|
			puts i
			tick_points
			show
		end
		#puts @points.inspect
		#puts @points.max_by{|p| p.pos[0]}.pos[0]
		#puts @points.min_by{|p| p.pos[0]}.pos[0]
	end
end
Points.new.run
