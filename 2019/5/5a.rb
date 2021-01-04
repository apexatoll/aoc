commands = File.open("input").read.split(",")
index = 0
input = 1

while  commands[index].to_i != 99
	cmd = commands[index]
	puts cmd
	case cmd.to_s
	when /.*1$/
		if cmd.to_i > 99
			split = cmd.to_s.split("").reverse
			num1mode = split[2].empty? ? 0 : split[2]
			num2mode = split[3].empty? ? 0 : split[3]
		end
		num1 = commands[index + 1]
		num2 = commands[index + 2]
		num3 = commands[index + 3]
		if num1mode.to_i == 0; num1 = commands[num1.to_i] end
		if num2mode.to_i == 0; num2 = commands[num2.to_i] end
		result = num1.to_i + num2.to_i
		commands[num3.to_i] = result
		index += 4
	when /.*2$/
		if cmd.to_i > 99
			split = cmd.to_s.split("").reverse
			num1mode = split[2].empty? ? 0 : split[2]
			num2mode = split[3].empty? ? 0 : split[3]
		end
		num1 = commands[index + 1]
		num2 = commands[index + 2]
		num3 = commands[index + 3]
		if num1mode.to_i == 0; num1 = commands[num1.to_i] end
		if num2mode.to_i == 0; num2 = commands[num2.to_i] end
		result = num1.to_i * num2.to_i
		commands[num3.to_i] = result
		index += 4
	when /.*3$/
		if cmd.to_i > 99
			split = cmd.to_s.split("").reverse
			num1mode = split[2].empty? ? 0 : split[2]
		end
		num1 = commands[index + 1]
		if num1mode.to_i == 0; num1 = commands[num1.to_i] end
		commands[num1.to_i] = input
		index += 2
	when /.*4$/
		if cmd.to_i > 99
			split = cmd.to_s.split("").reverse
			num1mode = split[2].empty? ? 0 : split[2]
		end
		num1 = commands[index + 1]
		if num1mode.to_i == 0; num1 = commands[num1.to_i] end
		puts num1
		index += 2
	end
end
