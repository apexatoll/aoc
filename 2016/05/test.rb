hash = {0 => 1, 1=>3, 2=>3, 3=>3, }
puts "complete" if((0..4).to_a - hash.keys).empty?


puts hash.select{|k, v| (0..3).to_a.include? k}
#[0, 2].each{ if hash.keys.include? 
