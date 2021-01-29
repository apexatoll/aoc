class Containers
	def initialize
		@cs = File.readlines("input").map{|l| l.chomp.to_i}
		@target = 150
	end
	def part_one 
		(1..@cs.count).to_a.flat_map do |n|
			@cs.combination(n).to_a
				.map{|c| c.reduce(:+)}
		end.select{|c| c == 150}.count
	end
	def part_two 
		(1..@cs.count).to_a.each do |n|
			sums = @cs.combination(n).to_a
				.map{|c| c.reduce(:+)}
			if sums.include? 150
				$min = n
				break
			end
		end
		@cs.combination($min).to_a
			.map{|c| c.reduce(:+)}
			.select{|c| c == 150}.count
	end
end
solve = Containers.new
puts solve.part_one
puts solve.part_two
