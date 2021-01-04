input = File.open("input").read.split("\n")
buses = input[1].split(",")
sorted = Hash.new
buses.each_with_index do |bus, i|
	if bus != "x"
		sorted[bus] = i
	end
end

t = 0
step = 1
sorted.each_with_index do |(bus, offset), index|
	while (t + offset.to_i) % bus.to_i != 0
		t += step
	end
	step *= bus.to_i
end
puts t
