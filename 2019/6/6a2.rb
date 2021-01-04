$inputs = File.open("input").read.split("\n")

def orbits(input)
	$count = 0
	#direct = $inputs.grep(/^#{input}\)/)
	if direct.size == 0; then
		return 0
	else
		$count += direct.size
		for i in 0..direct.size - 1
			direct[i] = direct[i].to_s.gsub(/^.*\)/, "")
		end
		direct.each do |child|
			$count += orbits(child.to_s)
		end
		return $count
	end
end

total = orbits("COM")
puts total
=begin
all that orbits com is
num direct + all that orbits B
all that orbits B is G + C + all that orbits G + all that orbits C
=end


