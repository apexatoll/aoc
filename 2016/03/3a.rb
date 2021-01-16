valid = 0
inputs = File.readlines("input").map do |line|
	line.split(/\s/).reject{|n| n.empty?}.map{|n| n.to_i}.sort
end
inputs.each do |row|
	if(row[0] + row[1]) > row[2]
		valid += 1 
	end
end
puts valid
