def SecondGreatLow(arr)
    if arr.length == 2
        return arr[1].to_s + ' ' + arr[0].to_s
    end

    second_min = 0
    second_max = 0
    arr = arr.sort

    (0...arr.length-1).to_a.each do |e|
        if arr[e]<arr[e+1]
            second_min = arr[e+1]
            break
        end
    end

    (0...arr.length-1).to_a.each do |e|
        if arr[(e+1)*-1] > arr[(e+2)*-1]
            second_max = arr[(e+2)*-1]
            break
        end
    end

    return second_min.to_s + ' ' + second_max.to_s
end
