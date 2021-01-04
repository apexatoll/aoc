total = 0
File.readlines("input").each do |line|
	mass = line.to_i
	fuel = (mass/3.floor)-2
	total+=fuel
end
puts total
