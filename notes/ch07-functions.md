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

### 7.1.1. 사용자 정의 함수

함수의 정의 형식

```txt
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
- 자료형, 클래스 객체, 커스텀 클래스, 구조체 모두 반환 가능
- 반환 타입은 반드시 지켜야 함
- nil을 반환하려면 함수의 반환 타입이 반드시 옵셔널 타입으로 정의되어 있어야 함
- 반환타입이 없다면 생략
- `return`으로 함수의 실행을 명시적으로 종료 가능

### 7.1.2. 함수의 호출

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

<!-- prettier-ignore -->
| 함수 정의                      | 함수명                             |
| ------------------------------ | ---------------------------------- |
| func incrementBy()             | incrementBy()                      |
| func incrementBy(amount:Int)   | incrementBy(amount:)               |
| func incrementBy(Amount:Int, numberOfTimes: Int) | incrementBy(Amount, numberOfTimes) |
| func printHello()              | printHello()                       |
| func printHello(name: String)  | printHello(name:)                  |

```swift
incrementBy(amount: 1, numberOfTimes: 3)

func times(x: Int, y: Int) -> Int {
  return (x * y)
}

times(x: 5, y: 10) // 함수의 이름만으로 호출
times(x:y:)(5, 10) // 함수의 식별자를 사용하여 호출
```

### 7.1.3. 함수의 반환값과 튜플

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

### 7.2.1. 내부 매개변수명, 외부 매개변수명

```txt
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

<!-- prettier-ignore -->
외부 매개변수 자리에 언더바(_)를 넣어주면 외부 매개변수명을 생략할 수 있음. 만약 위의 외부매개변수를 언더바로 변경하면 함수명은 `printHeloo(_:_:)`가 됨

> 언더바의 의미: "문법은 적용하되 사용하지 않는다. 생략하겠다"

### 7.2.2. 가변 인자

`...` 연산자로 가변인자 이용 가능

```txt
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

### 7.2.3. 기본값을 갖는 매개변수

함수 호출시 인자값을 생략할 수 있또록 기본값을 지정하는 문법

```txt
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

### 7.2.4. 매개변수의 수정

사실상 매개변수는 값을 수정할 수 없으므로 "매개상수"라고 해야 옳은 표현이다.

```swift
func incrementBy2(base: Int) -> Int {
  base += 1 // Error "Left side of mutating operator isn't mutable: 'base' is a 'let' constant"
  return base
}
```

함수에 입력된 인자값은 함수 내부에서 항상 상수로 정의된다.

내부에서 변경해서 사용하는 방법

```swift
func incrementBy2(base: Int) -> Int {
  var base = base
  base += 1
  return base
}
```

### 7.2.5. InOut 매개변수

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

함수에서 inout 키워드를 사용했을 때는 주소를 직접 전달하는 '참조에 의한 전달'이 이뤄진다. 예외적으로 클래스(Class)로 구현된 인스턴스는 inout 키워드를 사용하지 않아도 항상 참조에 의해 전달됨. 즉 함수의 인자값으로 클래스 인스턴스를 전달한 경우, 함수 내부에서 클래스 인스턴스의 값이 수정되면 원본 객체도 영향을 받음

inout 키워드 인자값 객체의 종류에 주의

- 함수 내부에서 원본 객체에 직접 값을 수정할 수 있어야 하므로 상수는 전달할 수 없음
- 리터럴 역시 전달 불가
- 오직 변수만 인자값으로 사용 가능

변수의 범위 특성을 이용해 참주에 의한 전달방식 적용하기

- 상위 범위에서 정의된 변수는 하위 범위에서도 사용할 수 있음

### 7.2.6. 변수의 생존 범위와 생명 주기

변수의 스코프(Scope)란 정의된 위치에 따라 사용할 수 있고, 생존할 수 있는 일정 영역을 부여하는 것으로, 변수의 생존 범위라고 할 수 있다.

- 전역변수
- 지역변수

블록별 변수의 검색 순서: 함수내부 -> 함수외부 -> 글로벌범위 -> import한 라이브러리 범위

## 7.3. 일급 객체로서의 함수

일급 객체(First-Class Object)

- 1960년대, 영국의 컴퓨터 과학자 크리스토퍼 스트래치(Christopher Strachey)가 처음 사용
- 프로그램 언어 안에서 특정 종류의 객체가 일급의 지위를 가지는가에 대한 의미
- 스위프트는 객체지향 언어이자 동시에 함수형 언어

### 7.3.1. 일급 함수의 특성

일급 객체의 조건

1. 객체가 런타임에도 생성이 가능해야 한다.
1. 인자값으로 객체를 전달할 수 있어야 한다.
1. 반환값으로 객체를 사용할 수 있어야 한다.
1. 변수나 데이터 구조 안에 저장할 수 있어야 한다.
1. 할당에 사용된 이름과 관계없이 고유한 구별이 가능해야 한다.

