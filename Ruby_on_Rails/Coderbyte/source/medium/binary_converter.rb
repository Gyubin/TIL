def BinaryConverter(str)
    binary_array = str.split(//)
    len = binary_array.length
    i = 0
    sum = 0

    binary_array.each do |num|
        sum += num.to_i * (2**(len-1-i))
        i += 1
    end

    return sum.to_s
end
