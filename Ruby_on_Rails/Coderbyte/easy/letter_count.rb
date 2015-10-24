def LetterCountHash(str)
    sentence_hash = {}
    word_array = []

    str.downcase.split(' ').each do |word|
        word.split(//).each do |c|
            word_array.push(word.scan(c).count)
        end
        sentence_hash[word] = word_array.max
    end

    if word_array.max == 1
        return -1
    end

    max_word = sentence_hash.key(sentence_hash.values.max)
        return max_word
    end

def LetterCountArray(str)
    word_array = []         # 문장을 단어로 쪼개서 단어를 넣어둘 배열.
    cnt_array = []            # 단어 별로 가장 많이 반복된 알파벳 숫자를 넣을 배열
    temp_cnt = []

    str.downcase.split(' ').each do |word|                      # 단어로 쪼개서 단어별로 each 돌린다. 반복문
        word_array.push(word)                                       # 일단 쪼개진 단어를 단어 배열에 넣는다.
        word.split(//).each do |c|                                      # 단어를 또 알파벳 단위로 쪼개서 알파벳마다 each 반복문
            temp_cnt.push(word.scan(c).count)                # 알파벳별로 하나씩 scan해서 몇 개 있는지 temp_cnt에 넣는다.
        end
        cnt_array.push(temp_cnt.max)                            # temp_cnt의 맥스값을 cnt_array에 추가한다.
    end

    if cnt_array.max == 1                                               # 반복된 값이 없다면 리턴 -1
        return -1
    end

    index = cnt_array.index(cnt_array.max)
    return word_array.at(index)
end
