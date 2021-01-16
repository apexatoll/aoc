class Image 
	attr_accessor :id, :image, :borders, :unique_sides, :matched_sides, :neighbours,
		:t_border, :r_border, :b_border, :l_border
	def initialize(image)
		@id = image.split("\n").slice!(0).gsub(/[^0-9]/, "").to_i
		@image = image.split("\n").drop(1)
		@matched_sides = Array.new
		@neighbours = Array.new
		set_borders
		@unique_sides = @borders
	end
	def set_borders
		@t_border = @image.first
		@r_border = @image.map{|line| line[-1]}.join
		@b_border = @image.last.reverse
		@l_border = @image.map{|line| line[0]}.join.reverse
		@borders = [@t_border, @r_border, @b_border, @l_border]
	end
	def flip
		@image = @image.map{|line| line.reverse}
		set_borders
		#puts "flipped image! #{@id}"
	end
	def rotate
		img = @image.map{|line| line.split("")}
		@image = img.transpose.map(&:reverse).map{|line| line.join}
		set_borders
	end
	def has_border(border)
		if @borders.include? border; return true
		else return false end
	end
	def unique_edge_loc
		u_edges = Hash.new
		if @unique_sides.include? t_border
			u_edges[:t] = true
		elsif @unique_sides.include? r_border
			u_edges[:r] = true
		elsif @unique_sides.include? b_border
			u_edges[:b] = true
		elsif @unique_sides.include? l_border
			u_edges[:l] = true
		end
		return u_edges
	end
end

class Images < Image
	attr_accessor :images, :matches, :corners, :edges, :grid, :side, :centers
	def initialize(images)
		@images = Hash.new
		images.each.map{|img| image = Image.new(img); @images[image.id] = image} 
		@side = Math.sqrt(@images.count).to_i
		@grid = Array.new(@side){Array.new(@side)}
	end
	def solve
		count_matches
		sort_pieces
		build_frame
		#fill_centers
		#orientate_tiles
	end
	private
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
	def sort_pieces
		@corners = @matches.select{|id, n| n==2}.keys
		@edges   = @matches.select{|id, n| n==3}.keys
		@centers = @matches.select{|id, n| n==4}.keys
	end
	def build_frame
		perimeter = 4 * (@side - 1)
		$frame = Array.new(perimeter)
		$corners_left = @corners
		$edges_left = @edges
		start_id = $corners_left[0]
		start_piece = @images[start_id]
		puts start_piece.unique_edge_loc



		#puts start_piece.unique_sides
		#puts "top: " + start_piece.t_border
		#puts "rgt: " + start_piece.r_border
		#puts
		#start_piece.rotate
		#puts "top: " + start_piece.t_border
		#puts "rgt: " + start_piece.r_border
		#puts
		#start_piece.rotate
		#puts "top: " + start_piece.t_border
		#puts "rgt: " + start_piece.r_border
		#puts
		#start_piece.flip
		#puts "top: " + start_piece.t_border
		#puts "rgt: " + start_piece.r_border
		#puts




		#start piece needs unique sides as l border and t border
		#while start_piece.unique_sides.includes? start_piece.t_border
			#puts "inf loop!"
		#end

		#$frame[0] = $corners_left[0]
		#$corners_left -= Array($frame[0])
		#$last_border = [@images[$frame[0]].matched_sides[0]]
		#find top left border


		#$frame.each_with_index do |tile, i|
			#if i == 0; next
			#elsif i % (@side - 1) == 0
				#$last_border.each do |b|
					#$corners_left.each do |id|
						#if @images[id].has_border(b) || @images[id].has_border(b.reverse)
							#$last_border = @images[id].matched_sides - Array(b)
							#$frame[i] = id
							#$corners_left -= Array(id)
						#end
					#end
				#end
			#else
				#$last_border.each do |b|
					#$edges_left.each do |id|
						#if @images[id].has_border(b) || @images[id].has_border(b.reverse)
							#$last_border = @images[id].matched_sides - Array(b)
							#$frame[i] = id
							#$edges_left -= Array(id)
						#end
					#end
				#end
			#end
		#end
		#fill_grid_frame($frame)
	end
	#def fill_grid_frame(frame)
		#ti = 1 * (@side - 1)
		#ri = 2 * (@side - 1)
		#bi = 3 * (@side - 1)
		#li = 4 * (@side - 1)
		#t = frame.slice(0..ti)
		#r = frame.slice(ti..ri)
		#b = frame.slice(ri..bi).reverse
		#l = (frame.slice(bi..-1) + Array(frame[0])).reverse
		#@grid[0] = t
		#@grid[-1] = b
		#r.each_with_index{|cell, row| @grid[row][-1] = cell}
		#l.each_with_index{|cell, row| @grid[row][0] = cell}
	#end
	#def fill_centers
		#$centers_left = @centers
		#@grid.each_with_index do |row, y|
			#if y == 0 || y == @side - 1 
				#next end
			#row.each_with_index do |cell, x|
				#if x == 0 || x == @side - 1
					#next end
				#l_sides = @images[@grid[x-1][y]].matched_sides
				#u_sides = @images[@grid[x][y-1]].matched_sides
				#$centers_left.each do |id|
					#img_sides = @images[id].matched_sides
					#img_sides_inv = @images[id].matched_sides.map{|side| side.reverse}
					#if (l_sides & img_sides).count > 0 ||
						#(l_sides & img_sides_inv).count > 0
						#if (u_sides & img_sides).count > 0 ||
							#(u_sides & img_sides_inv).count > 0
							#@grid[x][y] = id
							#$centers_left -= Array(id)
						#end
					#end
				#end
			#end
		#end
	#end
	#def orientate_tiles
		#orientate_corners
	#end
	#def orientate_corners
		#@grid.map{|line| print line; puts}
		#tl_corner = @grid[0][0]
		#tr_corner = @grid[0][-1]
		#bl_corner = @grid[-1][0]
		#br_corner = @grid[-1][-1]
		#puts tl_corner, tr_corner, bl_corner, br_corner
		#while tl_corner
		##puts @images[@grid[0][0]].image
		##puts
		##puts @images[@grid[0][0]].unique_sides
		##puts @images[@grid[0][0]].l_border
	#end
end
images = Images.new(File.open("example").read.split("\n\n"))
images.solve



