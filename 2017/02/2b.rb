#puts 8 % 2
total = 0
File.readlines("input").map{|l| l.chomp.gsub(/\t/, ";").split(";")}.each do |line|
#File.readlines("example").map{|l| l.chomp.gsub(/\s/, ";").split(";")}.each do |line|
	line = line.map{|l| l.to_i}.sort
	#print line; puts
	line.each do |num|
		found = false
		line.each do |num2|
			if num!= num2 && num % num2 == 0
				puts num, num2
				puts
				total += (num / num2)
				found = true
				break
			end
		end
		if found == true; break end
	end
end
puts total
