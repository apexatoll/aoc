class Room
	attr_accessor :id, :checksum, :chars, :valid, :message
	def initialize(id, checksum, chars)
		@id = id
		@checksum = checksum
		@chars = chars
	end
	def validate
		counted = Hash.new
		@valid = false
		@chars.uniq.each{|c| counted[c] = @chars.count(c) if(c != "-")}
		counted = counted
			.sort_by{|c, n| [-n, c]}
			.take(5)
			.map{|k, v| k}
		@valid = true if counted == @checksum
	end
	def decipher
		@message = @chars.map{|c| c.ord}.map do |c|
			case c
			when "-".ord
				c = " ".ord
			else
				c += @id % 26
				c -= 26 if c > "z".ord
			end
			c.chr
		end.join
	end
end
class Rooms
	attr_accessor :rooms, :sum
	def initialize
		@rooms = Array.new
		File.readlines("input").each do |l|
			id = l.gsub(/[^0-9]/, "").to_i
			checksum = l.gsub(/^.*\[(.*)\]$/, "\\1").chomp.split("")
			chars = l.gsub(/-(?!.*-).*$/, "").chomp.split("")
			@rooms << Room.new(id, checksum, chars)
		end
	end
	def getMessage
		out = @rooms.each{|r| r.validate}
			.find_all    {|r| r.valid == true}
			.each        {|r| r.decipher}
			.select      {|r| r.message =~ /north/}
			.map         {|r| r.id.to_s + " " + r.message}
		return out
	end
end
def solve
	puts Rooms.new.getMessage
end
solve
