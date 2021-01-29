class Rectangle
	attr_accessor :area
	def initialize(line)
		@id, @x, @y, @l, @w = line.scan(/\d+/).map(&:to_i)

		@area = (@x..(@x + @l)).to_a.product((@y..(@y + @w)).to_a)
		#@area = 
			#(@c1..@c1 + @l).to_a.map{|x| [x, y]}
		#@area = @c1.upto(@c2).to_a.zip(@c1.upto(@c2)).to_a
		#@area = (@c1..@c2).to_a.combination(2).to_a
		#product((@c1..@c2).to_a)
		#@area = Array.new
		#for y in @c1..(@c1 + @l)
			#for x in @c2..(@c2 + @w)
				#@area << [x, y]
			#end
		#end
	end
end
class Solve
	def initialize
		@rs = File.readlines("example").map{|l| Rectangle.new(l.chomp)}
		#print @rs.inspect
		#print @rs.first.area
	end
	def part_one
		all = @rs.flat_map{|r| r.area}
		print all.select{|e| all.count(e) >= 2}.uniq
	end
end
solve = Solve.new
puts solve.part_one
