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
def getPossible
	$possible = Hash.new
	$allergens.each{|a| $possible[a] = Array.new}
	$list.each do |food|
		food[:allergens].each do |a|
			$possible[a].push(food[:ingredients])
		end
	end
end
def findAllergens
	$candidates = Hash.new
	$possible.each_key do |a|
		$candidates[a] = Array.new
		if $possible[a].count > 1
			matches = $possible[a][0] & $possible[a][1]
			if $possible[a].count > 2
				for i in 2..$possible[a].count - 1
					matches = matches & $possible[a][i]
				end
			end
			matches.each{|m| $candidates[a].push(m)}
		else
			$possible[a][0].each{|m| $candidates[a].push(m)}
		end
	end
end
def pair
	$confirmed = Hash.new
	while $confirmed.length != $allergens.length
		$candidates.each_key do |a|
			if $candidates[a].count == 1
				$confirmed[a] = $candidates[a][0]
				delete = $candidates[a][0]
				$candidates.map{|k, v| $candidates[k].delete(delete)}
			end 
		end
	end
end

def make_list
	$confirmed = $confirmed.sort
	answer = $confirmed.map{|k, v| "#{v}"}.join(",")
	return answer
end
def solve
	parse
	getPossible
	findAllergens
	pair
	puts make_list
end
solve
