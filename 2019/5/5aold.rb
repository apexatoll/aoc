$commands = File.open("input").read.to_s.chomp.split(",")
input = 1.to_i
index = 0

class Command
	attr_accessor :index
	def getIndices()
		num1index = $commands[index + 1]
		num2index = $commands[index + 2]
		num3index = $commands[index + 3]
	end

end
class Addition
	attr_accessor :code, :indices, :num1, :num2, :num3
		
end
class Multiplication

end
class Input

end
class Output
end

while true do
	command = $commands[index]
	if command.to_i == 99; then break end
	case command
	when /.*1$/
		add = Addition.new()
		add.code = command
		#split = command.split("")
		#if(split.size > 2)then
			#split = split.reverse
			#num1mode = split[2].present? ? split[2] : 0
			#num2mode = split[3].present? ? split[3] : 0
			#num3mode = split[4].present? ? split[4] : 0
		#end
		#puts split
		#index +=4
	when /.*2$/
		split = command.split("")
		if(split.size > 2)then puts "paramater mode!" end
		puts split
		index +=4
	when /.*3$/
		split = command.split("")
		if(split.size > 2) then puts "paramater mode!" end
		puts split
		index +=2
	when /.*4$/
		split = command.split("")
		if(split.size > 2) then puts "paramater mode!" end
		puts split
		index +=2
	end
end

