#!/bin/env ruby


$lineCount=File.open("input").each_line.count
$table=Array.new($lineCount)
i = 0

File.readlines("input").each do |line|
	$table[i] = line.split(//)
	$table[i].pop()
	i+=1
end
$charCount = $table[0].count
$range = [-1, 0, 1]

def countOcc(x, y)
	occ=0
	for i in $range do
		for j in $range do
			x2 = x + i
			y2 = y + j
			if((x2 >= 0 && x2 < $charCount) && (y2 >= 0 && y2 < $lineCount))
				if(i != 0 || j != 0)
					if $table[x2][y2] == "#"
						occ+=1
					end
				end
			end
		end
	end
	return occ
end

def switchChar(x, y)
	char = $table[x][y]
	numOcc = countOcc x, y
	case char
	when "L"
		if(numOcc == 0)
			switched = "#"
		end
	when "#"
		if(numOcc >= 4)
			switched = "L"
		end
	when "."
		switched = "."
	end
	return switched
end

$newTable = Array.new($lineCount)
for l in 0..$lineCount - 1
	#puts l
	$newTable[l] = Array.new($charCount)
	for k in 0..$charCount - 1
		#puts k
		char = switchChar(k, l)
		#newTable[l].push(char)
	end
end
