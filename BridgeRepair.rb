def getPuzzleInput(file)

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

end

def solveEquations(input_data, base)
  #keep track of all the equations that are solvable
  sums = []
  #iterate through each entry in the input data
  input_data.each do |entry|
    #save the target answer and the list of numbers
    target, numbers = entry
    #position of operators maps to base^(n-1) where n is the number of numbers
    total_configurations = base ** (numbers.size - 1)
    #test the equation for every configuration
    total_configurations.times do |i|
      #start with first number, operations are done left to right ignoring order of operations
      equation = numbers.first

      #Convert to appropriate numbering system binary or ternary
      config = i.to_s(base).rjust(numbers.size - 1, '0')

      #loop through each digit in the binary/ternary number. The pattern determines which operator to test 
      config.chars.each_with_index do |digit, index|
        
        next_number = numbers[index + 1]
        #the operators to test depend on the given base
        operation = case base
          when 2
            digit == '0' ? '+' : '*'
          when 3
            case digit
              when '0' then '+'
              when '1' then '*'
              #special concat operator
              when '2' then '| |'
            end
        end


          #Perform the operation left-to-right
          equation = case operation
            when '+' then equation + next_number
            when '*' then equation * next_number
            when '| |' then (equation.to_s + next_number.to_s).to_i
          end
      end

      if equation == target
        sums << target
        #once a valid configuration is found, do not continue testing
        break
      end
    end
  
  end
  
  #return all the valid numbers added together
  sums.sum

end

def solvePartOne(input_data)
  total = solveEquations(input_data, 2)
  puts "Answer for part one: #{total}\n"
end

def solvePartTwo(input_data)
  total = solveEquations(input_data, 3)
  puts "Answer for part two: #{total}\n"
end

file = File.open"puzzle.txt"
input_data = getPuzzleInput(file)
solvePartOne(input_data)
solvePartTwo(input_data)
file.close