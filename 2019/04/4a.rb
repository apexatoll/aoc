input = File.open("input").read.chomp
min = input.gsub(/-.*$/, "").to_i
max = input.gsub(/^.*-/, "").to_i
matches = []

for i in min..max do
	num = i.to_s.split("")
	if i.to_s.match(/([0-9])\1/); then
		if(num[0].to_i <= num[1].to_i) and 
			(num[1].to_i <= num[2].to_i) and 
			(num[2].to_i <= num[3].to_i) and 
			(num[3].to_i <= num[4].to_i) and 
			(num[4].to_i <= num[5].to_i) then 
				matches.push(i)
		end
	end
end
print matches.count
