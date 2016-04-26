# Ruby 문법 정리

참고 링크: [Codecademy](https://www.codecademy.com/learn/ruby)

## 1. 기본

- `puts`, `print`: 둘 다 괄호 쓸 필요 없고, puts만 자동 개행된다.
- 여러줄 주석: `=begin` , `=end` 사이에 두면 된다.
- 지역변수: 시작은 무조건 소문자, 단어와 단어를 구분하는 것을 언더스코어 _. $로 시작해도 문법 상 문제는 없지만 코드 컨벤션을 지키자.
- 입력 받기: `variable = gets.chomp` 여기서 `gets` 는 루비에서 사용자 입력 받는 메소드. 입력을 받을 때 루비는 자동으로 한 줄을 띄운다. `chomp`는 이걸 방지함.
- `메소드!`: 메소드 마지막에 !를 붙이면 그 값 자체가 바뀐다. `answer.capitalize!` 라고 하면 원래 capitalize 메소드는 바꿔서 리턴할 뿐 answer 자체를 바꾸지 않는데 !를 붙이면 바꿔버림.
- `Rubyist`: Ruby Enthusiast를 의미하는 용어.
- `unless`: if랑 똑같이 쓴다. ~ 하지 않다면.
- `메소드?` : 메소드가 ?로 끝난다면 얘는 true, false를 리턴하는 형태다. 주로 이런 형태를 ?로 끝나도록 메소드명을 만든다. `.include?` 같은.
- `until`: while의 반대.
- `...`과 `..` : 1…10 마지막 수 미포함, 1..10 마지막 수 포함.
- 반복 구문 `loop` :  `loop do ... end` 안의 구문에서 `break` 하면 빠져나간다. `break if ...` 가 일반적
- `do end`와 `{ }`는 같은 의미:  `.each do |x| end` 혹은 `.each {|x| code something}`로 쓰면 된다. 일반 method와 block의 다른 점은 일회성이냐 아니냐.
- `.times {}` : 숫자에다가 뒤에 `.times { }` 의 형태로 반복할 수 있다. 단순 반복. 이건 0부터 숫자 몇까지의 for 루프랑 똑같다. 저기서 변수 받으면 0 1 2 3  이렇게 나옴. 즉 `3.times{|a| puts a}` 이거 돌리면 0 1 2 이렇게 뜸.
- method 선언할 때 `def method_name ... end`
- `symbol`: 루비에서 콜론 뒤에 뭔가를 쓰면 얘는 심볼이다. `:something` 이런 형태로. 심볼은 문자열이랑은 다르다.
    - 심볼은 단 하나만 존재한다. .object_id 메소드를 써보면 문자열을 같은 내용이라도 아이디 값이 계속 달라지는데 심볼은 단 하나만 존재한다.
    - : 콜론 뒤에 마치 변수처럼 이름이 들어가야된다. 첫 글자는 무조건 언더바나 알파벳이어야 함.
    - 심볼을 변수에 할당할 수도 있다.
    - they're primarily used either as hash keys or for referencing method names.: 해쉬의 키나, 메소드 네임의 레퍼런스로 주로 활용된다. 좋은 해쉬 키가 될 수 있는 세가지 이유는 다음과 같다. 1.한 번 심볼이 생성되면 얘는 바꿀 수가 없다. 변하지 않음. 2.오직 하나만 존재한다. 그래서 메모리 절약 3.해쉬에서 값을 뽑았을 때 1과 2의 이유 때문에 검색이 훨씬 빨라진다. 일반 문자열로 했을 때보다.
- 심볼과 스트링의 전환은 쉽다. `.to_s`, `.to_sym` 메소드를 각각 쓰면 된다. 심볼화할 때 `.intern` 써도됨. internalize 한다는 의미라고 함.
- 콤마 마지막에 찍어도 오케이. 루비에서는 해쉬나 리스트를 생성할 때 마지막 원소 뒤에 콤마(,) 찍어도 에러 안난다.


## 2. 자료형 `Hash`

- `Hash`
    + 기본 생성할 때는 `Hash.new`
    + Hash에서 each를 쓰려면 2개의 placeholder가 필요하다. `hash_variable.each {|a, b| puts a, b}` 하지만 만약에 변수를 2개를 안 받고 1개만 받아서 그걸 출력해보면 `[:key_a, "aaa"] [:key_b, "bbb"] [:key_c, "ccc"]` 이런식으로 나온다. 즉 키 밸류 쌍이 들어있는 2개 원소의 리스트가 변수로 받아진다는 의미. 그래서 `test.each {|a| print a[0]}` 하면 각 쌍의 키만 출력된다.
    + `Hash.new(“DEFAULT”)` 이런식으로 해시를 만들고 괄호 안에 뭔가를 넣으면. 디폴트 값이 된다. 없는 키로 접근하면 얘가 나옴.
- `=>`: hash rocket 이라고 말한다.
- Hash 키 심볼 생성
    - : 를 만들 때 루비 1.9부터 변경됨. 콜론을 뒤에다 찍으면 알아서 심볼이되면서 해시 로켓을 안써도 됨.
    - 여기서 무조건 키 뒤에 : 붙여 써야함. `hash_test = {aaa: “aaa”, bbb: “bbb”}` 이렇게 키랑 붙여써야함. 띄우면 에러.
- 성능 테스트할 때 다음처럼 하면 된다. 벤치마크 써서. Hash 다량 만들 때 참고하면 좋은 코드도 있음.

    ```ruby
    require 'benchmark'
    string_AZ = Hash[("a".."z").to_a.zip((1..26).to_a)]
    symbol_AZ = Hash[(:a..:z).to_a.zip((1..26).to_a)]
    string_time = Benchmark.realtime do
      100_000.times { string_AZ["r"] }
    end
    symbol_time = Benchmark.realtime do
      100_000.times { symbol_AZ[:r] }
    end
    puts "String time: #{string_time} seconds."
    puts "Symbol time: #{symbol_time} seconds."
    ```

- Hash에서 검색할 때 .select 쓰면 된다. 블락에서 sort 기준 수정하는 거랑 비슷. Hash에서 호출하면 리턴값이 Hash, 리스트에서 호출했으면 리턴값 리스트다.

    ```ruby
    grades = { alice: 100, bob: 92, chris: 95, dave: 97 }
    grades.select {|name, grade| grade < 97}
    # ==> {:bob=>92, :chris=>95}

    grades.select { |k, v| k == :alice }
    # ==> {:alice=>100}
    good_movies = movie_ratings.select { |k, v| v > 3 }
    ```

- Hash에서 `.each_key` `.each_value` 이런식으로 호출할 수도 있다. 이게 좋네.
- case 문이 있다. case when when when else end 형태.

    ```ruby
    case language
    when "JS"
      puts "Websites!"
    when "Python"
      puts "Science!"
    when "Ruby"
      puts "Web apps!"
    else
      puts "I don't know!"
    end
    ```

- 근데 여기서 실행 부분을 then을 써서 한 줄로 표현할 수 있다.

    ```ruby
    case language
      when "JS" then puts "Websites!"
      when "Python" then puts "Science!"
      when "Ruby" then puts "Web apps!"
      else puts "I don't know!"
    end
    ```

- Hash에서 키와 값을 지우려면 hash_name.delete(key)
- 메소드의 매개변수에 `def something(aaa, bbb=123) ... end` 와 같이 적으면 123은 디폴트값을 의미한다.
- 큰 숫자를 쉽게 알아보기 위해서 언더바를 쓸 수 있다. 숫자 사이에 _는 연달아 쓰면 안되고 하나만 써야하며, 어디에 집어넣든 상관없다. 무시된다. 맨 뒤에 맨 앞에만 안 붙이면 된다.

## 3. 함수 사용 예

- 루비에서 쉽게 Bag of Words 만들기

    ```ruby
    puts "? "
    text = gets.chomp
    words = text.split
    frequencies = Hash.new(0)
    words.each { |word| frequencies[word] += 1 }
    ```

- `.sort_by` 는 정렬하는 메소드고 each랑 똑같은 형태로 쓰인다. 그리고 리턴 형태는 hash를 sort_by했으면 2차원 배열로 리턴한다.
    + color, count 두 개를 넣은거는 colors가 Hash이기 때문이고, 내용에 count를 넣은것은 count를 기준으로 정렬하라는 의미. sort_by의 리턴은 array of array. 즉 키 밸류 쌍을 어레이로 담고 그 쌍들을 다시 어레이에 담아서 리턴한다.
    + 또한 2차원 배열도 each를 쓸 때 여러 개 변수로 받을 수 있다. 2개 원소 어레이들이 여럿 담긴 어레이라면 변수 2개로 받을 수 있음. 근데 만약 변수 5개로 받았는데 한 어레이에서 원소가 2개밖에 없었다. 그럼 4, 5번째 변수엔 아무것도 안들어간다. 즉 nil이다. 그럼 만약에 2개 변수를 할당했는데 한 어레이에서 원소가 5개다. 그러면 그 어레이에서 나머지 3개 원소는 사용할 수 없다. 사용 안됨. 그냥 넘어감.

    ```ruby
    colors = {"blue" => 3, "green" => 1, "red" => 2}
    colors = colors.sort_by {|color, count| count}
    ```

- arguments 매개변수에 여러개 들어올지 모를 때 splat arguments를 사용. 앞에 * 붙여주면 된다. 무조건 뒤에 위치해야.

    ```ruby
    def what_up(greeting, *bros)
      bros.each { |bro| puts "#{greeting}, #{bro}!" }
    end
    ```

- The Combined Comparison Operator `<=>` : 같은 object라면 비교해서 왼쪽이 크면 1, 같으면 0, 작으면 -1 리턴. 다른 object라면 nil 리턴. 리스트끼리 비교하면 첫 번째 원소만 비교.
- 루비의 sort 메소드에서 정렬의 조건을 블락을 활용해서 설정할 수 있다. 아래 코드가 default다. 정 순으로 정렬하라는 것. 여기서 first와 second 조건을 바꾸면 역순이 된다.
    + 즉 sort 메소드에서 1.블락을 활용하고,
    + 2.블락에서 변수를 2개 지정해서 활용하고,
    + 3. 음의 정수, 0, 양의 정수 중 하나를 리턴하면 된다.
    + 음의 정수는 first, second의 기존 순서가 올바르다는 의미, 0은 그대로 내비둬 똑같으니까, 양의 정수는 first를 뒤로 보내란 의미. 리턴하는 값만 지켜주면 어떤 복잡한 코드라도 오케이. 정렬 순서를 내 마음대로 바꿀 수 있다.

    ```ruby
    list.sort { |first, second| first <=> second }
    ```

- 리스트 `.push`, `<<`, `+`
    + 리스트에 마지막에 원소 추가할 때 파이썬과 다르게 append 없다. `push` 써야함.
    + 재밌는건 이것도 된다. `[1, 2, 3, 4] << 5` 이렇게 적으면 `[1, 2, 3, 4].push(5)` 와 같은 의미. 문자열에서도 동일하게 먹힌다.
    + `“hello “ << “gyubin”` 이렇게 하면 “hello gyubin”이 됨. 물론 문자열에서는 +도 된다.
- 한 줄 쓰기 `Do something if ...` `Do unless ...` 여기까진 되는거고, 다음처럼 반대로 적는건 안된다. `unless ... DO` `if ... Do`
- 3항 연산자. 참이면 왼쪽, 거짓이면 오른쪽을 리턴한다는 의미. 그래서 puts를 할거면 boolean 왼쪽에다가 넣어야 함. 중간에 넣으면 에러 터짐

    ```ruby
    boolean ? Do this if true: Do this if false
    ```

- `||=` 이 기호는 변수에 대입할 때 아무것도 변수에 대입이 안돼있을 때만 대입을 하는 것. 이미 값이 있다면 대입 안된다. 기존 것 유지. `aaa = nil` 이 상태에선 대입 오케이.
- impicit return: 메소드에서 리턴을 명확하게 정하지 않으면 자바스크립트에선 자동으로 undefined, 파이썬에선 None을 디폴트로 리턴한다. 근데 루비는 마지막 expression을 리턴함. 이게 implicit return. 하지만 명확하게 표현해주는게 더 좋을 것 같다. 내 생각.
- `.upto()`, `.downto()`: 마지막 포함. `5.upto(10){|a| puts a}` 알파벳도 마찬가지 적용 가능
- `.respond_to?(심볼)` 이 메소드는 앞에 오는 객체가 매개변수로 오는 심볼과 같은 이름의 메소드에 반응하는지 알아보는 메소드다. 즉 `[1, 2, 3].respond_to?(:push)` 를 하면 true가 리턴된다. 배열에 `push`는 먹히는 메소드니까. 존재하니까. 하지만 `to_sym`은 안된다. 배열은 심볼화 안됨.
- 단순 for 루프: `for num in (1..10) ... end`
- `$VERBOSE = nil` : 이 코드의 의미는 루비 1.8 버전의 것을 쓰겠다라는 의미. 첫줄에. `prime = Prime.new` 같은. 요즘엔 `prime = Prime.instance` 이렇게 쓴다. 루비 코드카데미 코드 보면 이렇게 코드를 다르게 썼을 때 달라지는 점. 배열이 자동 빌트인이다.

    ```ruby
    $VERBOSE = nil    # We'll explain this at the end of the lesson.
    require 'prime'   # This is a module. We'll cover these soon!
    def first_n_primes(n)
      return "n must be an integer." unless n.is_a? Integer
      return "n must be greater than 0." if n <= 0

      prime_array ||= []
      prime = Prime.new
      n.times { prime_array << prime.next }
      prime_array
    end
    first_n_primes(10)
    # --------------------------------------------------
    require 'prime'
    def first_n_primes(n)
      "n must be an integer" unless n.is_a? Integer
      "n must be greater than 0" if n <= 0

      # The Ruby 1.9 Prime class makes the array automatically!
      prime = Prime.instance
      prime.first n
    end
    first_n_primes(10)
    ```

- select와 collect 차이점
    + `select{}` 는 배열이나 리스트에 호출했을 때 조건에 맞는 놈을 각 객체 타입과 동일하게 골라서 리턴해준다
    + 근데 `.collect{}`는 무조건 리스트 리턴이고, { } 안에 들어가는 조건식의 ‘리턴 값’을 리스트에 넣어서 리턴해준다는게 다르다.
- `collect { }` `.map { }`: 배열이나 해쉬에 이 메소드를 적용하면 배열을 리턴한다.
    + `[1, 2, 3].collect {|num| num*2 }` 이렇게 하면 [2, 4, 6] 배열을 리턴한다. 즉 블록 안에 들어간게 각 원소 위치에서 그 값이 된다는 것. 1 원소 차례에선 1*2가 원소가 되는 것이다. 배열을 직접 바꾸는게 아니라 변형된 배열을 새로 만들어서 리턴. 바로 바꾸고 싶으면 collect! 하면 된다.
    + hash도 역시 비슷하다. 기본적으로 hash에서  iterate 하려면 변수를 k,v 2개 받아야 한다. 그래서 각 원소별로 반복할 때 역시 k, v를 받아서 작업해주면 된다. 그리고 한 줄짜리 if 문. Do if ~~ 이런식으로 작업하면 조건도 걸 수 있다. 만약 그냥 `k==:aaa` 이런식으로 넣으면 리턴되는 배열은 `[true, false, false]` 이런식으로 됨.
    + 그럼 만약에 변수를 하나만 받았다면? 여기서 기억하면 좋을 것이 `|a, b, c|`  이런식으로 변수를 넣어서 받는다는게 `[a, b, c]`라는 의미다.
    + Hash를 iterate 할 때 |a| 한개로 받으면 재밌게도 키, 밸류 쌍으로 2개 원소인 리스트가 받아진다. 즉 다시 말하면 Hash에서 iterate 하면 한 번에 내뱉는 원소 타입이 [key, value]의 2개 원소 리스트인거다. 즉 하나로 받으면 저렇게 2개 원소 리스트가 툭 튀어나오고, 2개로 받으면 [a, b] 이렇게 받으니까 정확하게 저 원소개수랑 맞아떨어진다. 그래서 속의 원소를 가리키는 a, b가 매칭되서 a는 키, b는 밸류로 받아올 수 있는 것. 그럼 만약에 3개 이상으로 받아버리면 어떻게 될까. 간단하다. 애초에 한 번에 2개값만 해시에서 받아올 수 있다. 그래서 만약 `|a, b, c, d, e|`라면 `[a, b, c, d, e]`이고 여기서 a, b에만 값이 대입되고(키, 밸류 순서대로) 나머지 c, d, e에는 아무 것도 대입되지 않고 끝난다. 즉 nil값이 들어간다.
- `yield` : 메소드 안에 yield 써놓고 이 메소드 호출할 때 { } 안에 작업하면 요 작업이 중간에 호출된다. 만약에 { }을 적어주지 않으면 에러 난다. 블록이 없다고. 그리고 sort에서 리턴값 조정으로 정렬 방식 조정할 때는 블락 안의 리턴값이 메소드 안의 yield의 리턴값이다. new_a = yield a 이런식으로 하면 된다.

    ```ruby
    def block_test
      puts "We're in the method!"
      puts "Yielding to the block..."
      yield
      puts "We're back in the method!"
    end
    block_test { puts ">>> We're in the block!" }
    # ---------------------------------
    # 또한 yield할 때 값을 전달할 수도 있다.
    def yield_name(name)
      puts "In the method! Let's yield."
      yield("Kim")
      puts "In between the yields!"
      yield(name)
      puts "Block complete! Back in the method."
    end
    yield_name("Eric") { |n| puts "My name is #{n}." }
    ```

- 객체 타입 확인하기: :hello.is_a? Symbol 이렇게 쓰면 :hello가 심볼이기 때문에 true를 리턴한다.
- 알파벳 순서 적용하기: 아래처럼 < “M” 라고 하는 것만으로도 M 알파벳 이전 알파벳으로 시작하는 단어들을 골라낼 수 있다.

    ```ruby
    crew = {
      captain: "Picard",
      first_officer: "Riker",
      lt_cdr: "Data",
      lt: "Worf",
      ensign: "Ro",
      counselor: "Troi",
      chief_engineer: "LaForge",
      doctor: "Crusher"
    }
    first_half = lambda {|key, value| value < "M"}
    a_to_m = crew.select(&first_half)
    ```

## 4. Proc, lambda

### 4.1 Proc

- `Proc` : proc은 한 마디로 코드의 군집이다. 얘네는 객체는 아니다. 루비에서 모든 것은 객체다! 할 때 몇 안되는 반례.
    - `proc_name = Proc.new { }` 하면 된다. 그리고 사용할 때는 `select(&proc_name)` 하면 됨.
    - 그리고 일반 메소드에서처럼 `select`와 `(&proc_name)` 를 띄워쓰면 에러난다. `select(&proc_name)` 이렇게 붙여써야함.
    - 만약 메소드가 인자를 받는 형태라면. `select(인자, &proc_name)` 하면 된다. 괄호 안에 다 써주면 됨. 다만 마지막에 써줘야한다.
    - `proc_name.call` 하면 블락 안의 내용이 실행된다.

    ```ruby
    multiples_of_3 = Proc.new do |n|
      n % 3 == 0
    end
    (1..100).to_a.select(&multiples_of_3)
    ```

- Proc, Symbol :  method는 symbol형태로 호출될 수 있다. 이어서 symbol은 &을 통해서 proc처럼 활용할 수 있다. 즉 다음 코드.
    + 결과는 [1, 2, 3] 이렇게 나온다. 하지만 기억할 것은 저렇게 메소드를 심볼 형태로 블락 대신 호출한다면 메소드의 호출 대상은 위 strings 배열의 원소들이다. 즉 “1”.to_i 가 된다는 것. 만약 내가 어떤 메소드를 새로 만들어서 저런식으로 대입한다고 하면 문자열 객체가 호출할 수 있도록 만들어야 한다. 아직 루비에서는 어떻게 하는지 모르겠고 자바스크립트에선 String.prototype.something 이런식으로 문자열 프로토타입에다가 메소드를 만들면 된다. 루비도 비슷하지 않을까.

    ```ruby
    strings = ["1", "2", "3"]
    nums = strings.map(&:to_i)
    ```

### 4.2 lambda

- `lambda` : 아래 코드가 신택스다. `lambda_example = lambda { |param| puts param}` 이런식으로 람다 만들어서 쓰면 됨. 더 아래 코드에서 볼 수 있듯이 yield가 아니라 call을 써주면 된다. 이렇게 변수 형태로 쓸거면 Proc에서처럼 & 써야 함.

    ```ruby
    lambda { |param| block }
    def lambda_demo(a_lambda)
      puts "I'm the method!"
      a_lambda.call
    end
    lambda_demo(lambda { puts "I'm the lambda!" })
    ```

즉 이 활용 방식은 ‘메소드 내부에서 람다 활용 방법’이다. 위에서까지는 기존 만들어져있던 라이브러리의 메소드를 활용할 때 메소드 호출 뒤에 {} 를 붙여서 Proc이나 람다를 활용했다. 하지만 이거는 내가 어떤 메소드를 작성할 때 거기서 람다를 활용하는 방식이다. 즉 이전까지는 yield를 써서 내 메소드에서 블락을 호출했지만 람다는 lambda.call을 써야한다는 것.

### 4.3 lambda, proc의 차이점

- 첫째. 람다는 들어오는 arguments의 개수를 체크한다. 프록은 안그런다. 즉 람다는 잘못된 argument 개수가 들어오면 에러를 발생시킨다는 것. 프록은 신경 안쓰고 nil을 대입한다.
    + First, a lambda checks the number of arguments passed to it, while a proc does not. This means that a lambda will throw an error if you pass it the wrong number of arguments, whereas a proc will ignore unexpected arguments and assign nil to any that are missing.
- 둘째. 람다의 리턴은 함수로의 리턴이고, 프록의 리턴은 함수 전체 범위에서 리턴이다. 아래 예제에 나와있다.
    + Second, when a lambda returns, it passes control back to the calling method; when a proc returns, it does so immediately, without going back to the calling method.

```ruby
def batman_ironman_proc
  victor = Proc.new { return "Batman will win!" }
  victor.call
  "Iron Man will win!"
end
puts batman_ironman_proc    #Batman will win

def batman_ironman_lambda
  victor = lambda { return "Batman will win!" }
  victor.call
  "Iron Man will win!"
end
puts batman_ironman_lambda    #Iron Man will win!
```

## 5. Class

- Class:  클래스는 아래 신택스로 생성한다. 그리고 클래스 이름은 _를 쓰는게 아니라 CamelCase형태로 쓴다.
    + `NewClass.new(...)` 이렇게 생성할 때 안에 인자를 넣을 수 있도록 한 것이 `def initialize end` 이다.
    + 변수 앞에 `@`가 붙으면 이건 instance 변수라는 의미. 즉 이 클래스를 활용해 만든 인스턴스들 각각에 생성된대로 다르게 드러가는 속성이라는 의미다.

    ```ruby
    class Car
      def initialize(make, model)
        @make = make
        @model = model
      end
    end
    ```

- Scope
    - $ global variable: 전역변수. 정의해두면 어디든지 얘를 사용할 수 있음. 저렇게 $를 붙이거나, 클래스나 메소드 밖에서 그냥 변수 선언하거나 하면 전역변수다.
    - local variable: 지역변수.
    - @@ class variable: 클래스 변수. 인스턴스 생성 없이 클래스.클래스변수명 으로 활용 가능. Math의 Pi같은게 이런거라고나 할까.
    - @ instance variable: 인스턴스 변수. 인스턴스 각각에 따로따로 만들어지고 정의되는 변수들.
- Scope 추가
    - $a 와 a는 다르다. 한 번 $를 써주면 끝까지 써줘야.
    - 전역변수를 많이 사용하는 것은 좋지 않다.
    - 클래스 변수는 단 하나만 존재한다. 그래서 이걸 인스턴스의 개수를 저장하는 용도로 사용하는 경우도 있다.
- 상속. inherit. 클래스 선언 옆에 새로만들클래스 < 상속할부모클래스 요렇게 적어주면 됨.

    ```ruby
    class DerivedClass < BaseClass
      # Some stuff!
    end
    ```

- super: super class의 속성들을 상속받을 수 있다. 만약 부모 클래스에서 hi라는 메소드가 있고 자식 클래스가 이를 오버라이드한다고 치자. 그런데 가볍게 몇 개만 추가할 예정이고 기존 hi 메소드의 속성들은 그대로 사용해야할 상황이라면 자식 클래스의 hi 메소드 안에 super 라고 한 줄 적어주기만 하면 된다.
- end 한 줄에 쓰기: ex) `class Dragon < Creature; end`
- 다른 언어와 다르게 루비는 여러 부모 클래스를 가질 수 없다. 그럼 어떻게 해야하나. 이런 상황에선?
- 인스턴스 변수가 있는 클래스를 상속할 때 initialize 메소드 오버라이드하기.
    - super는 정말 단순히 그 메소드 내의 구문 자체만 가져온다. 아래 코드의 Email 클래스에서처럼 initialize의 매개변수는 이름이 뭐여도 상관없다. 그리고 super에서 따로 `super(hihihi, hellohello)`와 같이 매개변수 안넣어줘도 된다. 매개변수의 순서를 기억하는 것 같다. 그러면 Message 클래스의 인스턴스 변수와 똑같은 이름을 가진 `@from`, `@to`에다가 인자로 들어온 값을 할당한다.
    - super가 다 해주진 않는다. 단순히 그 메소드 내의 구문만 가져오는 것이므로 오버라이드 하려면 initialize 메소드에 꼭 매개변수를 숫자에 맞게 넣어줘야 한다. 만약 initialize 메소드에 인자를 적게 넣고 super를 쓴다면. 객체 생성할 때 인자에 1개 넣으면 2개 넣으라고 에러 나고, 2개 넣으면 1개 넣으라고 에러난다.
    - 오버라이드 해서 더 적은 인스턴스 변수를 사용하고 싶으면 super를 안쓰면 되고, 기존꺼에서 더 추가해서 쓰고 싶으면 아래 코드처럼 subject를 추가하면 된다.

    ```ruby
    class Message
      @@messages_sent = 0
      def initialize(from, to)
        @from = from
        @to = to
        @@messages_sent += 1
      end
    end

    class Email < Message
      def initialize(hihihi, hellohello, subject)
        super
        @subject = subject
      end
    end
    ```

