require "digest"
matches = Hash.new
i = 0
while matches.count < 8
	hash = Digest::MD5.hexdigest "ffykfhsq" + i.to_s
	if hash =~ /^(0){5}/
		hash = hash.split("")
		index = hash[5]
		value = hash[6]
		if ((0..7).to_a.map(&:to_s).include? index) && 
			(!matches.keys.include? index)
				matches[index] = value
		end
	end
	i += 1
end
puts matches.sort.map{|k, v| v}.join
