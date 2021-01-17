#puts [0, 1, 2, 3, 4].permutation(1..2.to_i).to_a
class Containers
	attr_accessor :containers
	def initialize
		@containers = File.readlines("input").map{|l| l.chomp.to_i}
		@target = 150
		print @containers
		puts @containers.count
	end
	def get_combinations
		@combinations = Array.new
		@containers.count.times do |i|
			puts i
			@containers.permutation(i + 1).to_a.map{|p| @combinations << p.reject{|p| p.reduce(:+) > @target}}
		end
		print @combinations
	end
end
solve = Containers.new
solve.get_combinations