- 클래스 메소드

```ruby
class Machine
  def Machine.hello
    puts "Hello from the machine!"
  end
end
```

- public, private
    - default로 public이다. class 시작과 end 사이에서 public, private를 적어주면 거기부터 class의 end까지는 적어준게 적용된다.
    - private은 객체 내에서만 사용할 수 있는 코드다. 클래스 외부에서 사용될 수 없다. 다르게 말하면 명시적 리시버(explicit receiver)를 쓸 수 없다는 의미. 여기서 리시버란 object.method 형태에서 object가 method의 리시버이다. 그래서 이런 private 정보에 접근하려면 이 private에 접근하는 다른 public 메소드가 있어야 한다.
    - 인스턴스 변수와 같은 이름으로 메소드를 만들어서 인스턴스 변수를 리턴하거나 수정할 수 있다.
    - attr_reader, attr_writer, attr_accessor를 사용해도 된다.

    ```ruby
    class ClassName
      public
      def public_method; end
      private
      def private_method; end
    end
    ```

- reader, writer, accessor: 최고의 설명. http://stackoverflow.com/questions/4370960/what-is-attr-accessor-in-ruby

    ```ruby
    class Person
      attr_reader :name
      attr_writer :name
      def initialize(name)
        @name = name
      end
    end
    # 위의 attr~~ 두 줄이 아래 두 메소드와 같다.
    def name
      @name
    end
    def name=(value)
      @name = value
    end
    ```

