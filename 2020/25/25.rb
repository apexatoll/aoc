class Door
	attr_reader :key, :value, :loop_size
	def initialize(key, target)
		@key = key
		@target = target
		@divisor = 20201227
		@loop_size = 0
	end
	def transform
		value = 1
		until value == @target
			value *= 7
			value = value % @divisor
			@loop_size += 1
		end
		puts @loop_size
	end
	def encrypt
		value = 1
		key = self.class.to_s == "Door" ? 
			$card.key : $door.key
		@loop_size.times do
			value *= @key
			value = value % @divisor
		end
		puts value
	end
end
class Card < Door; end
class Solve
	def initialize
		$door, $card= [File.readlines("input").map(&:to_i)].map{|d, c| [Door.new(d, c), Card.new(c, d)]}.flatten
		#$door, $card= [[17807724, 5764801]].map{|d, c| [Door.new(d, c), Card.new(c, d)]}.flatten
		#print $door.inspect
		#print $card.inspect
		$door.transform
		$card.transform
		$door.encrypt
		$card.encrypt
	end
end
Solve.new
