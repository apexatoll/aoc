$target = 19690720
found = false
for i in 0..99 do
	if(found == true); break end
	for j in 0..99 do
		$cmds = File.open("input").read.split(",")
		$index = 0
		$cmds[1]=i.to_i
		$cmds[2]=j.to_i
		while true do
			cmd=$cmds[$index].to_i
			if(cmd == 99); then break end
			num1 = $cmds[$index + 1].to_i
			num2 = $cmds[$index + 2].to_i
			num3 = $cmds[$index + 3].to_i
			case cmd
			when 1
				$cmds[num3] = $cmds[num1].to_i + $cmds[num2].to_i
			when 2
				$cmds[num3] = $cmds[num1].to_i * $cmds[num2].to_i
			end
			$index+=4
		end
		if($cmds[0].to_i == $target); then 
			$final = (100 * i.to_i) + j.to_i
			found = true
		end
	end
end
puts $final
