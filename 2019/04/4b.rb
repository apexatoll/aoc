range = File.read("input").chomp.split("-").map(&:to_i)
min = range[0]
max = range[1]
r = /(?!([0-9])\1\1)(.|^)([0-9])\3(?!\3)/
valid = Array.new

for pwd in min..max
	if pwd.to_s =~ r
		nums = pwd.to_s.split("").map(&:to_i)
		if(nums[0] <= nums[1]) and 
		  (nums[1] <= nums[2]) and 
		  (nums[2] <= nums[3]) and 
		  (nums[3] <= nums[4]) and 
		  (nums[4] <= nums[5])
			valid << pwd
		end
	end
end
puts valid.count
