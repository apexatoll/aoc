=begin
	 90
	 |
180--+---0
	 |
	270
=end
direction = 0
x=0
y=0
inputs = File.readlines("input").each do |line|
	cmd = line.gsub(/[^A-z]/, "")
	num = line.gsub(/[^0-9]/, "").to_i
	case cmd.to_s
		when "N"; y += num
		when "S"; y -= num 
		when "E"; x += num
		when "W"; x -= num
		when "L"
			direction += num
			if(direction >= 360)
				direction -= 360
			end
		when "R"
			direction -= num
			if(direction < 0)
				direction += 360
			end
		when "F"
			case direction
				when 0;   x+=num
				when 90;  y+=num
				when 180; x-=num
				when 270; y-=num
			end
	end
end
distance = x.abs + y.abs
puts distance
