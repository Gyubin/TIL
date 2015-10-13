previous_number = 1
present_number = 2
temp = 0
sum = 0

while present_number <= 4000000
    if present_number % 2 == 0
        sum += present_number
    end
    temp = previous_number + present_number
    previous_number = present_number
    present_number = temp
end

puts sum
