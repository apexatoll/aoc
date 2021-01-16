class Rectangle
	attr_accessor :id, :x, :y, :l, :w, :area
	def initialize(id, coords, area)
		@id = id.to_i
		@x = coords[0].to_i
		@y = coords[1].to_i
		@w = area[0].to_i
		@l = area[1].to_i
	end
	def calc_area
		@area = Array.new
		for y in @y..(@y + @l)
			for x in @x..(@x + @w)
				@area << [x, y]
			end
		end
	end
end
class Rectangles
	attr_accessor :rectangles
	def initialize
		@rectangles = Array.new
		File.readlines("input").each do |l|
			id = l.gsub(/^#([0-9]*).*$/, "\\1")
			coords = l.gsub(/^.*@ ([0-9,]*):.*$/, "\\1").split(",")
			area = l.gsub(/^.*: ([0-9]*x[0-9]*)$/, "\\1").split("x")
			@rectangles << Rectangle.new(id, coords, area)
		end
	end
	def get_areas
		@rectangles.each{|r| r.calc_area}
		all_areas = Array.new
		all_areas << @rectangles.map{|r| r.area}
		puts all_areas.flatten(2).count
		count = 0
		all_areas.flatten(2).uniq.each do |c|
			count += 1 if all_areas.flatten(2).count(c) >= 2
		end
		puts count
	end
end
recs = Rectangles.new
recs.get_areas
