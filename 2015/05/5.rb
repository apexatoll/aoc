class Solve
	def initialize
		@lines = File.readlines("input").map(&:chomp)
	end
	def part_one
		@lines.count do |l| 
			l =~ /(.)\1/ && 
			l =~ /(.*[aeiou]){3,}/ && 
			l =~ /^((?!xy|ab|cd|pq).)*$/
		end
	end
	def part_two
		@lines.count do |l|
			l =~ /(.).\1/ &&
			l =~ /(..).*\1/
		end
	end
end
solve = Solve.new
puts solve.part_one
puts solve.part_two
