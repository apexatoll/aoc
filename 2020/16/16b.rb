inputs = File.open("input").read.split("\n\n")
rules = inputs[0].gsub(/(:\s|\sor\s|-)/, ";").split("\n")
rules.map!{|rule| rule.split(";")}
own = inputs[1].split("\n")[1].split(",")
$nearby = Array.new
inputs[2].split("\n").each_with_index do |line, i|
	if i > 0; $nearby.push(line.split(",")) end
end

valid_tickets = Array.new
num_fields = $nearby[0].count
error = 0
output = 1

$nearby.each_with_index do |ticket, index|
	fields_valid = 0
	ticket.each do |field|
		field_valid = false
		rules.each do |rule|
			if(field.to_i >= rule[1].to_i && field.to_i <= rule[2].to_i) || (field.to_i >= rule[3].to_i && field.to_i <= rule[4].to_i)
				field_valid = true
			end
		end
		if field_valid == true
			fields_valid += 1
		else
			error+=field.to_i
		end
	end
	if fields_valid == num_fields
		valid_tickets.push(ticket)
	end
end

candidates = Hash.new
rules.each do |rule|
	candidates[rule[0]] = Array.new
	for col in 0..num_fields - 1
		val_rows = 0
		for row in 0..valid_tickets.count - 1
			value = valid_tickets[row][col].to_i
			if(value >= rule[1].to_i && value <= rule[2].to_i) or (value >= rule[3].to_i && value <= rule[4].to_i)
				val_rows +=1
			end
		end
		if(val_rows == valid_tickets.count)
			candidates[rule[0]].push(col)
		end
	end
end

positions = Hash.new
while positions.count != num_fields
	candidates.each_key do |rule|
		if candidates[rule].count == 1
			positions[rule] = candidates[rule]
			num = candidates[rule][0].to_i
			candidates.delete(rule)
			candidates.each_key do |key|
				candidates[key].delete(num)
			end
		end
	end
end

depPos = Array.new
depKeys = positions.keys.grep(/^departure.*$/)
depKeys.each{|key| depPos.push(positions[key][0].to_i)}
depPos.each{|pos| output *= own[pos].to_i}
puts output
