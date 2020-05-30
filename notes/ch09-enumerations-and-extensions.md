# Chapter 9. 열거형과 익스텐션

- 열거형(Enumerations): 문자열, 정수값 등을 입력하는 대신 선택할 수 있도록 하여 값의 범위를 제한하고 오류를 방지하여 코드의 안정성을 높여줌
- 익스텐션(Extensions): 오브젝트를 직접 수정하지 않고 기능을 추가하는 방법을 제공. 프레임워크에 의존하는 iOS개발에 있어 제약을 줄이고 생산성을 높여주는 강력한 도구

## 9.1. 열거형

열거형(Enumerations)

- 하나의 주제로 연관된 데이터들이 멤버로 구성돼있는 자료형 오브젝트
- 개별 아이템의 정보를 컴파일러가 인지할 수 없는 다른 자료형과 달리 열거형의 데이터는 열거형 오브젝트를 정의하는 시점에 함께 정의됨
- 따라서 삭제, 변경을 함부로 할 수 없으며, 변경하거나 삭제하려면 오브젝트를 정의하는 구문을 직접 수정해야 함
- 열거형의 데이터 멤버들은 '정의(Definition)' 개념으로 작성되어 타입으로 사용할 수 있고, 컴파일러가 사전에 인지할 수 있음

열거형을 쓰면 좋은 상황

1. 원치 않는 값이 잘못 입력되는 것을 막고 싶을 때
1. 입력받을 값을 미리 특정할 수 있을 때
1. 제한된 값 중에서만 선택할 수 있도록 강제하고 싶을 때

열거형의 멤버로 정의할 수 있는 데이터 집합의 종류

- 연속된 값이 아닌 불연속된 값들(이산 집합)
- 공통 주제에 연관되는 값들
- 종류가 무한하지 않고 몇 가지로 수렴되는 값들

예시

- 성별: 남, 여, 히즈라(hijra, 제3의 성)
- 국가: 한국, 일본, 미국, 중국, 인도, 호주, 캐나다
- 방향: 동, 서, 남 북

### 9.1.1. 열거형의 정의

열거형의 정의 형식

```swift
enum 열거형 이름 {
  case 멤버값 1
  case 멤버갑 2
  case ...
}
```

열거형을 정의할 때는 구조체나 클래스를 정의할 때 적용하는 규칙(카멜 케이스)을 적용한다. 열거형 오브젝트의 멤버명은 반드시 소문자로 해준다.

```swift
enum Direction {
    case north
    case south
    case east, west
}

let N = Direction.north
let S = Direction.south
let E = Direction.east
let W = Direction.west
```

선언과 변경

```swift
//var directionToHead = Direction.west
var directionToHead: Direction = Direction.west
directionToHead = .east
```

타입 어노테이션을 사용하면 멤버값만 전달할 수도 있음

```swift
var directionToHead: Direction = Direction.west
```

switch 구문과 열거형: 간소하게 작성 가능함

```swift
switch directionToHead {
case .north :
    print("north")
case .south :
    print("south")
case .east :
    print("east")
case .west :
    print("west")
}

// east
```

열거형의 모든 멤버를 switch 문에 작성하면 default 구문을 생략할 수 있다.

### 9.1.2. 멤버와 값의 분리

필요한 경우 멤버에 값을 정의할 수 있다. 정의한 값은 `rawValue` 속성으로 접근 가능하다.

```swift
enum HTTPCode: Int {
    case OK = 200
    case NOT_MODIFY = 304
    case INCORRECT_PAGE = 404
    case SERVER_ERROR = 500
}

HTTPCode.OK.rawValue // 200
HTTPCode.NOT_MODIFY.rawValue // 304
HTTPCode.INCORRECT_PAGE.rawValue // 404
HTTPCode.SERVER_ERROR.rawValue // 500
```

타입 어노테이션에 Int를 지정하고, 첫번째 멤버에 값을 주면 나머지 멤버에 대한 값이 자동 할당된다.

```swift
enum Rank: Int {
    case one = 1
    case two, three, four, five
}

Rank.one.rawValue // 1
Rank.two.rawValue // 2
Rank.three.rawValue // 3
Rank.four.rawValue // 4
Rank.five.rawValue // 5
```

