require "digest"
input = "ffykfhsq"
strings = Array.new
i = 0
while strings.count < 8
	hash = Digest::MD5.hexdigest input + i.to_s
	if hash =~ /^(0){5}/
		strings << hash 
		puts "found"
	end
	i += 1
end
out = strings.map{|s| s.split("")}.map{|s| s[5]}.join
puts out
