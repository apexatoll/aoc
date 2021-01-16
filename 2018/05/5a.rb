$input = File.read("input")
check = true
r = /(([a-z])\U\2|([A-Z])\L\3)/
while $input =~ r
	$input = $input.gsub(r, "")
end
puts $input
puts $input.size
