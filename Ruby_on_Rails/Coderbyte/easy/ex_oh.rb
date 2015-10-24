def ExOh(str)
    if str.scan(/x/).count == str.scan(/o/).count
        return 'true'
    else
        return 'false'
    end
end
