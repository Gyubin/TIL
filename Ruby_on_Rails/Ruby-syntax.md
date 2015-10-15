###Ruby 문법 중 다른 언어와는 조금 달라 신기했고 기억해야 할 부분을 모아뒀다.
=========================

####기본 of 기본
- puts, print: 둘 다 괄호 쓸 필요 없고, puts만 자동 개행된다.
- 여러줄 주석: =begin , =end 사이에 두면 된다.
- 지역변수: 시작은 무조건 소문자, 단어와 단어를 구분하는 것을 언더스코어 _. $로 시작해도 문법 상 문제는 없지만 코드 컨벤션을 지키자.
- 입력 받기: variable = gets.chomp 여기서 gets 는 루비에서 사용자 입력 받는 메소드. 입력을 받을 때 루비는 자동으로 한 줄을 띄운다. chomp는 이걸 방지함.
- 메소드!: 메소드 마지막에 !를 붙이면 그 값 자체가 바뀐다. answer.capitalize! 라고 하면 원래 capitalize 메소드는 바꿔서 리턴할 뿐 answer 자체를 바꾸지 않는데 !를 붙이면 바꿔버림.
- Rubyist: Ruby Enthusiast
- unless는 if랑 똑같이 쓴다. ~ 하지 않다면.
- 메소드? : 메소드가 ?로 끝난다면 얘는 true, false를 리턴한다. .include? 같은.
- until은 while의 반대.
- ...과 .. : 1…10 미포함, 1..10 포함.
- 반복 구문 loop :  loop do ~~~~ end 안의 구문에서 break 하면 빠져나간다. break if ~~ 가 일반적
- do end = { } :  .each do |x| end 혹은 .each {|x| do something}
일반 method와 block의 다른 점은 일회성이냐 아니냐.
- .times {} : 숫자에다가 뒤에 .times { } 의 형태로 반복할 수 있다. 단순 반복. 이건 0부터 숫자 몇까지의 for 루프랑 똑같다. 저기서 변수 받으면 0 1 2 3  이렇게 나옴. 즉 3.times{|a| puts a} 이거 돌리면 0 1 2 이렇게 뜸.

####업그레이드 기본 난이도
- Hash
    - 기본 생성할 때는 Hash.new
    - Hash에서 each를 쓰려면 2개의 placeholder가 필요하다. hash_variable.each {|a, b| puts a, b} 하지만 만약에 변수를 2개를 안 받고 1개만 받아서 그걸 출력해보면 [:key_a, "aaa"] [:key_b, "bbb"] [:key_c, "ccc"] 이런식으로 나온다. 즉 키 밸류 쌍이 들어있는 2개 원소의 리스트가 변수로 받아진다는 의미. 그래서 test.each {|a| print a[0]} 하면 각 쌍의 키만 출력된다.
    - Hash.new(“DEFAULT”) 이런식으로 해시를 만들고 괄호 안에 뭔가를 넣으면. 디폴트 값이 된다. 없는 키로 접근하면 얘가 나옴.
- 루비에서 쉽게 Bag of Words 만들기
```ruby
puts "? "
text = gets.chomp
words = text.split
frequencies = Hash.new(0)
words.each { |word| frequencies[word] += 1 }
```
- .sort_by 는 정렬하는 메소드고 each랑 똑같은 형태로 쓰인다. 그리고 리턴 형태는 hash를 sort_by했으면 2차원 배열로 리턴한다.
```ruby
colors = {"blue" => 3, "green" => 1, "red" => 2}
colors = colors.sort_by {|color, count| count}
```
    - color, count 두 개를 넣은거는 colors가 Hash이기 때문이고, 내용에 count를 넣은것은 count를 기준으로 정렬하라는 의미. sort_by의 리턴은 array of array. 즉 키 밸류 쌍을 어레이로 담고 그 쌍들을 다시 어레이에 담아서 리턴한다.
    - 또한 2차원 배열도 each를 쓸 때 여러 개 변수로 받을 수 있다. 2개 원소 어레이들이 여럿 담긴 어레이라면 변수 2개로 받을 수 있음. 근데 만약 변수 5개로 받았는데 한 어레이에서 원소가 2개밖에 없었다. 그럼 4, 5번째 변수엔 아무것도 안들어간다. 즉 nil이다. 그럼 만약에 2개 변수를 할당했는데 한 어레이에서 원소가 5개다. 그러면 그 어레이에서 나머지 3개 원소는 사용할 수 없다. 사용 안됨. 그냥 넘어감.
