wires = []
wiresCoords = []
File.readlines("input").each do |line|
	wires.push(line.split(","))
end
wires.each do |wire|
	x = 0
	y = 0
	coords = []
	wire.each do |cmd|
		num = cmd.gsub(/[^0-9]/, "")
		case cmd
			when /^L.*/
				newx = x.to_i - num.to_i
				newy = y
			when /^R.*/
				newx = x.to_i + num.to_i
				newy = y
			when /^U.*/
				newy = y.to_i + num.to_i
				newx = x
			when /^D.*/
				newy = y.to_i - num.to_i
				newx = x
		end
		case cmd
			when /^[LR]/
				for i in x..newx do
					coords.push("#{i},#{y}")
				end
			when /^[UD]/
				for i in y..newy do
					coords.push("#{x},#{i}")
				end
		end
		x = newx
		y = newy
	end
	wiresCoords.push(coords)
end

matches = wiresCoords[0] & wiresCoords[1]
distances = []

matches.each do |coord|
	x = coord.gsub(/,.*$/, "")
	y = coord.gsub(/^.*,/, "")
	if x.to_i < 0; x = x.to_i * -1 end
	if y.to_i < 0; y = y.to_i * -1 end
	distance = x.to_i + y.to_i
	distances.push(distance)
end

distances = distances.sort
result = distances[0]
puts result
