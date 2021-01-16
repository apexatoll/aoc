class Room
	attr_accessor :id, :checksum, :chars, :valid
	def initialize(id, checksum, chars)
		@id = id
		@checksum = checksum
		@chars = chars
		@valid = false
	end
	def validate
		counted = Hash.new
		@chars.uniq.each{|c| counted[c] = @chars.count(c)}
		counted = counted.sort_by{|c, n| [-n, c]}.take(5).map{|k, v| k}
		if counted == @checksum
			@valid = true
		end
	end
end
class Rooms
	attr_accessor :rooms, :sum
	def initialize
		@rooms = Array.new
		File.readlines("input").each do |l|
			id = l.gsub(/[^0-9]/, "").to_i
			checksum = l.gsub(/^.*\[(.*)\]$/, "\\1").chomp.split("")
			chars = l.gsub(/-(?!.*-).*$/, "")
				.chomp.split("-").join.split("")
			@rooms << Room.new(id, checksum, chars)
		end
	end
	def sumValid
		@sum = @rooms.each{|r| r.validate}
			.find_all{|r| r.valid == true}
			.map{|r| r.id}
			.reduce(:+)
		return @sum
	end
end
def solve
	puts Rooms.new.sumValid
end
solve


