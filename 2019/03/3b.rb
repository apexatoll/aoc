wires = []
File.readlines("input").each do |line|
	wires.push(line.split(","))
end
wiresCoords = []
wiresSteps = []
wires.each do |wire|
	x = 0
	y = 0
	steps = 0
	steppedCoords = []
	coords = []
	wire.each do |cmd|
		num = cmd.gsub(/[^0-9]/, "")
		case cmd
			when /^L.*/
				newx = x.to_i - num.to_i
				i = x.to_i
				loop do
					if i == newx; then break end
					coords.push("#{i},#{y}")
					steppedCoords.push("#{i},#{y},#{steps}")
					i-=1
					steps+=1
				end
				newy = y
			when /^R.*/
				newx = x.to_i + num.to_i
				i = x.to_i
				loop do
					if i == newx; then break end
					coords.push("#{i},#{y}")
					steppedCoords.push("#{i},#{y},#{steps}")
					i+=1
					steps+=1
				end
				newy = y
			when /^U.*/
				newy = y.to_i + num.to_i
				j = y.to_i
				loop do
					if j == newy; then break end
					coords.push("#{x},#{j}")
					steppedCoords.push("#{x},#{j},#{steps}")
					j+=1
					steps+=1
				end
				newx = x
			when /^D.*/
				newy = y.to_i - num.to_i
				j = y.to_i
				loop do
					if j == newy; then break end
					coords.push("#{x},#{j}")
					steppedCoords.push("#{x},#{j},#{steps}")
					j-=1
					steps+=1
				end
				newx = x
		end
		x = newx
		y = newy
	end
	wiresCoords.push(coords)
    wiresSteps.push(steppedCoords)
end

matches = wiresCoords[0] & wiresCoords[1]
distances = []
matches.each do |coord|
	if coord != "0,0"
		stepped1 = wiresSteps[0].grep(/^#{coord},.*$/)[0]
		stepped2 = wiresSteps[1].grep(/^#{coord},.*$/)[0]
		d1 = stepped1.gsub(/^.*,(?!.*,)/, "")
		d2 = stepped2.gsub(/^.*,(?!.*,)/, "")
		distance = d1.to_i + d2.to_i
		distances.push(distance)
	end
end
distances.sort
puts distances[0]
