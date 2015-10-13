def LetterChanges(str)
    i = 0
    str.each_byte do |c|
        if (c >= 65 && c <= 89)
            str[i] = (c+1).chr
        elsif c == 90
            str[i] = 65.chr
        end

        if (c >= 97 && c <= 121)
            str[i] = (c+1).chr
            if c+1 == 97 || c+1 == 101 || c+1 == 105 || c+1 == 111 || c+1 == 117
                str[i] = (c-31).chr
            end
        elsif c == 122
            str[i] = 65.chr
        end

        i += 1
    end
    return str
end
