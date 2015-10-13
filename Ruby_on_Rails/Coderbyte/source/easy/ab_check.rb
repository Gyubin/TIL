def ABCheck(str)
    array_a_index = []
    array_b_index = []
    index = 0

    str.each_char do |c|
        if c == 'a'
            array_a_index.push(index)
        elsif c == 'b'
            array_b_index.push(index)
        end
        index += 1
    end

    array_a_index.each do |num_a|
        array_b_index.each do |num_b|
            if (num_a - num_b).abs == 4
                return 'true'
            end
        end
    end
    return 'false'
end
