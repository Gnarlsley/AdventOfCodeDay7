file = File.open"puzzle.txt"

#Place all lines from file into an array and "chomp" off the new line character
file_data = file.readlines.map(&:chomp)

# Explanation of the map chain:
# .map { |x| *some process* } processes every index of the array and returns a new array.

# Use map to process the data:
# 1. Split each line on the ":" character.
#    Example: ['123: 10 10 10', '234: 20 20 20'] becomes [[123, "10 10 10"], [234, "20 20 20"]]
# 2. Chain another map call to iterate through each subarray.

# For a two-dimensional array like [[123, "10 10 10"], [234, "20 20 20"]]:
# - The first map processes each subarray: [123, "10 10 10"] and [234, "20 20 20"].
# - The second map processes elements within the subarray.

# In the second map, use .with_index to specify the index to transform:
# - Only the element at index 1 (the second element) is split.
# - Other elements remain unchanged.

# Example transformation:
# Input: ["123: 10 10 10", "234: 20 20 20"] all of type string
# After processing: [[123, [10, 10, 10]], [234, [20, 20, 20]]] all of type integer

#Congrats, parsing the data in one line has never been easier


file_data_split = file_data.map{|x| x.split(":")}.map{|x| x.map.with_index{|element, index| index == 1 ? element.split.map(&:to_i) : element.to_i}}

puts file_data_split[0][0]


file.close