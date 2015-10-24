def TimeConvert(num)
    hours = num / 60
    minutes = num - hours*60
    return hours.to_s + ':' + minutes.to_s
end
