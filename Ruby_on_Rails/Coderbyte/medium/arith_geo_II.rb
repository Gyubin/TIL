def ArithGeoII(arr)
    arith_cnt = 0
    geo_cnt = 0
    arith_dif = arr[1] - arr[0]
    geo_multi = arr[1] / arr[0].to_f

    (1...arr.length - 1).to_a.each do |e|
        if arith_dif == (arr[e+1] - arr[e])
            arith_cnt += 1
        elsif geo_multi == arr[e+1]/arr[e].to_f
            geo_cnt += 1
        end
    end

    if arith_cnt == arr.length - 2
        return 'Arithmetic'
    elsif geo_cnt == arr.length - 2
        return 'Geometric'
    else
        return -1
    end
end
