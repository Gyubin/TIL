def LetterCapitalize(str)
    str_array = str.split
    result = ""
    str_array.each do |a|
        result = result + " " + a.capitalize
    end
    return result
end
