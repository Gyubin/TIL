# Binary search

## 1. 의미

- 이진 탐색은 전체 데이터를 순서대로 검색하는 것이 아니라 정 중앙을 기준으로 나눠서 찾는다.
- 찾고자 하는 데이터가 중앙값보다 크면 우측 데이터 중에서 다시 찾고, 중앙값보다 작으면 왼쪽 데이터 중에서 찾는다.
- 다만 데이터가 오름차순으로 정렬돼있음을 가정해야한다.
- 시간복잡도는 `{\log_2 2}`로 매우 작다.

## 2. 코드

```c
int binary_search(int arr[], int size, int find_data)
{
    int start = 0
    int end = size - 1
    int mid;

    while (start <= end)
    {
        mid = (start + end) / 2;
        if (arr[mid] > find_data)
            end = mid - 1;
        else if (arr[mid] < find_data)
            start = mid + 1;
        else
            return mid;
    }
    return -1;
}
```

- `start`는 왼쪽 끝 인덱스, `end`는 마지막 인덱스이다. 만약 start가 end보다 커지는 때가 오면 사이에 정답이 없으므로 -1을 리턴한다.
- `mid`는 중앙값을 의미한다.
- 중앙값이 찾으려는 값 `find_data`보다 크면 `end`를 중앙 바로 전 값으로 당긴다. 반대라면 `start` 값을 중앙 바로 다음 값으로 민다. 찾으려는 영역을 재설정.
- 값을 찾으면 해당 원소 값이 속한 인덱스인 `mid`를 바로 리턴하고 아니면 계속 반복문을 돈다.
