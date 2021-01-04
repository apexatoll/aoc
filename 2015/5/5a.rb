#!/bin/ruby

count = 0
File.readlines("input").each do |line|
	if line =~ /^(.*[aeiou].*){3,}/ && line =~ /(.)\1/ && line =~ /^((?!xy|ab|cd|pq).)*$/
		puts "#{line} is nice "
		count+=1
	end
end
puts "#{count}"
