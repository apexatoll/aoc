keys = [['x', 'x', 1, 'x', 'x']['x', 2, 3, 4, 'x'], [5, 6, 7, 8, 9], ['x', 'A', 'B', 'C', 'x'], ['x', 'x', 'D', 'x', 'x']]
$x, $y = 1, 1
input = File.readlines("input").map{|l| l.chomp.split("")}
output = Array.new
input.each do |line|
	line.each do |cmd|
		case cmd
		when "U"
			$y -= 1 if($y > 0)
		when "D"
			$y += 1 if($y < 2)
		when "L"
			$x -= 1 if($x > 0)
		when "R"
			$x += 1 if($x < 2)
		end
	end
	output << keys[$y][$x]
end
puts output.join
