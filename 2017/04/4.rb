#class Passphrases
	#def initialize
		#@phrases = File.readlines("input").map

#end
print File.readlines("input").count - 
	  File.readlines("input").map{|l| l.chomp.split(" ")}
		.map{|l| l.detect{|w| l.count(w) > 1}}
		.select{|p| p != nil}
		.count
