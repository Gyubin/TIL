def ArrayAdditionI(arr)
    max_num = arr.max
    puts(max_num)
    arr.delete(max_num)
    puts(arr.length)

    (2..arr.length).to_a.each do |n|
        arr.combination(n).to_a.each do |array|
            sum = 0
            array.each do |num|
                sum += num
            end
            if sum == max_num
                return 'true'
            end
        end
    end
    return 'false'
end
