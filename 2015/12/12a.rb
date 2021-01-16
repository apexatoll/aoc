#input = File.read("input")
#numbers = input.scan(/\d+/).map(&:to_i).r
#print numbers
#print input
#result = File.read("input").scan(/-?\d+/).map(&:to_i).reduce(:+)
#objects = File.read("input").scan(/{.*?}/).reject{|o| o =~ /red/}.flatten.to_s.scan(/-?\d+/).map(&:to_i)
#arrays = File.read("input").scan(/\[.*?\]/).flatten.to_s.scan(/-?\d+/).map(&:to_i)
#result = [objects, arrays].flatten.reduce(:+)
#puts result
puts File.read("input").chomp.scan(/{.*?:"red".*?}/)

