class Address
	attr_reader :in_brackets, :out_brackets, :valid_TLS, :valid_SSL
	def initialize(line)
		@in_brackets  = line.scan(/(?<=\[)\w+(?=\])/).join(" ")
		@out_brackets = line.gsub(/(?<=\[)\w+(?=\])/, "").split("[]").join(" ")
		@valid_TLS = validate_TLS
		@valid_SSL = validate_SSL
	end
	def validate_TLS
		r = /(\w)(\w)(?!\1)\2\1/
		(r.match? @out_brackets) && !(r.match? @in_brackets) ? 
			true : false
	end
	def validate_SSL
		@out_brackets.scan(/(?=((\w)(?!\2)\w\2))/)
			.flatten.uniq
			.reject{|s| s.length != 3}
			.map{|s| s.split("")}
			.map{|s| [s[1], s[0], s[1]].join}
			.map{|s| @in_brackets.match? s}.any? true
	end
end
class Solve
	def initialize
		@as = File.readlines("input").map{|l| Address.new(l.chomp)}
	end
	def part_one 
		@as.select{|a| a.valid_TLS == true}.count
	end
	def part_two
		@as.select{|a| a.valid_SSL == true}.count
	end
end
solve = Solve.new
puts solve.part_one
puts solve.part_two
