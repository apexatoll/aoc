def parse
	inputs = File.open("example").read.split("\n\n")
	$rules = inputs[0].split("\n")
	$messages = inputs[1].split("\n")
end
def getRule(num)
	rule = $rules.grep(/^#{num}:/).map{|r| r.gsub(/^.*:\s/, "")}
	puts rule
end
def findEnds
	ends = Array.new
	$rules.grep(/^[0-9]*:.*[ab].*$/).map{|r| ends.push(r.gsub(/:.*$/, ""))}
	ends.each do |e|
		letter = $rules.grep(/^#{e}:/).map{|r| r.gsub(/^.*:.*([ab]).*$/, "\\1")}
		$keys[e] = letter
	end
end
def translate
	$keys.each do |k, v|
		$rules.each do |rule|
			rule.gsub(/^(?:[0-9]*:\s)#{k}/, v)
		end
	end
end
def solve
	$keys = Hash.new
	parse
	findEnds
	translate
	puts $rules
end
solve
