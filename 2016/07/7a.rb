r = /(?:(?<!\[(?!\])))/
#(.)([^\1])\2\1/
count = 0
File.readlines("input").each do |line|
	puts line
	if line =~ r
		count += 1
	end
end
puts count
