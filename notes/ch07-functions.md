# Chapter 7. 함수

함수(Function): 프로그램의 실행 과정 중에서 독립적으로 처리될 수 없는 부분을 분리하여 구조화한 객체

## 7.1. 함수의 기본 개념

함수의 구분

- 일반 함수: 프로그래밍 언어나 프레임워크 수준에서 제공하는 함수. 기본적 데이터의 처리나 연산 등을 수행하기 위한 목적으로 사용
- 사용자 정의 함수: 언어나 프레임워크가 제공하는 함수만으로 충분하지 않을 때 원하는 기능을 실행하도록 직접 만든 함수

함수의 이점

- 동일한 코드가 여러 곳에서 사용될 때 재작성할 필요 없이 호출만으로 처리할 수 있다.
- 기능 단위로 함수화하면 가독성이 좋아지고, 코드와 로직을 이해하기 쉽다.
- 비즈니스 로직을 변경해야할 때 내부 함수만 수정하므로 유지보수가 용이하다.

## 7.1.1. 사용자 정의 함수

함수의 정의 형식

```swift
func 함수이름(매개변수1: 타입, 매개변수2: 타입, ...) -> 반환타입 {
  실행내용
  return 반환값
}
```

함수 작명 규칙

- 연산자나 예약어는 사용할 수 없음
- 첫 글자는 반드시 영어 또는 언더바(\_)로 시작해야 함
- 두번째 글자부터는 제약이 없음

함수의 반환 타입

- `->` 기호와 함께 사용
- 자료형, 클래스 객체, 커스텀 클래스ㅡ 구조체 모두 반환 가능
- 반환 타입은 반드시 지켜야 함
- nil을 반환하려면 함수의 반환 타입이 반드시 옵셔널 타입으로 정의되어 있어야 함
- 반환타입이 없다면 생략
- `return`으로 함수의 실행을 명시적으로 종료 가능

## 7.1.2. 함수의 호출

- 함수를 호출하는 연산자인 `()`를 뒤에 붙여서 호출함
- 매개변수가 있을 경우 `()`안에 매개변수를 입력

인자 레이블

- 함수 호출시 인자값을 구분하기 위해 사용하는 레이블

레이블 예시

```swift
printHelloWithName(name: "홍길동") // label: "name:"
```

```swift
func incrementBy(amount: Int, numberOfTimes: Int) -> Int {
  var count = 0
  count = amount * numberOfTimes
  return count
}

// 실행
incrementBy(amount: 1, numberOfTimes: 3)
```

`amount`, `numberOfTimes`는 매개변수명이자 동시에 인자 레이블임

인자 레이블을 붙이는 이유: 인자값의 목적을 확실하게 드러내 줄 뿐만 아니라, 비슷하지만 서로 다른 의미로 사용되는 함수를 구분하기 위해서

함수 이름 규칙

| 함수 정의                                        | 함수명                             |
| ------------------------------------------------ | ---------------------------------- |
| func incrementBy()                               | incrementBy()                      |
| func incrementBy(amount:Int)                     | incrementBy(amount:)               |
| func incrementBy(Amount:Int, numberOfTimes: Int) | incrementBy(Amount, numberOfTimes) |
| func printHello()                                | printHello()                       |
| func printHello(name: String)                    | printHello(name:)                  |

```swift
incrementBy(amount: 1, numberOfTimes: 3)

func times(x: Int, y: Int) -> Int {
  return (x * y)
}

times(x: 5, y: 10) // 함수의 이름만으로 호출
times(x:y:)(5, 10) // 함수의 식별자를 사용하여 호출
```

## 7.1.3. 함수의 반환값과 튜플

함수는 반드시 하나의 값만을 반환함

여러 개의 반환값이 필요한 경우: 집단 자료형에 담아 반환

- 딕셔너리
- 배열
- 튜플
- 구조체
- 클래스

튜플을 반환하는 함수 예시

```swift
func getIndividualInformation() -> (Int, String) {
  let height = 180
  let name = "꼼꼼한 재은씨"

  return (height, name)
}
```

튜플을 반환하는 함수 예시2

```swift
func getUserInformation() -> (Int, Character, String) {
    let type: Character = "A"
    let height = 180
    let name = "꼼꼼한 재은씨"

    return (height, type, name)
}

var uInfo = getUserInformation()
uInfo.0 // 180
uInfo.1 // "A"
uInfo.2 // "꼼꼼한 재은씨"
```

튜플을 반환하는 함수 예시3(변수가 바인딩된 튜플)

```swift
func getUserInformation2() -> (h: Int, t: Character, n: String) {
    let type: Character = "A"
    let height = 180
    let name = "꼼꼼한 재은씨"

    return (height, type, name)
}

var uInfo2 = getUserInformation2()
uInfo2.h // 180
uInfo2.t // "A"
uInfo2.n // "꼼꼼한 재은씨"
```

typealias

```swift
typealias <새로운 타입 이름> = <타입 표현>
```

typealias 예시

```swift
typealias infoResult = (Int, Character, String)

func getUserInformation3() -> infoResult {
    let type: Character = "A"
    let height = 180
    let name = "꼼꼼한 재은씨"

    return (height, type, name)
}

var uInfo3 = getUserInformation2()
uInfo3.0 // 180
uInfo3.1 // "A"
uInfo3.2 // "꼼꼼한 재은씨"
```

