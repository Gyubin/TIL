# argparse

커맨드라인에서 `.py` 파일에 옵션을 주고 실행할 때 사용하는 방법

```py
import argparse

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('integers', metavar='N', type=int, nargs='+',
                    help='an integer for the accumulator')
parser.add_argument('--sum', dest='accumulate', action='store_const',
                    const=sum, default=max,
                    help='sum the integers (default: find the max)')

args = parser.parse_args()
print(args.accumulate(args.integers))
```

- 위처럼 파일을 만들고 `-h` 옵션을 주고 실행하면 다음이 출력된다.

    ```
    usage: prog.py [-h] [--sum] N [N ...]

    Process some integers.

    positional arguments:
     N           an integer for the accumulator

    optional arguments:
     -h, --help  show this help message and exit
     --sum       sum the integers (default: find the max)
    ```

- `parser` 인스턴스 만들 때 description은 전체 소개글이다.
- `parser.add_argument` : argument 지정
    + 첫 번째 매개변수: argument로 지정할 문자열.
    + `type` : 타입 지정
    + `default` : 위 케이스에선 `--sum`이 없으면 `max` 함수 실행
    + `help` : 해당 argument의 소개, 의미.









