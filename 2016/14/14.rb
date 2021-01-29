require 'digest'
class Solve
	def initialize
		#@input = "zpqevtbw"
		@input = "abc"
		@threes = {}
		@fives = {}
		@keys = []
	end
	def get_keys
		#10000.times do |n|
		n = 0
		while @keys.length < 64
			key = generate(n)
			if /(\w)\1\1/.match?(key)
				@threes[n] = [key.scan(/(\w)\1\1/).first.first, key]
			end
			if /(\w)\1\1\1\1/.match?(key)
				puts "Five"
				puts key
				char = key.scan(/(\w)\1\1\1\1/).first.first
				#puts char
				#puts n
				check_keys(n, char)
				#@keys << key if 
			end
			n += 1
		end
		print @keys
	end
	def check_keys(n, char)
		prev = @threes.select{|k, v| k <= n && k > n - 1000}.select{|k, v| v[0] == char }&.first
		if prev != nil
			puts prev[1][1]
			@keys << {prev[0] => prev[1][1]}
			@threes.delete(prev[0])
		end

			

	end
	def generate(n)
		str = @input + n.to_s
		md5 = Digest::MD5.new
		md5 << str
		md5.hexdigest
	end
end
solve = Solve.new
puts solve.get_keys