함수가 위의 조건을 만족할 경우 이를 일급 함수(First-Class Function)이라고 하며, 그 언어를 함수형 언어로 분류함 -> 함수형 언어에서는 함수가 일급 객체로 대우받는다는 뜻

일급 함수 특성1) 변수나 상수에 함수를 대입할 수 있음

- '변수나 상수에 함수를 대입한다'는 것은 함수의 결과값을 대입하는 게 아니라 함수 자체를 대입하는 것
- 변수도 함수처럼 인자값을 받아 실행이 가능하고, 값을 반환할 수도 있음
- 함수의 호출 형식이 확장됨을 의미함

함수 타입(Function Types)

- 변수에 함수를 대입하면 일반적인 문자열, 정수, 배열 또는 딕셔너리와는 전혀 다른 타입이 됨
- 변수에 정수를 대입하면 Int 타입이, 문자열을 대입하면 String 타입이 되듯이, 변수에 함수를 대입하면 함수 타입이 됨

함수 타입의 표현

```txt
func boo(age: Int) -> String {
  return "\(age)"
}
```

위 함수를 함수 타입 형태로 표현하면 아래와 같음

```swift
(Int) -> String
```

위 함수를 상수에 할당한다면 상수의 타입 어노테이션을 포함한 할당 구문은 아래와 같음

```swift
let fn: (Int) -> String = boo
```

필요할 경우 타입 어노테이션을 적절히 사용하면, 같은 함수 이름을 사용하여 대입하더라도 서로 다른 결과를 가져올 수 있음

```swift
let fn01: (Int) -> String = boo // boo(age:)
let fn02: (Int, String) -> String = boo // boo(age:name:)
```

일급함수의 특성2) 함수의 반환 타입으로 함수를 사용할 수 있음

```swift
func desc() -> String {
  return "this is desc()"
}

func pass() -> () -> String {
  return desc
}

let p = pass()
p() // "this is desc()"
```

`pass` 함수의 반환 타입은 함수 타입인 `() -> String`

일급함수의 특성3) 함수의 인자값으로 함수를 사용할 수 있음

콜백 함수(Callback Function)

- 특정 구문의 실행이 끝나면 시스템이 호출하도록 처리된 함수
- 일반적으로 Ajax 통신을 위한 구문을 작성할 때, 콜백 함수를 등록

함수를 입력받는 인자값은 함수 타입으로 정의되어야 한다.

```swift
func incr(param: Int) -> Int {
  return param + 1
}

func broker(base: Int, function fn: (Int) -> Int) -> Int {
  return fn(base)
}

broker(base: 3, function: incr) // 4
```

콜백 함수 사용 예시

```swift
func successThrough() {
  print("Success")
}

func failThrough() {
  print("Fail")
}

func divide(base: Int, succes sCallBack: () -> Void, fail fCallBack: () -> Void) -> Int {

  guard base != 0 else {
    fCallBack()
    return 0
  }

  defer {
    sCallBack()
  }

  return 100 / base
}

divide(base: 30, succes: successThrough, fail: failThrough)
```

defer 블록

- 함수나 메소드에서 코드의 흐름과 상관ㅇ벗이 가장 마지막에 실행되는 블록
- 지연 블록이라고 부르기도 함
- 작성된 위치에 상관없이 함수의 종료 직전에 실행되므로, 종료 시점에 맞춰 처리해야할 구문이 있다면 defer 블록에 넣어두면 됨

defer 블록의 특징

1. defer 블록은 작성된 위치와 순서에 상관없이 함수가 종료되기 직전에 실행된다.
1. defer 블록을 읽기 전에 함수의 실행이 종료될 경우 defer 블록은 실행되지 않는다.
1. 하나의 함수나 메소드 내에서 defer 블록을 여러번 사용할 수 있다. 이때 가장 마지막에 작성된 defer 블록부터 역순으로 실행된다.
1. defer 블록을 중첩해서 사용할 수 있다. 이때 바깥쪽 defer 블록부터 실행되며 가장 안쪽에 있는 defer 블록은 가장 마지막에 실행된다.

익명함수

- 재사용하지 않는 코드를 굳이 함수로 작성하는 것을 방지. 일회용
- 스위프트에서는 익명함수를 클로저(Closure)라고 부름

익명함수 예시

```swift
divide(base: 30, succes: successThrough, fail: failThrough)

divide(base: 30,
  succes: {
  () -> Void in
  print("Success")
},
  fail: {
  () -> Void in
  print("Fail")
})
```

### 7.3.2. 함수의 중첩

중첩 함수(Nested Function)

- 함수 내에 다른 함수를 작성해사 사용
- 내부 함수(Inner Function), 외부 함수(Outer Function)으로 구분
- 외부함수가 종료되면 내부함수도 존재하지 않게 됨(내부 함수의 생명 주기)
- 함수의 은닉성: 내부함수는 외부함수를 거치지 않으면 접근할 수 없음

