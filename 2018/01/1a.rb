lines = File.readlines("input")
f = 0
lines.each do |line|
	op = line.gsub(/[^+-]/, "")
	num = line.gsub(/[^0-9]/, "").to_i
	case op
		when "+"; f += num
		when "-"; f -= num
	end
end
puts f
