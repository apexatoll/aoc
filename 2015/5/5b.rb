#!/usr/bin/env ruby

count = 0
File.readlines("input").each do |line|
	if line =~ /(.*(.)\2(?!\2[^\2]).*){2,}/ and line =~ /(.)(.)\1/
		p "#{line}"
		count+=1
	end
end
puts "#{count}"
