$lines = File.open("example").read.split("\n")
def op(num1, num2)
	case $operator.to_s
	when "*"
		return num1.to_i * num2.to_i
	when "-"
		return num1.to_i - num2.to_i
	when "+"
		return num1.to_i + num2.to_i
	when "/"
		return num1.to_i / num2.to_i
	end
end
def calculate(line)
	puts line
	$num = false
	chars = line.split(" ")
	chars.each do |char|
		case char.to_s
		when /[0-9]*/
			if $num == false
				$num = char.to_i
			else 
				$num = op($num.to_i, char.to_i)
			end

			puts $num
		when /[\*\-+]/
			$operator = char
			puts $operator
		end
	end
	return $num
end

number = calculate($lines[0])
puts number

#9 * 8 + 2 + (4 * (2 * 2 + 9 * 2) * 9 * 3 * 8) + 8 * 5
