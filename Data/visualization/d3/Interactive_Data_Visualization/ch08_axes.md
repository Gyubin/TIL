# Chapter 8 Axes

- 리턴값 없다. 그냥 그리기만 할 뿐.
- SVG에서만 동작한다. 그리고 계량 수치에서만 쓴다.

```js
var xAxis = d3.svg.axis()
              .scale(xScale)
              .orient("bottom");
              
svg.append("g")
    .call(xAxis);
```

```js
var xAxis = d3.svg.axis() .scale(xScale)
                .orient("bottom")
                .ticks(5); //Set rough # of ticks
```

















