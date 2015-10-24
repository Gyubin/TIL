#Prime mover
파라미터로 숫자를 넣으면 그 순서의 소수(prime number)를 리턴하는 함수를 짜는 것.

```ruby
def PrimeMover(num)
    return 2 if num == 1
    cnt = 1
    prime_num = 1
    while cnt < num
        prime_num += 2
        is_prime = true
        (3..Math.sqrt(prime_num)).step(2) do |i|
            if prime_num % i == 0
                is_prime = false
                break
            end
        end
        cnt += 1 if is_prime
    end
    prime_num
end
```
생각했던 흐름과 똑같은 다른 사람 코드가 있어서 참고해서 약간 수정했다. 기본적으로 1/2 승수 수까지만 반복문 돌리는 것은 똑같았지만 2씩 점프해서 반복하는 것은 처음 봐서 추가했다. iterator에 .step(num) 하고 block에 코드를 넣으면 되는 것 같다.
