# 최소 강의실 구하기

## 1. 문제

시작, 끝 시간이 정해진 강의들이 여러개 있다. 시간이 겹치는 경우가 있을 때 필요한 최소 강의실 개수를 구하면 된다.

입력 데이터는 첫 줄에 강의 수를 입력받고, 다음 각 줄마다 강의의 시작과 끝 시간이 입력된다.

```
8  
15 21  
20 25  
3 8  
2 14  
6 27  
7 13  
12 18  
6 20
```

## 2. 코드

```py
def find_min_room(num_class, classes):
    size = 0
    for i in range(num_class):
        if size < classes[i][1]:
            size = classes[i][1]
    if size == 0: return 0
    time_table = [0] * size
    for elem in classes:
        for i in range(elem[0], elem[1]):
            time_table[i] += 1  
    return max(time_table)

def read_inputs():
    num_class = int(input())
    classes = []
    for i in range(num_class):
        line = [int(x) for x in input().split()]
        start = line[0]
        end = line[1]
        classes.append((start, end))

    return num_class, classes

def main():
    num_class, classes = read_inputs()
    ans = find_min_room(num_class, classes)
    print(ans)

if __name__ == "__main__":
    main()
```

- 각 시간대별로 몇 개의 강의가 진행되는지 구하고, 그 중에서 최대값을 구하면 강의실 개수가 나온다. 인덱스가 시간대를 나타내는 배열을 만들고 값으로 진행되는 수업의 개수를 저장한다.
- `find_min_room` 함수
    + `size`와 첫 번째 for 반복은 전체 배열의 크기를 알기 위한 것이다. 각 수업에서 끝 시간중에 가장 큰 값을 구한다. 만약 그 값이 0이라면 애초에 수업이 없는 것이므로 바로 0을 리턴하고 종료한다.
    + size 크기만큼 `time_table` 배열을 만들고 각 수업마다 시작시간 인덱스부터 끝 시간 인덱스까지 수업이 원소에 1을 증가시킨다. 그 시간에 수업이 있는 것이므로
    + 최종으로 가장 높은 값을 max 함수를 써서 리턴한다.
