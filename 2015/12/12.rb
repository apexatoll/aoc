require 'json'
input = JSON.parse(File.read("input"))
input.map{|k, v| print v; puts}
