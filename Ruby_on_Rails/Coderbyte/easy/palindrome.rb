def Palindrome(str)
    str = str.downcase.split(' ').join
    if str == str.reverse
        return 'true'
    else
        return 'false'
    end
end
