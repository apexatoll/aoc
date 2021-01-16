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
	attr_accessor :colour, :x, :y
	def initialize(x, y)
		@colour = "white"
		@x = x; @y = y
	end
	def flip
		if @colour == "white"
			@colour = "black"
		elsif @colour == "black"
			@colour = "white"
		end
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
end

def solve
	paths = File.readlines("input").map do |line| 
		line.gsub(/((se|sw|nw|ne|(?<![sn])e|(?<![sn])w))/, "\\1;")
		.chomp
		.split(";")
	end
	locations = paths.map{|path| Path.new(path).route}
	tiles = Tiles.new(locations)
	tiles.flip_tiles
	puts tiles.count_black
end; solve
