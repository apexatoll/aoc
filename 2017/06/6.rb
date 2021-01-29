require 'digest'
class Memory
	def initialize
		@banks = File.read("input").chomp.split("\t")
			.map.with_index{|b, i| [i, b.to_i]}.to_h
		@n = @banks.count
		@states = {}
		@steps = 0
		store
	end
	def run
		key = @banks.sort_by{|i, b| [-b, i]}.first.first
		(1..@banks[key]).to_a.each do |i|
			nxt = i + key
			nxt -= @n while nxt >= @n
			@banks[nxt] += 1
			@banks[key] -= 1
		end
		@steps += 1
	end
	def store
		str = @banks.flat_map{|i, b| [i, b]}.join(";")
		hash = Digest::MD5.new
		hash << str
		hash.hexdigest
	end
	def part_one
		while
			run
			hash = store
			@states[hash] == true ?  break : @states[hash] = true
		end
		@steps
	end
	def part_two
		part_one
		find = @banks
		endp = @steps
		initialize
		run while @banks != find
		endp - @steps
	end
end
mem = Memory.new
puts mem.part_one
puts mem.part_two
