ship_x=0
ship_y=0
waypoint_x = 10
waypoint_y = 1
File.readlines("input").each do |line|
	cmd = line.gsub(/[^A-z]/, "")
	num = line.gsub(/[^0-9]/, "").to_i
	case cmd.to_s
		when "N"; waypoint_y += num
		when "S"; waypoint_y -= num 
		when "E"; waypoint_x += num
		when "W"; waypoint_x -= num
		when "L"
			case num
				when 90
					waypoint_x, waypoint_y = waypoint_y, waypoint_x
					waypoint_x *= -1
				when 180
					waypoint_x *= -1
					waypoint_y *= -1
				when 270
					waypoint_x, waypoint_y = waypoint_y, waypoint_x
					waypoint_y *= -1
			end
		when "R"
			case num
				when 90
					waypoint_x, waypoint_y = waypoint_y, waypoint_x
					waypoint_y *= -1
				when 180
					waypoint_x *= -1
					waypoint_y *= -1
				when 270
					waypoint_x, waypoint_y = waypoint_y, waypoint_x
					waypoint_x *= -1
			end
		when "F"
			ship_x += (waypoint_x * num)
			ship_y += (waypoint_y * num)
	end
end
distance = ship_x.abs + ship_y.abs
puts distance
