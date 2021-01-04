class Image 
	attr_accessor :id, :image, :borders
	def initialize(image)
		@id = image.split("\n").slice!(0).gsub(/[^0-9]/, "").to_i
		@image = image.split("\n").drop(1)
		@borders = Array.new
		l_border = @image.map{|line| line[0]}.join
		r_border = @image.map{|line| line[-1]}.join
		@borders << @image.first << @image.last << l_border << r_border
	end
	def check_border(border)
		if @borders.include? border; return true
		else return false end
	end
end
class Images
	attr_accessor :images, :matches, :corners
	def initialize(images)
		@images = Array.new
		images.each.map{|img| @images << Image.new(img)}
	end
	def count_matches
		@matches = Hash.new
		@images.each do |i|
			matches = 0
			i.borders.each do |b|
				@images.each do |img|
					if img.check_border(b) && img.id != i.id;
						matches += 1
					end
				end
			end
			i.borders.each do |b|
				@images.each do |img|
					if img.check_border(b.reverse) && img.id != i.id
						matches += 1
					end
				end
			end
			@matches[i.id] = matches
		end
	end
	def find_corners
		@corners = Array.new
		@matches.each do |id, n_matches|
			if n_matches == 2
				@corners << id.to_i
			end
		end
	end
	def calc_corners
		total = 1
		@corners.map{|c| total *= c}
		return total
	end
end
images = Images.new(File.open("input").read.split("\n\n"))
images.count_matches
images.find_corners
puts images.calc_corners
print images.matches; puts
print images.corners