타입 알리어스로 변수가 바인딩된 튜플의 정의도 가능함

## 7.2. 매개변수

함수의 매개변수 종류

- 내부 매개변수: 함수가 내부적으로 인자값을 참조하기 위해 사용하는 변수
- 외부 매개변수: 함수 외부에서 함수나 인자값을 구분하기 위해 사용하는 변수

## 7.2.1. 내부 매개변수명, 외부 매개변수명

```swift
func 함수이름(<외부 매개변수명><내부 매개변수명>: <타입>, <외부 매개변수명><내부 매개변수명>: <타입>...) {
  // code
}
```

외부 매개변수명 예시

```swift
func printHello(to name: String, welcomeMessage msg: String) {
    print("\(msg), \(name)")
}

printHello(to: "홍길동", welcomeMessage: "안녕하세요") // "안녕하세요, 홍길동\n"
```

위의 경우 함수명은 `printHello(name:msg:)`가 아니라 `printHello(to:welcomeMessage:)`

외부 매개변수 자리에 언더바(_)를 넣어주면 외부 매개변수명을 생략할 수 있음. 만약 위의 외부매개변수를 언더바로 변경하면 함수명은 `printHeloo(_:\_:)`가 됨

> 언더바의 의미: "문법은 적용하되 사용하지 않는다. 생략하겠다"

## 7.2.2. 가변 인자

`...` 연산자로 가변인자 이용 가능

```swift
func 함수이름(매개변수명 : 매개변수 타입 ...)
```

```swift
func avg(score: Int...) -> Double {
    var total = 0
    for r in score {
        total += r
    }
    return (Double(total) / Double(score.count))
}

print(avg(score: 10,20,30,40)) // "25.0n\"
```

## 7.2.3. 기본값을 갖는 매개변수

함수 호출시 인자값을 생략할 수 있또록 기본값을 지정하는 문법

```swift
func 함수이름(매개변수: 매개변수명: 매개변수 타입 = 기본값) {
  실행할 내용
}
```

```swift
func echo(message: String, newline: Bool = true) {
    if newline == true {
        print(message, true)
    } else {
        print(message, false)
    }
}

echo(message: "Hello") // "Hello true\n"
echo(message: "Hello", newline: true) // "Hello true\n"
echo(message: "Hello", newline: false) // "Hello false\n"
```

```swift

```

## 7.2.4. 매개변수의 수정

사실상 매개변수는 값을 수정할 수 없으므로 "매개상수"라고 해야한다.

```swift
func incrementBy2(base: Int) -> Int {
    base += 1 // Error "Left side of mutating operator isn't mutable: 'base' is a 'let' constant"
    return base
}
```

함수에 입력된 인자값은 함수 내부에서 항상 상수로 정의됨

내부에서 변경해서 사용하는 방법

```swift
func incrementBy2(base: Int) -> Int {
    var base = base
    base += 1
    return base
}
```

## 7.2.5. InOut 매개변수

`inout` 키워드를 매개변수에 붙여주면 함수 내부에서 외부 변수의 값을 변경할 수 있음. 단, 값이 저장된 메모리 주소를 변수 대신 전달해야 함. 주소추출 연산자 `&`를 이용함

inout 키워드 예시

```swift
func foo(paramCount: inout Int) -> Int {
    paramCount += 1
    return paramCount
}

var count = 30
print(foo(paramCount: &count))
print(count)
```

주소를 직접 전달하는 '참조에 의한 전달'은 함수에서 inout 키워드를 사용했을 때 적용. 예외적으로 클래스(Class)로 구현된 인스턴스는 inout 키워드를 사용하지 않아도 항상 참조에 의해 전달됨. 즉 함수의 인자값을 전달한 클래스 인스턴스는 함수 내부에서 값이 수정되면 원본 객체도 영향을 받음

inout 키워드 인자값 객체의 종류에 주의

- 함수 내부에서 원본 객체에 직접 값을 수정할 수 있어야 하므로 상수는 전달할 수 없음
- 리터럴 역시 전달 불가
- 오직 변수만 인자값으로 사용 가능

변수의 범위 특성을 이용해 참주에 의한 전달방식 적용하기

- 상위 범위에서 정의된 변수는 하위 범위에서도 사용할 수 있음

## 7.2.6. 변수의 생존 범위와 생명 주기

변수의 스코프(Scope): 정의된 위치에 따라 사용할 수 있고, 생존할 수 있는 일정 영역을 부여하는 것. 변수의 생존 범위

- 전역변수
- 지역변수

블록별 변수의 검색 순서

함수내부->함수외부->글로벌범위->import한 라이브러리 범위

## 7.3. 일급 객체로서의 함수

## 7.3.1. 일급 함수의 특성

## 7.3.2. 함수의 중첩

## 7.4. 클로저

## 7.4.1. 클로저 표현식

## 7.4.2. 클로저 표현식과 경량 문법

## 7.4.3. 트레일링 클로저(Trailing Closure)

## 7.4.4. @escaping과 @autoescape
