total = 0
File.readlines("input").map{|l| l.chomp.gsub(/\t/, ";").split(";")}.each do |line|
	line = line.map{|l| l.to_i}.sort
	total += (line[-1] - line[0])
end
puts total
