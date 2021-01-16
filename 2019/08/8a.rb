area = 25 * 6
input = File.open("input").read
array = input.scan(/.{1,#{area}}/)

string = array[0]
minzeros = array[0].to_s.count("0")

array.each do |layer|
	zeros = layer.to_s.count("0")
	if(zeros < minzeros)
		minzeros = zeros
		string = layer
	end
end
num1s = string.count("1")
num2s = string.count("2")
result = num1s * num2s
puts result
