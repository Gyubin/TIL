def LongestWord(sen)
    i = 0
    sen.each_byte do |c|
        if !(c >= 65 && c <= 90) && !(c >= 97 && c <= 122)
            sen[i] = ' '
        end
        i += 1
    end

    split_array = sen.split(' ')
    longest_word = ""
    temp_count = 0

    split_array.each do |a|
        if a.length > longest_word.length
            longest_word = a
        end
    end
    return longest_word
end
