lines = File.readlines("input").map{|l| l.chomp.split("")}
per_line = lines[0].count
sorted = Array.new
per_line.times{|i| sorted << lines.map{|n| n[i]}}
out = sorted.map do |col|
	freq = Hash.new
	col.uniq.map{|c| freq[c] = col.count(c)}
	freq.sort_by{|k, v| v}.map{|k, v| k}.take(1)
end.join
puts out
