total = 0
File.readlines("input").each do |line|
	mass = line.to_i
	fuel = (mass/3.floor)-2
	total+=fuel
	while fuel > 0 do
		fuel = (fuel/3.floor)-2
		if fuel > 0
			total+=fuel
		end
	end
end
puts total