## 6. Module

- module 기본
    - 라이브러리같은 것으로 이해하면 될 것 같다. 클래스랑 비슷한데 객체를 만들 수도 없고 클래스도 아니고 상속도 안된다. 단지 코드를 저장해놓은 곳.
    - 다른 것들과 마찬가지로 `module NAME ... end` 형태로 구성된다. 클래스와 마찬가지로 모듈 이름은 CamelCase 형태로.
    - 상수 개념. 모듈에 상수가 들어가면 편리하다. 파이(3.14…)같은 숫자. 루비 자체에서 더이상 값을 변하지 않게 하는 기능을 제공하진 않지만 다음처럼 변수명을 정하면 값이 변할 때 경고를 해줄 수 있다. 모두 대문자 + 단어 구분은 언더바( _ )
- module namespacing
    - 모듈의 가장 큰 목적은 메소드와 변수를 named space에 맞게 각각 분리하기 위함이다. 이걸 namespacing 이라고 일컫는다. `Math::PI` 와 `Circle::PI` 를 구분 가능.
    - 현재 만약 내가 Circle 이라는 모듈을 만들어서 안에 PI 상수를 만들었다고 치자. 이 상황에서라면 Math와 Circle 두 모듈 모두가 포함 된 상황이다. 여기서 포함되어있다고 PI 라고만 입력하면 값이 출력되지 않는다. 메소드 역시 마찬가지. 여기서 유추해보면 모듈에서 내부 attributes를 사용하려면 namespacing이 꼭 필요하다는 의미가 된다. 또한 추가로 모듈에서 네임스페이싱을 활용해서(`Math::something`) 내부 속성들을 사용하려면 변수는 꼭 ‘상수’여야 하고 메소드는 꼭 앞에 `ModuleName.method` 이렇게 모듈명을 붙여줘야한다. 그래야 쓸 수 있다. 이런 `::` 기호를 scope resolution operator라고 한다.
