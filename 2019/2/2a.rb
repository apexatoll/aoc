$cmds = File.open("input").read.split(",")
$index = 0
$cmds[1]=12
$cmds[2]=2

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
puts $cmds[0]
