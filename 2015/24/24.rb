class Solve
	def initialize
		@packages = File.readlines("input").map(&:to_i)
		@group_weight = @packages.reduce(:+) / 3
		@combinations = []
	end
	def find_group
		copy = @packages
		attempt = Array.new
		while attempt.empty? || attempt.reduce(:+) < @group_weight
			attempt << copy.shuffle.pop
		end
		attempt.reduce(:+) == @group_weight ?
			attempt : find_combination
	end
	def validate(group)
		#puts group
	end
	def find_combination
		group_1 = find_group
		print group_1
		print @packages
		#remainder = @packages.dup - group_1
		#print remainder
		#validate remainder
		#group_2 = find_group(@packages.dup - group_1)
		#print group_1
		#print group_2
		#print @combinations[0]
		#print @packages - @combinations[0]
	end
end
solve = Solve.new
solve.find_combination
