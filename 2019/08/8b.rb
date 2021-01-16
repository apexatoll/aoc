area = 25 * 6
input = File.open("input").read
array = input.scan(/.{#{area}}/)

outImage = []

for i in 0..area - 1
	searchLevel = 0
	num = array[searchLevel][i..i].to_i
	if num == 0 
		outImage[i] = num
		next
	elsif num == 1 
		outImage[i] = num
		next
	else
		while num == 2
			num = array[searchLevel][i..i].to_i
			searchLevel += 1
		end
		outImage[i] = num
	end
end
outImage = outImage.join
outImage = outImage.gsub(/0/, " ")
outImage = outImage.gsub(/1/, "@")
puts outImage.scan(/.{25}/)

