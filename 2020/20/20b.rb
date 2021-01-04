class Image 
	attr_accessor :id, :image, :borders, :to_flip, :solved, :flipped
	def initialize(image)
		@id = image.split("\n").slice!(0).gsub(/[^0-9]/, "")
		@image = image.split("\n").drop(1)
		@to_flip = false
		@solved = false
		@flipped = false
		set_borders
	end
	def set_borders
		@borders = Array.new
		l_border = @image.map{|line| line[0]}.join
		r_border = @image.map{|line| line[-1]}.join
		@borders << @image.first << @image.last << l_border << r_border
	end
	def has_border(border)
		if @borders.include? border; return true
		else return false end
	end
	def flip
		@image = @image.map{|line| line.reverse}
		set_borders
		puts "flipped image! #{@id}"
	end
	def rotate
		img = @image.map{|line| line.split("")}
		@image = img.transpose.map(&:reverse).map{|line| line.join}
	end
	def rm_borders
	end
	def flipped_correctly
		@flipped = true
	end
end
class Images
	attr_accessor :images, :n_pieces, :n_solved, :side, :matches, :corners, :grid, :oriented
	def initialize(images)
		@images = Hash.new
		images.each.map{|img| image = Image.new(img); @images[image.id] = image}
		@n_pieces = @images.count
		@n_solved = 0
		mk_grid
	end
	def mk_grid
		@side = Math.sqrt(@n_pieces).to_i
		@grid = Array.new(@side){Array.new(@side)}
	end
	def flip_pieces
		count_matches
		to_flip = @images.select{|id, img| img.flipped == false}.keys
		print to_flip.count
		if to_flip.count > @n_pieces / 2
			@images.each_value{|img| img.flip}
		end
		count_matches
		to_flip = @images.select{|id, img| img.flipped == false}.keys
	end
	def count_matches
		@matches = Hash.new
		@oriented = true
		@images.each do |id, image|
			@matches[id] = Hash.new
			matches, inv_matches = 0, 0
			image.borders.each do |b|
				@images.each do |compare_id, img|
					if compare_id != id && img.has_border(b)
						matches += 1
					end
				end
			end
			image.borders.each do |b|
				@images.each do |compare_id, img|
					if compare_id != id && img.has_border(b.reverse)
						inv_matches += 1
					end
				end
			end
			@matches[id][:current] = matches
			@matches[id][:inverted] = inv_matches
		end
		@matches.each do |id, m|
			if m[:inverted] == 0
				@images[id].flipped_correctly
			end
		end
		puts "Matches:"
		@matches.map{|m| print m; puts}
		puts @oriented
	end
	def print_images
		print @images
		@images["2311"].flip
		print @images
	end
	def find_corners
		@corners = Array.new
		@matches.each do |id, n_matches|
			if n_matches == 2
				@corners << id.to_i
			end
		end
		print @corners
		puts
	end
	def calc_corners
		total = 1
		@corners.map{|c| total *= c}
		puts total
	end
end
images = Images.new(File.open("example").read.split("\n\n"))
images.flip_pieces
