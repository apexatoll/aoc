$bit = 36
$mem = Hash.new
def group
	$groups = Array.new
	File.readlines("input").each do |line|
		if line =~ /^mask/
			if defined? $buffer
				$groups.push($buffer)
			end
			$buffer = Hash.new
			$buffer["mask"] = line.gsub(/^.*=\s/, "").chomp
			$buffer["cmds"] = Hash.new
		else
			mem = line.gsub(/^.*\[(.*)\].*$/, "\\1").chomp
			num = line.gsub(/^.*=\s/, "").chomp
			$buffer["cmds"][mem] = num
		end
	end
	$groups.push($buffer)
end
def dtob(input)
	output = Array.new($bit, 0)
	remainder = input
	while remainder > 0
		n = 0
		while 2**n <= remainder
			n += 1
		end
		n -= 1
		output[n] = 1
		remainder -= 2**n
	end
	output = output.reverse.join("")
	return output
end
def btod(input)
	input = input.split("").reverse
	output = 0
	input.each_with_index do |part, index|
		output += 2**index * part.to_i
	end
	return output
end
def applyMask(mask, num)
	mask = mask.split("")
	num = dtob(num.to_i).split("")
	num.each_with_index do |pos, i|
		if mask[i].to_s != "X"
			num[i] = mask[i]
		end
	end
	num = btod(num.join)
	return num
end
def solve
	group
	$groups.each do |group|
		group["cmds"].each do |mem, num|
			newNum = applyMask(group["mask"], num)
			$mem[mem] = newNum
		end
	end
	total = 0
	$mem.each do |loc, value|
		total += value
	end
	puts total
end

solve
