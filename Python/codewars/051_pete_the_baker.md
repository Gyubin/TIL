# #51 Pete, the baker

recipe dictionary, available dictionary 두 객체를 매개변수로 받는다. 가능한 재료 중에서 레시피를 몇 개나 만들 수 있는지 리턴하는 문제.

## 1. 내 코드

```py
def cakes(recipe, available):
    result = -1
    for k in recipe:
        if k in available:
            hey = available[k] / recipe[k]
            if result == -1: result = hey
            if hey == 0: return 0
            if hey < result: result = hey
        else:
            return 0
    return result
```

- 레시피에서 key를 뽑아서, 만약 key가 available에 없으면 바로 0을 리턴한다.
- 만약 재료에 있다면 재료량을 조리법량으로 나눈다. 이 값이 최대로 만들 수 있는 전체 요리량이다.
- 첫 result 값을 -1로 줘서 처음엔 무조건 대입되도록 하고, 0이 대입되면 바로 0을 리턴한다. 반복을 돌면서 최대 요리량이 result보다 작다면 result 값을 갱신해준다. 전체 반복을 돈 후에 result를 리턴한다.

## 2. 다른 해답

```py
def cakes(recipe, available):
    return min([available.get(k,0)/v for k,v in recipe.iteritems()])
```

- recipe에서 키, 밸류를 뽑아서 for 내포 리스트를 만든다.
- 리스트에 적용될 값은 available에서 키로 값을 뽑는데 만약 없다면 0을 리턴해야하므로 get 함수를 썼다. 이 값을 밸류로 나눈 값이다.
- 이렇게 만들어진 함수에서 가장 작은 값을 리턴한다.
- 매우 머리가 좋다.
