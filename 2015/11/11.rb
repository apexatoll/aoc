class Password
	def initialize(input)
		@pwd_string = input
	end
	def get_next
		@valid = false
		while @valid == false
			increment
			validate
		end
		@pwd_string
	end
	def increment
		set = false
		@pwd_nums = @pwd_string.split("").map{|l| l.ord}.reverse.map do |n|
			if set == false
				n += 1
				n > "z".ord ?  n -= 26 : set = true
			end
			n
		end.reverse
		@pwd_string = @pwd_nums.map{|n| n.chr}.join
	end
	def validate
		return if @pwd_string =~ /(i|o|l)/
		return if inc_rule  == false
		return if pair_rule == false
		@valid = true
	end
	def inc_rule
		for i in 0..5
			a,b,c = @pwd_nums[i], @pwd_nums[i+1], @pwd_nums[i+2]
			return true if c == (b + 1) && b == (a + 1)
		end
		return false
	end
	def pair_rule
		pairs = @pwd_string.gsub(/((.)(?!\2)|((.)\4*))/, "\\1;")
			.split(";")
			.select{|p| p.length == 2}
		return pairs.count < 2 ? false : true
	end
end
pwd = Password.new("hxbxwxba")
2.times{puts pwd.get_next}
