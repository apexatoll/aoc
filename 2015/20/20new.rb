class Solve
	def initialize
		@target = 36000000
	end
	def get_elves(house_number)
		elves = []
		for i in 1..Math.sqrt(house_number).to_i
			if house_number % i == 0
				elves << i << house_number.divmod(i)
			end
		end
		elves.flatten.reject{|e| e == 0}
			.reject{|e| e * 50 < house_number}
	end
	def part_one
		run(10)
	end
	def part_two
		run(11)
	end
	def run(per_elf)
		house = 1
		loop do
			n_presents = get_elves(house).map{|e| e * per_elf}.reduce(:+)
			n_presents < @target? 
				house += 1 : break
		end
		house
	end
end

solve = Solve.new
puts solve.run
#puts solve.get_elves(530)
