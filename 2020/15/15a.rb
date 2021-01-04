numbers = [9, 3, 1, 0, 8, 4]
find = 2020
while numbers.length < find
	last_turn = numbers.length
	last_number = numbers.last
	if numbers.find_index(last_number).to_i + 1 == last_turn.to_i
		numbers.push(0)
	else
		turns_said = numbers.each_index.select {|i| numbers[i]==last_number }
		turn_diff = turns_said.reverse[0] - turns_said.reverse[1]
		numbers.push(turn_diff.to_i)
	end
end
puts numbers[find - 1]
