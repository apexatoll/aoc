class Distance
	attr_accessor :a, :b, :distance
	def initialize(line)
		@a, @b, @distance = line.split(/(\sto\s|\s=\s)/)
			.reject{|e| e == " to " || e == " = "}
		@distance = @distance.to_i
	end
end
class Solve
	def initialize
		@distances = File.readlines("input").map{|l| Distance.new(l.chomp)}
		@cities = @distances.map{|d| [d.a, d.b]}.flatten.uniq
		@routes = @cities.to_a.permutation(@cities.count)
	end
	def route
		@lengths = @routes.map do |r|
			total = 0
			r.each_with_index do |city, i|
				if i != @cities.count - 1
					a = city
					b = r[i + 1]
					d = @distances.find{|d| (d.a == a && d.b == b) || 
						(d.a == b && d.b == a)}.distance
					total += d
				end
			end
			total
		end.sort!
		["Shortest = " + @lengths.first.to_s, 
		 "Longest  = " + @lengths.last.to_s]
	end
end
solve = Solve.new
puts solve.route
