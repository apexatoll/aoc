=begin
If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
Otherwise, the seat's state does not change
=end
$grid = Array.new
File.readlines("example2").each do |line|
	$grid.push(line.chomp.split(""))
end
def countOcc(x, y)
	nOcc = 0
	range = [-1, 0, 1]
	center = $grid[x][y]
	#print center
	#puts "checking #{x}, #{y} = #{center}"
	for i in range
		for j in range
			if(i.to_i != 0 || j.to_i != 0)
				x2 = x.to_i + j.to_i
				y2 = y.to_i + i.to_i
				if(x2.to_i >= 0 && x2.to_i < $grid[0].length)
					if(y2.to_i >= 0 && y2.to_i < $grid.length)
						char = $grid[x2][y2]
						#puts "#{x2}, #{y2} = #{char}"
						if($grid[x2][y2] == "#")
							nOcc +=1
						end
					end
				end
			end
		end
	end
	return nOcc
end
def printGrid
	$grid.each do |row|
		row.each do |char|
			print char
		end
		puts
	end
end

printGrid
#changed = true
#while(changed == true)
	#changed = false
	puts
	nextGrid = Array.new
	$grid.each_with_index do |row, y|
		line = Array.new
		row.each_with_index do |char, x|
			case char
				when "L"
					nOcc = countOcc(x, y)
					puts nOcc
					#if(nOcc.to_i == 0)
						#line.push("#")
						#changed = true
					#else
						#line.push("L")
					#end
				when '#'
					nOcc = countOcc(x, y)
					puts "# #{nOcc}"
					#if(nOcc.to_i >= 4)
						#line.push("L")
						#changed = true
					#else
						#line.push("#")
					#end
				when "."
					#line.push(".")
			end
		end
		nextGrid.push(line)
		puts
	end
	$grid = nextGrid
	#printGrid
#end

