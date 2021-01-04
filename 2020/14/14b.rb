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
def dtob(input, bits = $bit)
	output = Array.new(bits, 0)
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
def applyMask(mask, addr)
	mask = mask.split("")
	addr = dtob(addr.to_i).split("")
	mask.each_with_index do |mVal, i|
		if mVal != "0"
			addr[i] = mask[i]
		end
	end
	return addr.join
end
def floatingBits(addr)
	addresses = Array.new
	xCount = addr.count("X")
	xLocs = addr.split("").each_index.select{|i| addr[i] == "X"} 
	for i in 0..2**xCount-1 do
		comb = dtob(i, xCount).split("")
		newAddr = addr.split("")
		xLocs.each_with_index do |loc, j|
			newAddr[loc] = comb[j]
		end
		addresses.push(btod(newAddr.join))
	end
	return addresses
end
def countMem
	total = 0
	$mem.each_value do |value|
		total += value.to_i
	end
	return total
end
def solve
	group
	$groups.each do |group|
		group["cmds"].each do |addr, num|
			newAddr = applyMask(group["mask"], addr)
			addresses = floatingBits(newAddr)
			addresses.each do |address|
				$mem[address] = num
			end
		end
	end
	count = countMem
	puts count
end
solve
