# MongoDB

## 1. filter

```js
db.users.find(obj)
```

find의 기본 형태. obj에 조건을 넣어주면 된다.

```js
{ status: { $in: [ "P", "D" ] } } // status가 P, D 중 하나인 것
{ status: "A", age: { $lt: 30 } } // status가 "A"이고, age가 30보다 작은 것
{ $or: [ { status: "A" }, { age: { $lt: 30 } } ] } // status가 A이거나 age가 30보다 작거나
{ status: "A", $or: [ { age: { $lt: 30 } }, { type: 1 } ] } // status가 A인데 age가 30보다 작거나 type이 1이거나.
```