연관 값(Associated Values)으로 선언시점에서 멤버와 값을 정의하지 않고 사용 시점에서 보조 값을 설정할 수 있다.

```swift
enum ImageFormat {
    case JPEG
    case PNG(Bool)
    case GIF(Int, Bool)
}

var newImage = ImageFormat.PNG(true)
newImage = .GIF(256, false)
```

열거형은 클래스나 구조체처럼 연산 프로퍼티와 메소드 정의도 가능하다

### 9.1.3. 열거형의 활용

알림창 예시

```swift
let alert = UIAlertController(title: "Alert",
                              message: "알림창",
                              prefferdStyle: .actionSheet)
```

## 9.2. 익스텐션

확장 구문(익스텐션, Extensions)

- 이미 존재하는 클래스나 구조체, 열거형 등 객체에 새로운 기능을 추가하여 확장해주는 구문

익스텐션을 통해 구현할 수 있는 것들

- 새로운 연산 프로퍼티 추가
- 새로운 메소드 정의
- 새로운 초기화 구문 추가
- 기존 오브젝트를 수정하지 않고 프로토콜 구현

형식

```swift
extension <확장할 기존오브젝트 이름> {
  // code
}
```

익스텐션은 오브젝트가 아니며, 타입으로 사용될 수도 없다.

### 9.2.1. 익스텐션과 연산 프로퍼티

기존 객체에 프로퍼티를 추가할 때는 연산 프로퍼티만 추가할 수 있음

```swift
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var description: String {
        return "\(self)km는 \(self.km)m, \(self)cm는 \(self.cm)m, \(self)mm는 \(self.mm)m입니다."
    }
}

2.km // 2000
5.5.cm // 0.055
125.cm // 1.25
7.0.description // 7.0km는 7000.0m, 7.0cm는 0.07m, 7.0mm는 0.007m입니다.

let distance = 42.0.km + 195.m
print("마라톤 총 거리: \(distance)")
// 마라톤 총 거리: 42195.0
```

### 9.2.2. 익스텐션과 메소드

- 기존 오브젝트에 인스턴스 메소드, 타입 메소드 추가 가능
- 매개변수 타입을 달리 해서 오버로딩을 이용, 새로운 메소드 정의 가능
- 매개변수명을 변경하여 새로운 메소드 작성 가능
- 기존 오브젝트에서 사용하는 메소드를 익스텐션에서 재정의 하는 것은 불가능

```swift
extension Int {
    func repeatRun(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

let d = 3
d.repeatRun(task: {
    print("hello")
})
// hello
// hello
// hello
d.repeatRun {
    print("hello2")
}
// hello2
// hello2
// hello2
```

`mutating`을 이용해 인스턴스 자신을 수정하도록 할 수 있다.

```swift
extension Int {
    mutating func square() {
        self = self * self
    }
}

var value = 3
value.square() // value = 9
```

`let`으로 선언하면 상수가 되므로 오류 발생한다.

주의사항

- 남용시 오브젝트의 정의를 모호하게 만들 수 있음
- 실행 위치에 따라 서로 다른 정의로 구성된 오브젝트를 사용하게 될 수 있음
- 정의가 파편화되어 정확한 구성을 파악하기 어려울 수 있음

### 9.2.3. 익스텐션을 활용한 코드 정리

`#pragma mark`

- 오브젝티브-C에서 사용하는 특수한 주석
- 주석 이후에 작성된 코드를 의미적으로 그룹화하여 다른 코드로부터 구분
- Xcode에서 점프 바 혹은 심볼 탐색기를 통해 표시됨
- 코드를 간결하게 정리해주는 문법
- 스위프트에서는 지원하지 않음

익스텐션을 이용해 `#pragma mark`로 하던 작업을 수행할 수 있다. 이때 `MARK` 주석을 사용하면 더 좋다.

```swift
// MARK: 마크 주석 예시
```

MARK 주석

- 스위프트에서 특수용도로 사용되는 주석 기능 중 하나
- 점프 바나 심볼 탐색기에 표시됨
