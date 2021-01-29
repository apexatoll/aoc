keys = [['x', 'x', 1, 'x', 'x'], ['x', 2, 3, 4, 'x'], [5, 6, 7, 8, 9], ['x', 'A', 'B', 'C', 'x'], ['x', 'x', 'D', 'x', 'x']]
$x = 0
$y = 2
input = File.readlines("input").map{|l| l.chomp.split("")}
output = Array.new
input.each do |line|
	line.each do |cmd|
		case cmd
		when "U"
			$y -= 1 if($y > 0 && keys[$y - 1][$x] != 'x')
		when "D"
			$y += 1 if($y < 4 && keys[$y + 1][$x] != 'x')
		when "L"
			$x -= 1 if($x > 0 && keys[$y][$x - 1] != 'x')
		when "R"
			$x += 1 if($x < 4 && keys[$y][$x + 1] != 'x')
		end
	end
	output << keys[$y][$x]
end
puts output.join
