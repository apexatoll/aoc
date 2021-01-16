valid = 0
inputs = File.readlines("input").map do |line|
	line.split(/\s/).reject{|n| n.empty?}.map{|n| n.to_i}
end
cols = Array.new
3.times do |i|
	cols << inputs.each{|l|}.map{|n| n[i]}.each_slice(3).to_a
end
cols = cols.flatten(1).map{|row| row.sort}
cols.each do |row|
	if(row[0].to_i + row[1].to_i) > row[2].to_i
		valid += 1 
	end
end
puts valid
