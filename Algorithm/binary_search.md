# Binary search

## 1. 의미

- 이진 탐색은 전체 데이터를 순서대로 검색하는 것이 아니라, 데이터를 반으로 쪼개서 좌우에서 찾는다.
- 사용하는 변수들
    + `start`: 시작 인덱스로 항상 찾는 수보다 작은 값을 가리킨다.
    + `end`: 마지막 인덱스로 항상 찾는 수보다 큰 값을 가리킨다.
    + `mid`: start와 end를 합해서 2로 나눈 값, 중앙값이다.
- 특정 값을 찾는 경우
    + start, end 값을 확인할 때 바로 찾아질 수 있다.
    + 찾고자 하는 데이터가 중앙값보다 크면 우측 데이터 중에서 다시 찾고, 중앙값보다 작으면 왼쪽 데이터 중에서 찾는다.
    + start와 end 인덱스가 바로 인접하면(붙으면) 찾는 수는 없다는 의미
- 데이터가 정렬되어있음을 가정한다.
- 시간복잡도는 `{\log_2 n}`, 즉 `log n`으로 매우 작다.

## 2. 코드

```c
int binary_search(int arr[], int size, int target)
{
    int start = 0
    int end = size - 1
    int mid;

    if (arr[start] == target)
    {
        return start
    }
    if (arr[end] == target)
    {
        return end
    }
    while (start <= end)
    {
        mid = (start + end) / 2;
        if (arr[mid] > target)
            end = mid - 1;
        else if (arr[mid] < target)
            start = mid + 1;
        else
            return mid;
    }
    return -1;
}
```

- `start`는 왼쪽 끝 인덱스, `end`는 마지막 인덱스이다. 만약 start가 end보다 커지는 때가 오면 사이에 정답이 없으므로 -1을 리턴한다.
- `mid`는 중앙값을 의미한다.
- 중앙값이 찾으려는 값 `target`보다 크면 `end`를 중앙 바로 전 값으로 당긴다. 반대라면 `start` 값을 중앙 바로 다음 값으로 민다. 찾으려는 영역을 재설정.
- 값을 찾으면 해당 원소 값이 속한 인덱스인 `mid`를 바로 리턴하고 아니면 계속 반복문을 돈다.