- require, include, extend
    - Math와 다르게 디폴트로 포함되지 않은 모듈은 require를 통해 불러와야 한다. `require ‘module name’` 이다. Date는 이렇게 불러와야 쓸 수 있다. require 하지 않은 상황에서 `Date.method` 하면 에러난다.
    - `include`는 class 내에서 호출할 수 있다. 이건 아예 삽입한다고 생각하면 된다. include를 한 이후에는 `Math::PI` 로 안쓰고 그냥 PI라고 써도 Math의 PI로 인식한다. 또한 모듈명을 앞에 쓰지 않고 그냥 일반적으로 정의한 메소드가 자연스럽게 인스턴스 메소드가 된다.
    - `extend` 역시 class 내에서 호출한다. 여기선 include와 다르게 모듈 명 없이 선언한 메소드가 인스턴스 메소드가 아니라 클래스 메소드가 된다. 클래스에서만 호출 가능.
- module 의문
    - `require ‘Date’`를 했을 때 `Date.today` 이런식으로 쓸 수가 있다. `Date::today` 와 같은 형식이 아니라. 이건 무슨 원리로 가능한걸까. [스택오버플로우 질문](http://stackoverflow.com/questions/5417209/ruby-module-method-access)을 보면 나온다. 이 때는 아마 today가 메소드일 것이며 선언될 때 `def self.today` 와 같을 것이다. 이러면 `모듈명.메소드` 이런식으로 호출 가능하다.
    - 안에 변수, 메소드 들어갈 수 있다. 그러면 gem은 module이랑 뭐가 다른걸까.
    - include가 instance 레벨에서 모듈 내용을 클래스에 추가한다고 하는데. 그러면 모듈에서 굳이 @인스턴스 형태로 쓸 필요가 있는가?
- `mixin` : 모듈을 이용해서 클래스에 다른 속성을 추가하는 것을 일컫는다.
    - 모듈에다가 인스턴스 변수를 넣어서 include 시키면 그 클래스의 인스턴스 변수가 된다.
    - 그럼 그냥 변수는 뭐가 되는가. 클래스 변수는 뭐가 되는가. 전역변수는 전역이 되겠다만. 다른 메소드는 어찌되나.
