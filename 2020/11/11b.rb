require 'digest'
seats = File.readlines("input").map{|line| line.chomp.split("")}
class Grid
	attr_accessor :seats, :seats_per_row, :n_rows, :stable, :states
	def initialize(seats)
		@seats = seats
		@n_rows = seats.count
		@seats_per_row = seats[0].count
		@stable = false
		@states = Hash.new
	end
	def count_occ(x, y)
		#range = [-1, 0, 1]
		buffer = Array.new
		(x_pos -= 1) while @seats[y][x_pos - 1] == "."

		
		x_pos = range.map{|pos| x + pos}
			.select{|pos| pos >= 0 && pos <= @seats_per_row - 1}
		y_pos = range.map{|pos| y + pos}
			.select{|pos| pos >= 0 && pos <= @n_rows - 1}
		coordinates = x_pos.map{|xp| y_pos.map{|yp| [xp, yp]}}.flatten(1) - [[x, y]]
		count = coordinates.map{|xp, yp| @seats[yp][xp]}.flatten.select{|seat| seat == "#"}.size
		return count
	end
	def cycle
		new_seats = 
			@seats.each_with_index.map do |row, y|
				row.each_with_index.map do |seat, x|
					n_occ = count_occ(x, y).to_i
					case seat.to_s
					when "L";
						if n_occ == 0; "#"
						else "L" end
					when "#"
						if n_occ >= 4; "L"
						else "#" end
					when "."; "." end
				end.join
			end.join("\n")
		hash = Digest::MD5.hexdigest new_seats
		if @states[hash] == true
			@stable = true
		else
			@states[hash] = true
			@seats = new_seats.each_line.map{|line| line.chomp.split("")}
		end
	end
	def finalCount
		return @seats.flatten.count("#")
	end
end
grid = Grid.new(seats)
while grid.stable == false
	grid.cycle
end
puts grid.finalCount
