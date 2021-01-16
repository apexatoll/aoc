lines = File.readlines("input")
f = 0
found = false
nums = Hash.new
while found == false
	lines.each do |line|
		op = line.gsub(/[^+-]/, "")
		num = line.gsub(/[^0-9]/, "").to_i
		case op
			when "+"; f += num
			when "-"; f -= num
		end
		if nums[f] == true
			found = true
			break
		else
			nums[f] = true
		end
	end
end
puts f
