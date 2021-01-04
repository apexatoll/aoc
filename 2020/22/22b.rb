def parse
	cards = File.read("input").split("\n\n")
	$p_one = cards[0].split("\n").drop(1).map(&:to_i)
	$p_two = cards[1].split("\n").drop(1).map(&:to_i)
	$n_cards = 2 * $p_one.count
	$p1_played = Hash.new
	$p2_played = Hash.new
	$game_number = 1
	$total_games = 1
	$p1_played[$game_number] = Array.new
	$p2_played[$game_number] = Array.new
end
def playgame(p1_hand = $p_one, p2_hand = $p_two)
	while(p1_hand.length != 0 && p2_hand.length != 0)
		p1_str = p1_hand.join(",")
		p2_str = p2_hand.join(",")
		if $p1_played[$game_number].include? p1_str or $p2_played[$game_number].include? p2_str
			winner = Hash.new
			winner["p1"] = p1_hand
			return winner
		end
		$p1_played[$game_number] << p1_str
		$p2_played[$game_number] << p2_str
		card_p1 = p1_hand[0].to_i
		card_p2 = p2_hand[0].to_i
		p1_hand = p1_hand.drop(1)
		p2_hand = p2_hand.drop(1)
		if p1_hand.length >= card_p1 && p2_hand.length >= card_p2
			old_game_number = $game_number
			$game_number = $total_games + 1
			$total_games += 1
			$p1_played[$game_number] = Array.new
			$p2_played[$game_number] = Array.new
			new_p1_hand = p1_hand.take(card_p1)
			new_p2_hand = p2_hand.take(card_p2)
			winner = playgame(new_p1_hand, new_p2_hand)
			case winner.keys[0]
				when "p1"; p1_hand << card_p1 << card_p2
				when "p2"; p2_hand << card_p2 << card_p1
			end
			$game_number = old_game_number
		elsif card_p1 > card_p2
			p1_hand << card_p1 << card_p2
		elsif card_p1 < card_p2
			p2_hand << card_p2 << card_p1
		end
	end
	winner = Hash.new
	if p1_hand.length > p2_hand.length
		winner["p1"] = p1_hand
	else
		winner["p2"] = p2_hand
	end
	return winner
end
def count(hand)
	total = 0
	rev = hand.reverse
	rev.each_with_index do |num, i|
		i += 1
		total += num * i
	end
	return total
end
def solve
	parse
	winner = playgame
	puts count(winner.values[0])
	puts winner.keys
end; solve
puts $total_games
