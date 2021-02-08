class Cart
	attr_reader :x, :y
	def initialize(data)
		@x, @y = data[0]
		@xrd_i = 0
		@dir = case data[1]
			when "^" then :N
			when "v" then :S
			when ">" then :E
			when "<" then :W end 
	end
	def tick
		case $grid[@y, @x]
		when "|" 
			@y+=1 if @dir == :N
			@y-=1 if @dir == :S
		when "-"
			@x+=1 if @dir == :E
			@x-=1 if @dir == :W
		when "/"
			if @dir == :N

			end
			if @dir == :W

			end
		when "\\"
			if @dir == :E

			end
			if @dir == :S

			end
		when "+"
			#case $xrd_ord[@xrd_i]

			#end
		end
	end
end
class Rails
	def initialize
		$xrd_ord = [:L, :R, :S]
		$grid = File.readlines("input").map{|l| l.chomp.split("")}
	end
	def part_one
		find_carts
		tick
	end
	def find_carts
		@carts = $grid.flat_map
			.with_index{|row, y| row.map
			.with_index{|col, x| 
				col =~ /[\^v<>]/ ? [[x, y], col] : nil}}
			.reject{|c| c == nil}
			.map{|d| Cart.new(d)}
		#check_crashes
	end
	def tick
		print @carts.sort_by{|c| [c.y, c.x]}.map{|c| [c.x, c.y]}
			#.each{|c| c.tick} until crash?
		#puts get_crash
	end
	def crash?
		all_carts = @carts.map{|c| [c.x, c.y]}
		all_carts.detect{|p| all_carts.count(p) > 1}.nil?
	end
	def get_crash
		all_carts = @carts.map{|c| [c.x, c.y]}
		all_carts.detect{|p| all_carts.count(p) > 1}
	end
end
Rails.new.part_one
