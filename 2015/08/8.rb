class Solve
	def initialize
		@lines = File.readlines("input").map(&:chomp)
		@orig_len = @lines.map{|l| l.length}.reduce(:+)
	end
	def part_one
		@orig_len - @lines.map{|l| l.gsub(/(\\x([\da-f]){2}|\\"|\\\\)/, ";").length - 2}.reduce(:+)
	end
	def part_two
		@lines.map{|l| l.gsub(/(\"|\\|\\x([\da-f]){2})/, "\\\\1").length + 2}.reduce(:+) - @orig_len
	end
end
solve = Solve.new
puts solve.part_one
puts solve.part_two
