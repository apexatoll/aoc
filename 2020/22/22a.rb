def parse
	cards = File.read("input").split("\n\n")
	$p_one = cards[0].split("\n").drop(1).map(&:to_i)
	$p_two = cards[1].split("\n").drop(1).map(&:to_i)
	$n_cards = 2 * $p_one.count
end
def playround
	card_p1 = $p_one[0].to_i
	card_p2 = $p_two[0].to_i
	$p_one = $p_one.drop(1)
	$p_two = $p_two.drop(1)
	if card_p1 > card_p2; $p_one.push(card_p1).push(card_p2)
	else; $p_two.push(card_p2).push(card_p1) end
end
def playgame
	while($p_one.length != 0 && $p_two.length != 0)
		playround
	end
	if $p_one.length > $p_two.length; $winner = $p_one
	else; $winner = $p_two end
end
def count
	total = 0
	rev = $winner.reverse
	rev.each_with_index do |num, i|
		i += 1
		total += num.to_i * i.to_i
	end
	return total
end
def solve
	parse
	playgame
	puts count
end
solve
