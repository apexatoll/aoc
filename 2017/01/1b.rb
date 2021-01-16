total = 0
nums = File.readlines("input").map{|n| n.chomp.split("")}.flatten
nums.each_with_index do |num, i|
	index = i + (nums.count / 2)
	if index > nums.count - 1
		index -= nums.count
	end
	if num == nums[index]
		total += num.to_i
	end
end
puts total
