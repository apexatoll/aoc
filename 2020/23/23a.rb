input = 739862541
$cups = input.to_s.split("").map(&:to_i)
100.times do
	curr = $cups[0]
	move = $cups.slice!(1..3)
	dest = (curr - 1) == 0 ? 9 : curr -1 
	while move.include? dest
		dest-=1
		dest = dest == 0 ? 9 : dest
	end
	dest_index = $cups.index(dest).to_i
	$cups.insert(dest_index + 1, move).flatten!.rotate!
end
($cups.rotate!) while $cups[0] != 1 
puts $cups.drop(1).join
