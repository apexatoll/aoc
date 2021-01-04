$inputs = File.open("example").read.split("\n")
all = []
starts = []
$count = 0
def count(input)
	parent = $inputs.grep(/\)#{input}$/).to_s.gsub(/\).*$/, "").gsub(/\["/, "")
	if parent != "COM"
		$count+=parent.size
		count(parent)
	end
end
$inputs.each do |line|
	parts = line.split(")")
	all.push(parts[0]) 
	all.push(parts[1]) 
end
all = all.uniq
all.each do |orbiter|
	match = $inputs.grep(/^#{orbiter}\)/)
	if match.size == 0; then
		starts.push(orbiter)
	end
end
starts.each do |start|
	count(start)
end
puts $count
