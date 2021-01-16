class Path
	def initialize(commands)
		@path = commands
		@location = Hash.new
		@location[:x] = 0
		@location[:y] = 0
	end
	def route
		@path.each do |step|
			case step
				when "ne"; @location[:x]+=1; @location[:y]+=1
				when "e";  @location[:x]+=2
				when "se"; @location[:x]+=1; @location[:y]-=1
				when "nw"; @location[:x]-=1; @location[:y]+=1
				when "w";  @location[:x]-=2
				when "sw"; @location[:x]-=1; @location[:y]-=1
			end
		end
		return @location
	end
end

class Tile
	protected
	attr_accessor :colour, :x, :y, :to_flip
	def initialize(x, y)
		@colour = "white"
		@x = x; @y = y
		@to_flip = false
	end
	def flip
		if @colour == "white"
			@colour = "black"
		elsif @colour == "black"
			@colour = "white"
		end
	end
	def get_colour
		return @colour
	end
end

class Tiles < Tile
	attr_accessor :tiles, :paths
	def initialize(locations)
		@paths = locations
		@tiles = @paths.uniq.map{|c| Tile.new(c[:x], c[:y])}
	end
	def flip_tiles
		@paths.each do |coords|
			@tiles.find do |tile| 
				tile.x == coords[:x] && 
				tile.y == coords[:y]
			end.flip
		end
	end
	def count_black
		return @tiles.select{|tile| tile.colour == "black"}.count
	end
	def days(n_days)
		n_days.to_i.times{one_day}
		count_black
	end
	def find_tile(coords)
		tile = @tiles.find{|t| t.x == coords[0].to_i && t.y == coords[1].to_i}
		if tile; return tile.colour
		else
			tile = Tile.new(coords[0], coords[1])
			@tiles += Array(tile)
			return tile.colour
		end
	end
	def flip_all
		@tiles.find{|t| t.to_flip == true}.flip
	end
	def one_day
		@tiles.each do |tile|
			puts tile.x, tile.y, tile.colour
			neighbours = Array.new
			ce  = [tile.x+=2, tile.y]
			cw  = [tile.x-=2, tile.y]
			cne = [tile.x+=1, tile.y+=1]
			cse = [tile.x+=1, tile.y-=1]
			cnw = [tile.x-=1, tile.y+=1]
			csw = [tile.x-=1, tile.y-=1]
			neighbours = [ce, cw, cne, cse, cnw, csw]
			colours = neighbours.map{|n| find_tile(n)}
			n_black = colours.select{|c| c == "black"}.count
			print colours; puts
			puts n_black
			case tile.colour
			when "black"
				if n_black == 0 or n_black > 2
					puts "flip"
					tile.to_flip = true
				else
					tile.to_flip = false
				end
			when "white"
				if n_black == 2
					puts "flip"
					tile.to_flip = true
				else
					tile.to_flip = false
				end
			end
			puts
		end
		flip_all
		count_black
	end
end
def solve
	paths = File.readlines("example").map do |line| 
		line.gsub(/((se|sw|nw|ne|(?<![sn])e|(?<![sn])w))/, "\\1;")
		.chomp
		.split(";")
	end
	locations = paths.map{|path| Path.new(path).route}
	tiles = Tiles.new(locations)
	tiles.flip_tiles
	puts tiles.one_day
end; solve
