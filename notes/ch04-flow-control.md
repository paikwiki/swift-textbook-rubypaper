# Chapter 4. 흐름 제어 구문

## For, While 반복문

횟수에 의한 반복. for문은 하나의 형식 뿐이 없음

```swift
for <루프 상수> in <순회 대상> {
  <실행 구문>
}
```

순회 대상으로 사용가능한 데이터 타입

- Array(배열)
- Dictionary(딕셔너리)
- Set(집합): 유사 속성의 데이터 여러 개가 모여 하나의 덩어리를 이루는 집단 자료형(Collective Types)
- 범위 데이터: 범위 연산자에 의해 규칙적인 간격으로 나열된 정수들의 모음
- 문자열(String)

구구단 예제

```swift
for row in 1...9 {
  print("2 X \(row) = \(row * 2)")
}
```

```swift
/* 출력 */
2 X 1 = 2
2 X 2 = 4
2 X 3 = 6
2 X 4 = 8
2 X 5 = 10
2 X 6 = 12
2 X 7 = 14
2 X 8 = 16
2 X 9 = 18
```

문자열 예제

```swift
var lang = "swift"
for char in lang {
    print("Each character is \(char).")
}
```

```swift
/* 출력 */
Each character is s.
Each character is w.
Each character is i.
Each character is f.
Each character is t.
```

루프 상수의 생략

```swift
let size = 5
let padChar = "0"
var keyword = "3"

for _ in 1...size {
    keyword = padChar + keyword
}
print("\(keyword)")
```

```swift
/* 출력 */
000003
```

While 반복문

조건에 의한 반복. while문은 `while`과 `repeat ~ while`, 두 개의 형식이 있음. while문을 이용하는 경우

- 실행 횟수가 명확하지 않을 때
- 직접 실행해보기 전까지는 실행 횟수를 결코 알 수 없을 때
- 실행 횟수를 기반으로 할 수 없는 조건일 때

while문 형식

```swift
while <조건식> {
  <실행할 구문>
}
```

```swift
var n = 2
while n < 1000 {
  n = n * 2
}
print("n = \(n)")
```

```swift
/* 출력 */
n = 1024
```

repeat~while문. 다른 언어에서의 do~while문과 유사함.

```swift
repeat {
  <실행할 구문>
}
while <조건식>
```

```swift
var n2 = 1024

repeat {
  n2 = n2 * 2
}
while n2 < 1000
print("n2 = \(n2)")
```

```swift
/* 출력 */
n2 = 2048
```

## 조건문

if / else 구문

```swift
if <조건식> {
  <실행 구문>
} else if <조건식> {
  <실행 구문>
} else {
  <실행 구문>
}
```

guard~else 구문. if와 조건을 반대로 작성. 조건을 체크해 실행 흐름을 종료시킬 때 가급적 guard 구문 활용

```swift
func divide(base: Int) {
    guard base != 0 else {
        print("연산할 수 없습니다.")
        return
    }
    guard base > 0 else {
        print("base는 0보다 커야 합니다.")
        return
    }
    guard base < 100 else {
        print("base는 100보다 작아야 합니다.")
        return
    }
    let result = (100 / base)
    print(result)
}
divide(base: 0)
divide(base: -1)
divide(base: 100)
divide(base: 50)
```

```swift
/* 출력 */
연산할 수 없습니다.
base는 0보다 커야 합니다.
base는 100보다 작아야 합니다.
2
```

`#available` 구문

```swift
if #available(<플랫폼이름 버전>, <...>, <*>) {
  <해당 버전 API 사용 구문>
} else {
  <API를 사용할 수 없는 환경 처리>
}
```

`#available` 구문의 인자값은 가변인자. 쉼표로 구분하여 플랫폼 이름과 OS 버전을 계속 나열할 수 있음. 나열이 끝나면 마지막은 `*`로 마감하여 인자값 입력이 모두 끝났음을 선언해야 함

```swift
if #available(iOS 9, OSX 10.10, watchOS 1, *) {
  // API 사용 구문
} else {
  // API 사용 불가시 실패 처리
}
```

switch 구문

```swift
switch <비교 대상> {
  case <비교 패턴1> :
    <실행 구문>
  case <비교 패턴2>, <비교 패턴3> :
    <실행 구문>
  defualt :
    <실행 구문>
}
```

반드시 `default` 있어야 하지만 모든 패턴을 매칭시킬 수 있는 구문이 있으면 `default` 구문 생략 가능

튜플을 사용할 경우, 아래의 세 경우 모두 성립함. 조건은 첫번째 조건에서 멈추지만 세 경우 모두 참.

```swift
var value = (2,3)

switch value {
    case let (x, 3) :
        print("second: 3, first \(x)")
    case let (3, y) :
        print("first: 3, second \(y)")
    case let (x, y) :
        print("first: \(x), second \(y)")
}
```

## 제어전달문

- break
- continue
- fallthrough
- return

구문 레이블과 break, continue

```swift
outer : for i in 1...5 {
    inner : for j in 1...9 {
        if (j == 3) {
            break outer
        }
        print("\(i) X \(j) = \(i * j)")
    }
}
```

```swift
/* 출력 */
1 X 1 = 1
1 X 2 = 2
```

`fallthrough`: swich 구문에서 case 블록의 실행을 다음 case 블록으로 전달할 때 사용
