inputs = File.open("input").read.split("\n\n")
rules = inputs[0].gsub(/(:\s|\sor\s|-)/, ";").split("\n")
rules.map!{|rule| rule.split(";")}
own = inputs[1].split("\n")[1].split(",")
nearby = Array.new
inputs[2].split("\n").each_with_index do |line, i|
	if i > 0; nearby.push(line.split(",")) end
end
min = rules[0][1]
max = rules[0][2]
error = 0
rules = rules.sort_by{|a, b| b}
rules.each do |rule|
	if rule[2] <= max
		next
	else
		if rule[1] <= max
			max = rule[2]
		else
			min = rule[1]
			max = rule[2]
		end
	end
end
rules = rules.sort_by{|a, b, c, d| d }
rules.each do |rule|
	if rule[3] < max && rule[4] > max
		max = rule[4]
	end
end
nearby.each_with_index do |ticket, i|
	ticket.each_with_index do |field, ii|
		if field.to_i < min.to_i || field.to_i > max.to_i
			error += field.to_i
		end
	end
end
puts error