```swift
func outer(base: Int) -> String {
  func inner(inc: Int) -> String {
    return "\(inc)를 반환합니다"
  }
  let result = inner(inc: base + 1)
  return result
}
outer(base: 3) // "4를 반환합니다"
```

## 7.4. 클로저

### 7.4.1. 클로저 표현식

클로저 예시

```swift
let f = { () -> Void in
  print("클로저가 실행됩니다")
}
f()

({ () -> Void in
  print("클로저가 실행됩니다")
})()

({ (s1: Int, s2: String) -> Void in
  print("s1:\(s1), s2:\(s2)")
})(1, "closure")
```

### 7.4.2. 클로저 표현식과 경량 문법

클로저 축약해가는 과정 예시

```swift
var value = [1, 9, 5, 7, 3, 2]

value.sort(by: {
    (s1: Int, s2: Int) -> Bool in
    if s1 > s2 {
        return true
    } else {
        return false
    }
})

value.sort(by: {(s1: Int, s2: Int) -> Bool in return s1 > s2})
value.sort(by: { s1, s2 in return s1 > s2 })
value.sort(by: { $0 > $1 })
value.sort(by: > ) // 연산자 함수(Operator Functions)
```

### 7.4.3. 트레일링 클로저(Trailing Closure)

클로저를 인자값으로 주고 받을 때, 클로저 형식을 따라 코딩하다보면 알아보기 힘든 코드가 생길 수있음.

트레일링 클로저

- 인자값으로 클로저를 전달하는 특수한 상황에서 문법을 변형할 수 있도록 해줌
- 함수의 마지막 값이 클로저일때 인자값 형식 대신 함수의 뒤에 꼬리처럼 붙일 수 있는 문법
- 인자의 레이블은 생략됨

앞의 함수를 트레일링 클로저로 변환한 예시

```swift
value.sort() { (s1, s2) in
    return s1 > s2
}

// 더 축약한 코드
value.sort { (s1, s2) in
    return s1 > s2
}
```

- 마지막 값이 클로저일 때만 사용 가능
- 마지막 두개의 값이 연이어 클로저라 해도 마지막 클로저에만 트레일링 클로저 적용 가능

### 7.4.4. @escaping과 @autoescape

클로저 사용시 주의사항

- 함수의 인자값으로 전달된 클로저는 기본적으로 탈출 불가(non-escape) 성격
- 해당 클로저는 1)함수 내에서 2)직접 실행을 위해서만 사용할 수 있음
- 함수 내부라 해도 변수나 상수에 대입 불가(캡처(Capture)를 통한 클로저 노출 방지)
- 중첩된 함수 내부에서도 사용할 수 없음

@escaping 속성

@escaping 속성을 활용하면 위 주의사항을 해제할 수 있음

클로저를 상수에 대입하는 예시

```swift
func callback(fn: @escaping () -> Void) {
    let f = fn // 클로저를 상수 f에 대입
    f()
}

callback {
    print("Exec closure")
}
```

@autoescape

@autoclosure

```swift
func condition(stmt: @autoclosure () -> Bool) {
    if stmt() == true {
        print("결과가 참입니다.")
    } else {
        print("결과가 거짓입니다.")
    }
}
condition(stmt: ( 4 > 2 ))
```

클로저가 아닌 그 안의 내용만으로 인자값을 넣어주면 됨. 이렇게 전달된 인자값은 컴파일러가 자동으로 클로저 형태로 감싸서 처리해줌. 인자값을 중괄호({})가 아니라 괄호(()) 형태로 사용할 수 있도록 해준다.

@autoclosure의 지연된 실행

```swift
var arrs = [String]()

func addVars(fn: @autoclosure () -> Void) {
    arrs = Array(repeating: "", count: 3)
    fn()
}

addVars(fn: arrs.insert("KR", at: 1))
print(arrs) // "["", "KR", "", ""]\n"
```

@autoclosure 속성이 부여된 인자값은 보기엔 일반 구문 형태지만 컴파일러에 의해 클로저, 즉 함수로 감싸지기 때문에 위와 같이 작성해도 addVars(fn:) 함수 실행전까지 실행되지 않는다. 실행 시점에는 이미 배열의 인덱스가 확장된 후이므로 오류도 발생하지 않는다.

지연된 실행

@autoclosure 속성이 인자값에 부여되면 해당 인자값은 컴파일러에 의해 클로저로 자동 래핑된다. 이 때문에 함수를 실행할 때에는 '{}' 형식의 클로저가 아니라 '()' 형식의 일반값을 인자값으로 사용해야 한다. 또한 인자값은 코드에 작성된 시점이 아니라 해당 클로저가 실행되는 시점에 맞춰서 실행된다.
