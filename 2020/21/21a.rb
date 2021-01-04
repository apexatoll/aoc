def parse
	$list = Array.new
	$allergens = Array.new
	$ingredients = Array.new
	File.readlines("input").each_with_index do |line, i|
		temp = Hash.new
		temp[:ingredients] = line.gsub(/\s\(.*$/, "").split
		temp[:ingredients].each{|i| $ingredients.push(i)}
		temp[:allergens] = line.gsub(/^.*\(contains\s(.*)\)/, "\\1").chomp.split(", ")
		temp[:allergens].each{|a| $allergens.push(a)}
		$list.push(temp)
	end
	$allergens = $allergens.uniq
end
def loadPossibles
	$possible_matches = Hash.new
	$allergens.each{|allergen| $possible_matches[allergen] = Array.new}
	$list.each do |food|
		food[:allergens].each do |allergen|
			$possible_matches[allergen].push(food[:ingredients])
		end
	end
end
def checkMatches
	$probable_allergens = Array.new
	$possible_matches.each_key do |allergen|
		if $possible_matches[allergen].count > 1
			matches = $possible_matches[allergen][0] & $possible_matches[allergen][1]
			if $possible_matches[allergen].count > 2
				for i in 2..$possible_matches[allergen].count - 1
					matches = matches & $possible_matches[allergen][i]
				end
			end
			matches.each{|m| $probable_allergens.push(m)}
		else
			$possible_matches[allergen][0].each{|m| $probable_allergens.push(m)}
		end
	end
end
def countImpossibles
	total = 0
	impossibles = ($ingredients - $probable_allergens.uniq).uniq
	impossibles.each do |ingredient|
		$list.each do |food|
			food[:ingredients].each do |i|
				if i == ingredient
					total += 1
				end
			end
		end
	end
	return total
end
def solve
	parse
	loadPossibles
	checkMatches
	puts countImpossibles
end
solve