- method 선언할 때 def method_name end
- arguments 매개변수에 여러개 들어올지 모를 때. splat arguments라고 한다. 앞에 * 붙여주면 된다. 무조건 뒤에 위치해야할듯.
```ruby
def what_up(greeting, *bros)
  bros.each { |bro| puts "#{greeting}, #{bro}!" }
end
```
- The Combined Comparison Operator <=> 같은 object라면 비교해서 왼쪽이 크면 1, 같으면 0, 작으면 -1 리턴. 다른 object라면 nil 리턴. 리스트끼리 비교하면 첫 번째 원소만 비교.
- 루비의 sort 메소드에서 정렬의 조건을 블락을 활용해서 설정할 수 있다. 다음과 같다.
```ruby
list.sort { |first, second| first <=> second }
```
이게 default 코드다. 정 순으로 정렬하라는 것. 여기서 first와 second 조건을 바꾸면 역순이 된다.
    - 즉 sort 메소드에서 1.블락을 활용하고,
    - 2.블락에서 변수를 2개 지정해서 활용하고,
    - 3. 음의 정수, 0, 양의 정수 중 하나를 리턴하면 된다.
    - 음의 정수는 first, second의 기존 순서가 올바르다는 의미, 0은 그대로 내비둬 똑같으니까, 양의 정수는 first를 뒤로 보내란 의미. 리턴하는 값만 지켜주면 어떤 복잡한 코드라도 오케이. 정렬 순서를 내 마음대로 바꿀 수 있다.
- symbol 루비에서 콜론 뒤에 뭔가를 쓰면 얘는 심볼이다. :something 이런 형태로. 심볼은 문자열이랑은 다르다.
    - 심볼은 단 하나만 존재한다. .object_id 메소드를 써보면 문자열을 같은 내용이라도 아이디 값이 계속 달라지는데 심볼은 단 하나만 존재한다.
    - : 콜론 뒤에 마치 변수처럼 이름이 들어가야된다. 첫 글자는 무조건 언더바나 알파벳이어야 함.
    - 심볼을 변수에 할당할 수도 있다.
    - they're primarily used either as hash keys or for referencing method names.: 해쉬의 키나, 메소드 네임의 레퍼런스로 주로 활용된다. 좋은 해쉬 키가 될 수 있는 세가지 이유는 다음과 같다. 1.한 번 심볼이 생성되면 얘는 바꿀 수가 없다. 변하지 않음. 2.오직 하나만 존재한다. 그래서 메모리 절약 3.해쉬에서 값을 뽑았을 때 1과 2의 이유 때문에 검색이 훨씬 빨라진다. 일반 문자열로 했을 때보다.
- 콤마 마지막에 찍어도 오케이. 루비에서는 해쉬나 리스트를 생성할 때 마지막 원소 뒤에 콤마(,) 찍어도 에러 안난다.
- 심볼과 스트링의 전환은 쉽다. .to_s .to_sym 메소드를 각각 쓰면 된다. 심볼화할 때 .intern 써도됨. internalize 한다는 의미라고 함.

####업업 기본
- 리스트 .push, <<, +
    - 리스트에 마지막에 원소 추가할 때 파이썬과 다르게 append 없다. push 써야함.
    - 재밌는건 이것도 된다. [1, 2, 3, 4] << 5 이렇게 적으면 [1, 2, 3, 4].push(5) 와 같은 의미. 문자열에서도 동일하게 먹힌다.
    - “hello “ << “gyubin” 이렇게 하면 “hello gyubin”이 됨. 물론 문자열에서는 +도 된다.
- =>는 hash rocket 이라고 함.
- Hash 키 심볼 생성
    - : 를 만들 때 루비 1.9부터 변경됨. 콜론을 뒤에다 찍으면 알아서 심볼이되면서 해시 로켓을 안써도 됨.
    - 여기서 무조건 키 뒤에 : 붙여 써야함. hash_test = {aaa: “aaa”, bbb: “bbb”} 이렇게 키랑 붙여써야함. 띄우면 에러.
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
