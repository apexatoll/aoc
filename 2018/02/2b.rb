lines = File.readlines("input")
found = false
lines.each do |l1|
	if found == false
		chars1 = l1.split("")
		lines.each do |l2|
			diff = 0
			chars2 = l2.split("")
			chars1.each_with_index do |char, i|
				if char != chars2[i]
					diff += 1
					$index = i
				end
			end
			if diff == 1
				found = true
				$str1 = l1
				$str2 = l2
				break
			end
		end
	end
end
puts $index
out = $str1.split("")
out.delete_at($index.to_i)
puts out.join
