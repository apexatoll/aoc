=begin
#iterate through house numbers
#calculate factors of house number
#this is equivalent to elves that visit
#total presents = sum of (each factor*10)
=end
class Solve
	def initialize
		@target = 36000000
		#@target = 1000000
		#@target = 1000000
	end
	def factor?(bignum, smallnum)
		bignum % smallnum == 0 ? true : false
	end
	def get_elves(house_number)
		max_f = (house_number.to_f**0.5).floor
		(1..max_f).to_a
			.map{|f| f if factor? house_number, f}
			.push(house_number)
			.reject{|f| f == nil}
	end
	def run 
		$house = 1
		while
			n_presents = get_elves($house).map{|e| e * 10}.reduce(:+)
			puts n_presents
			n_presents < @target? 
				$house += 1 : break
		end
		$house
	end
end

solve = Solve.new
puts solve.run
#print solve.get_elves(1000437).map{|e| e*10}.reduce(:+)
#print solve.get_elves(10)
