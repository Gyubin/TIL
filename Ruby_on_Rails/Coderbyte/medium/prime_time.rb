def PrimeTime(num)
    limit = Math.sqrt(num)

    (2...limit).to_a.each do |n|
        if num % n == 0
            return 'false'
        end
    end
    return 'true'
end
