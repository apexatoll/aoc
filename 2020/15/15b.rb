numbers = [9, 3, 1, 0, 8, 4]
target = 30000000
turn = 1
called = Hash.new
numbers.each_with_index do |number, i|
	if i != numbers.length
		called[number] = turn
		turn += 1
	end
end
turn -= 1
called.delete(numbers.last)
last_number = numbers.last
while turn < target do
	if called.has_key?(last_number)
		last_turn = called[last_number]
		called[last_number] = turn
		last_number = turn - last_turn
	else
		called[last_number] = turn
		last_number=0
	end
	turn += 1
end
puts last_number
