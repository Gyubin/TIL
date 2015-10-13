#not completed yet
def prime(number)
    i = 1
    while number != 1
        i += 1
        number /= i until number % i != 0
    end
    p i
end

prime(600851475143)
