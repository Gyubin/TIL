# List - Data Structure

## 0. 개념

- 자료를 순서대로 저장한다.
- 배열 리스트, 연결리스트 두 종류 존재.
- 추상 자료형
    + `list creat_list(int len);`: 최대 원소 개수를 입력받아 리스트 만들어 리턴
    + `void delete_list(list l);`: 지우기
    + `int is_full(list l);`: 리스트가 꽉 찼는지 T/F로 리턴
    + `int add_element(list l, int p, void *data);`: 데이터를 p 인덱스에 추가하고 성공 실패를 리턴
    + `int remove_element(list l, int p);`: 리스트에서 p 인덱스 원소 제거 후 성공/실패 리턴
    + `void clear_list(list l);`: 리스트 모든 원소 제거
    + `int get_list_length(list l);`: 리스트 원소 개수 리턴
    + `void *get_element(list l, int p);` 리스트에서 특정 인덱스의 원소 리턴
    + `void display_list(list l);`: 모든 원소 출력. 디버깅용.

## 1. Array list

- 배열을 활용
- 원소 추가: 뒤 원소들을 모두 한 칸씩 뒤로 이동시켜야
- 원소 제거: 제거한 원소의 우측 원소들을 한칸 씩 당겨야

```c
#ifndef __ARRAY_LIST_H
# define __ARRAY_LIST_H

typedef struct  array_list_node_type
{
    int data;
}               array_list_node;

typedef struct  array_list_type
{
    int max_element_count;
    int current_element_count;
    array_list_node *ptr_element;
}               array_list;

#endif
```

## 2. Linked list
