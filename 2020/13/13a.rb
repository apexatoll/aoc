input = File.open("input").read.split("\n")
time = input[0].to_i
buses = input[1].split(",")
buses.delete("x")
buses.each do |bus|
	nearest = 0
	while nearest < time
		nearest+=bus.to_i
	end
	unless defined? $min
		$minbus = bus
		$min = nearest - time
	end
	new = nearest - time
	if new < $min; $min = new; $minbus = bus; end
end
result = $min.to_i * $minbus.to_i
puts result
