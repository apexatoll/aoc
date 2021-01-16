n2, n3 = 0, 0
File.readlines("input").map{|l| l.chomp.split("")}.each do |line|
	count_2 = false
	count_3 = false
	line.each do |char|
		if line.count(char) == 2; count_2 = true
		elsif line.count(char) == 3; count_3 = true end
		if count_2 == true && count_3 == true; break end
	end
	if count_2 == true; n2 += 1 end
	if count_3 == true; n3 += 1 end
end
puts n2 * n3
