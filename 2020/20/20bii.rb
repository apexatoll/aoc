class Image 
	attr_accessor :id, :image, :borders, :unique_sides, :matched_sides, :neighbours
	def initialize(image)
		@id = image.split("\n").slice!(0).gsub(/[^0-9]/, "").to_i
		@image = image.split("\n").drop(1)
		@borders = Array.new
		l_border = @image.map{|line| line[0]}.join
		r_border = @image.map{|line| line[-1]}.join
		@borders << @image.first << @image.last << l_border << r_border
		@unique_sides = @borders
		@matched_sides = Array.new
		@neighbours = Array.new
	end
	def has_border(border)
		if @borders.include? border; return true
		else return false end
	end
end
class Images
	attr_accessor :images, :matches, :corners, :edges, :grid, :side
	def initialize(images)
		@images = Hash.new
		images.each.map{|img| image = Image.new(img); @images[image.id] = image} 
		make_grid
	end
	def make_grid
		@side = Math.sqrt(@images.count).to_i
		@grid = Array.new(side){Array.new(side)}
	end
	def solve
		count_matches
		find_corners
		find_edges
		build_frame
	end
	def count_matches
		@matches = Hash.new
		@images.each do |id, img|
			matches = 0
			img.borders.each do |b|
				@images.each do |id2, img2|
					if id2 != id && (img2.has_border(b) || img2.has_border(b.reverse))
						matches+=1
						img.unique_sides -= Array(b)
						img.matched_sides << b
						img.neighbours << id2
					end
				end
			end
			@matches[id] = matches
		end
	end
	def find_corners
		@corners = @matches.select{|id, n| n==2}.keys
		#@corners.each do |c|
			#puts c
			#print @images[c].unique_sides; puts
			#print @images[c].matched_sides; puts
			#print @images[c].neighbours;puts
		#end
	end
	def find_edges
		@edges = @matches.select{|id, n| n==3}.keys
	end
	def build_frame
		side1 = Array.new(@side)
		side1[0] = @corners[0]
		print side1
		puts @images[side1[0]].neighbours
	end
end
images = Images.new(File.open("example").read.split("\n\n"))
images.solve
#puts images.edges.count
		#@images.each_value do |i|
			#matches = 0
			#i.borders.each do |b|
				#@images.each do |img|
					#if img.has_border(b) && img.id != i.id;
						#matches += 1
						#img.unique_sides -= Array(b)
					#end
				#end
			#end
			#i.borders.each do |b|
