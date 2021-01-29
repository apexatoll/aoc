arr = [[2, 1], [2, 3], [4, 2], [4, 4], [4, 5]]
puts arr.detect{|e| arr.count(e) > 1}
