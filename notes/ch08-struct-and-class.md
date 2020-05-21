# Chapter 8. 구조체와 클래스

## 8.1. 구조체와 클래스의 기본 개념

### 8.1.1. 정의 구문

```swift
// 구조체
struct 구조체_이름 {
  // code..
}

// 클래스
class 클래스_이름 {
  // code..
}
```

구조체/클래스 이름짓기

- 첫글자는 대문자로, 나머지는 소문자로 작성
- 축약된 약어는 전부 대문자로 작성가능
- 카멜(Camel) 표기법
- 언더바(\_)로 단어를 연결하는 방식은 사용하지 않는 게 좋음
- 프로퍼티나 메소드 선언에는 소문자로 시작

### 8.1.2. 메소드와 프로퍼티

- 프로퍼티(Property, 속성): 구조체와 클래스 내부에서 정의된 변수나 상수
- 메소드(Method): 구조체와 클래스 내부에서 정의한 함수

### 8.1.3. 인스턴스

구조체나 클래스는 객체의 정의일뿐 실제로 값을 저장하고 메소드를 호출하는 데 필요한 메모리 공간을 할당받지 못한 상태이다. 실질적인 값을 저장하고 사용하려면 메모리 공간을 할당받은 객체가 필요하다.

구조체나 클래스는 일종의 틀, 원형(Origin)이다. 클래스나 구조체를 정의한 후, 이를 바탕으로 실질적인 값을 담을 여러 개의 그릇을 만들어내는 것이 객체 지향 프로그래밍의 원리이다.

인스턴스(Instance)

- 원형 틀을 이용해 찍어낸 그릇
- 타입의 설계도를 사용하여 메모리 공간을 할당받은 것

인스턴스 접근

```swift
<인스턴스 이름>.<프로퍼티 이름>
```

서브 프로퍼티 접근

```swift
<인스턴스 이름>.<프로퍼티 이름>.<프로퍼티의 서브 프로퍼티 이름> // 체인 방식의 접근
```

### 8.1.4. 초기화

스위프트에서 옵셔널 타입으로 선언되지 않은 모든 프로퍼티는 명시적으로 초기화해 주어야 한다. 프로퍼티가 없을 경우 컴파일 오류 발생

명시적 초기화

1. 프로퍼티를 선언하면서 동시에 초기값을 지정
1. 초기화 메소드 내에서 프로퍼티의 초기값 지정

클래스나 구조체의 모든 프로퍼티는 적어도 인스턴스가 생성되는 시점까지는 반드시 초기화돼야 한다. 둘다 불가능할 경우 옵셔널 타입으로 선언한다.

구조체는 프로퍼티를 멤버변수라고 부르므로 초기화 구문도 멤버와이즈 초기화 구문(Memberwise Initializer)라고 부르기도 한다.

```swift
let defaultRes = Resolution(width: 1024, height: 768)
```

클래스는 멤버와이즈 형식의 초기화 구문이 제공되지 않음. 클래스는 빈 괄호 형태의 기본 초기화만 제공한다. 초기화되지 않은 프로퍼티가 있으면 기본 초기화 구문 사용이 불가하며, 직접 초기화 구문을 정의해서 내부에서 해당 프로퍼티를 초기화 해야한다.

클래스의 프로퍼티와 초기화 구문에 대한 원칙

1. 모든 프로퍼티는 정의할 때 초기값을 주던가, 아니면 옵셔널 타입으로 선언한다.
2. 인스턴스를 생성할 때에는 클래스명 뒤에 ()를 붙여준다.

익숙해질 때까지는 위 두 가지 원칙을 지킨다.

### 8.1.5. 구조체의 값 전달 방식 : 복사에 의한 전달

값 타입(Value Type) 또는 복사에 의한 전달

- 구조체는 인스턴스를 생성한 후, 이를 변수나 상수에 할당하거나 함수의 인자값으로 전달할 때 값을 복사하여 전달함
- 정수, 문자열, 배열, 딕셔너리 등 기본 자료형은 모두 복사를 통해 값 전달 -> 자료형이 구조체로 구현됐기 때문
- 모든 구조체와 열거형은 값 타입
- 모든 구조체 인스턴스는 상수나 변수에 할당될 때 복사된다는 의미

구조체 인스턴스가 상수에 할당되면 프로퍼티 값을 변경할 수 없다. 값을 변경하려면 인스턴스를 변수에 할당해야 한다.

### 8.1.6. 클래스의 값 전달 방식 : 참조에 의한 전달

참조 타입(Reference Type) 또는 참조에 의한 전달

- 클래스는 메모리 주소 참조에 의한 전달 방식을 사용
- 변수나 상수에 할당될 때, 또는 함수의 인자값으로 전달될 때 값의 복사가 이루어지지 않음
- 현재 존재하는 인스턴스에 대한 참조가 전달

참조: 인스턴스가 저장된 메모리 주소 정보가 전달됨

스위프트에서는 포인터를 사용하여 객체와 메모리 주소를 구분하는 대신, 클래스 타입일 경우 항상 메모리 주소를 사용하여 객체 자체를 전달한다.

메모리 해제

- 클래스 인스턴스는 여러 곳에서 동시에 참조가 가능하므로 마음대로 메모리에서 해제할 수 없음
- 구조체 인스턴스는 단일 참조가 보장되므로 변수나 상수의 사용이 끝나면 곧바로 메모리에서 해제해도 됨

ARC(Auto Reference Counter)

- 현재 클래스 인스턴스를 참조하는 곳이 몇 군데인지를 자동으로 카운트 해주는 객체

클래스 비교

- 클래스 인스턴스에서 단순한 값 비교는 불가능
- 두 대상이 같은 메모리 공간을 참조하는 인스턴스인지 여부를 비교
- 동일 인스턴스인지 비교할 때: `===`
- 동일 인스턴스가 아닌지 비교할 때: `!==`

```swift
let video = VideoMode()
video.name = "Original Video Instance"

print("video 인스턴스의 name 값은 \(video.name!)입니다.")

let dvd = video
dvd.name = "DVD Video Instance"
print("video 인스턴스의 name 값은 \(video.name!)입니다.")

func changeName(v: VideoMode) {
    v.name = "Function Video Instance"
}

changeName(v: video)
print("video 인스턴스의 name 값은 \(video.name!)입니다.")


if (video === dvd) {
    print("video === dvd")
} else {
    print("video !== dvd")
}
// video === dvd
```

서로 다른 인스턴스일 경우

```swift
let vs = VideoMode()
let ds = VideoMode()

if (vs === ds) {
    print("vs === ds")
} else {
    print("vs !== ds")
}
// vs !== ds
```

클래스 인스턴스의 비교구문은 값의 비교가 아닌 메모리 주소의 일치 여부(객체의 동일성 여부)에 근거한다.

구조체와 클래스를 선택하는 지침: 아래 조건 중 하나 이상 해당하면 구조체가 좋음

1. 서로 연관된 몇 개의 기본 데이터 타입들을 캡슐화 하여 묶는 것이 목적일 때
1. 캡슐화된 데이터 상속이 필요하지 않을 때
1. 캔슐화된 데이터를 전달하거 할당하는 과정에서 참조 방식보다는 값이 복사되는 것이 합리적일 때
1. 캡슐화된 원본 데이터를 보존해야 할 때

위 경우를 제외하면 구조체보다 클래스를 사용하는 게 좋다. 메모리 절약, 인스턴스 증가 방지 -> 대부분의 객체가 구조체가 아닌 클래스로 작성되는 이유

## 8.2. 프로퍼티

역할에 따른 프로퍼티의 종류

- 저장 프로퍼티(stored property)
- 연산 프로퍼티(Computed property)

저장 프로퍼티

- 입력된 값을 저장하거나 저장된 값을 제공
- 상수 및 변수를 사용해서 정의 가능
- 클래스와 구조체에서 사용 가능, 열거형에서는 사용 못함

연산 프로퍼티

- 특정 연산을 통해 값을 만들어 제공
- 변수만 사용해서 정의 가능
- 클래스, 구조체, 열거형 모두 사용 가능

소속에 따른 프로퍼티의 종류

- 인스턴스 프로퍼티(Instance property)
- 타입 프로퍼티(Type property)

인스턴스 프로퍼티

- 저장/연산 프로퍼티는 개별 인스턴스에 소속되어 역할을 수행
- 인스턴스를 생성한 후 프로퍼티를 참조하거나 값을 할당해야하는 프로퍼티

타입 프로퍼티

- 클래스와 구조체 자체에 소속되어 값을 가짐

프로퍼티 작성 위치

- 클래스 정의 구문 내부
- 메소드 내부에 작성하면 안됨(이럴 경우 지역변수가 됨)
- 클래스의 내부에, 메소드의 외부에 작성

프로퍼티 옵저버(Property Observer)

- 프로퍼티 값을 모니터링하기 위해 정의
- 사용자가 정의한 특정 액션과 반응하도록 처리
- 직접 정의한 저장 프로퍼티와 슈퍼 클래스로부터 상속받은 서브클래스에서 추가 가능

### 8.2.1. 저장 프로퍼티

- 클래스 내에서 선언된 변수나 상수
- 프로퍼티 선언시 초기값이 할당되지 않은 저장프로퍼티는 옵셔널 타입으로 선언해야 함
- 클래스의 프로퍼티 값이 비어있으면 인스턴스 생성시 nil로 초기화되기 때문

옵셔널 타입 프로퍼티 선언시 일반 옵셔널 타입과 묵시적 옵셔널 해제 타입 중 선택 정의 가능하다.

초기화 구문

```swift
class User {
  var name: String

  init() {
    self.name = ""
  }
}
```

초기화 구문에서 멤버 변수를 참조할 땐 `self` 키워드를 붙여준다. 선택적으로 사용되기도 하지만 멤버 변수나 메소드 앞에는 `self`를 붙여서 구분해주는 것을 권장한다.

저장 프로퍼티 종류

- 멤버 변수: var로 정의하는 변수형 저장 프로퍼티
- 멤버 상수: let으로 정의하는 상수형 저장 프로퍼티

구조체 프로퍼티에서 값 변경이 가능하려면 변수에 할당한 인스턴스의 변수 저장 프로퍼티어야만 한다.

지연저장 프로퍼티

- 저장 프로퍼티에 `lazy` 키워드를 붙이면 인스턴스를 생성할 때 초기화 하지 않아도 됨

```swift
class OnCreate {
    init() {
        print("OnCreate!")
    }
}

class LazyTest {
    var base = 0
    lazy var late = OnCreate()

    init() {
        print("Lazy Test")
    }
}

let lz = LazyTest() // Lazy Test
lz.late // OnCreate
```

클로저를 이용한 저장 프로퍼티 초기화

- 연산이나 로직 처리를 통해 얻어진 값을 이용하여 초기화해야하는 경우 사용
- 클로저로 필요한 로직을 실행한 후, 반환되는 값을 이용하여 저장 프로퍼티를 초기화
- 연산 프로퍼티와 유사하지만, 참조될 때마다 매번 값이 재평가되는 연산 프로퍼티와 달리 최초 한 번만 값이 평가됨

```swift
let/var 프로퍼티명: 타입 = {
  정의 내용
  return 반환값
}()
```

```swift
class PropertyInit {
  var value01: String! = {
    print("value01 execute")
    return "Value01"
  }()

  let value02: String! = {
    print("value02 execute")
    return "value02"
  }()
}

let s = PropertyInit() // "value01 execute\nvalue02 execute"
s.value01 // print 실행 안됨
s.value02 // print 실행 안됨
```

세번째 프로퍼티를 `lazy`로 추가.

```swift
class PropertyInit {
  ...
  lazy var value03: String! = {
    print("value03 execute")
    return "value03"
  }()
...
}
let s = PropertyInit() // "value01 execute\nvalue02 execute"
s.value03 // "value03 execute"
```

저장 프로퍼티에 lazy 키워드를 붙여 정의한 저장 프로퍼티를 클로저 구문으로 초기화하면 최초 한 번만 로직이 실행되는 데다 실제로 참조되는 시점에 맞추어 초기화되기 때문에 메모리 낭비를 줄일 수 있어 여러 용도로 활용된다. 특히 서버와의 소켓 통신 채널을 최초 한 번만 연결해 둔 다음 이를 재사용하여 통신하는 경우가 대부분이므로, lazy 프로퍼티를 클로저로 초기화하여 연결 객체를 저장하는 방식이 효율적이다.

### 8.2.2. 연산 프로퍼티

연산 프로퍼티

- 실제 값을 저장했다가 반환하지 않고 다른 프로퍼티의 값을 연산 처리하여 간접적으로 값을 제공
- get 구문을 이용해 프로퍼티의 값을 참조
- 프로퍼티 내부에서 return 키워드를 사용해 값을 반환하며, 이 반환값이 프로퍼티의 값이 됨
- set 구문도 추가 가능
- 연산 프로퍼티는 값을 저장하지 않으므로 set 으로 할당된 값은 연산의 중요한 요소로 사용됨

연산 프로퍼티 정의 형식

```swift
class/struct/enum 객체명 {
  ...
  var 프로퍼티명 : 타입 {
    get {
      필요한 연산 과정
      return 반환값
    }
    set(매개변수명) {
      필요한 연산구문
    }
  }
}
```

연산 프로퍼티 사용 목적

- 다른 프로퍼티에 의존적이거나, 혹은 특정 연산을 통해 얻을 수 있는 값을 정의할 때 사용
- 예: 나이(출생연도에 의존적이며, 현재 연도를 기준으로 하므로 매년 그 값이 달라짐)

```swift
import Foundation

struct UserInfo {
  var birth: Int!

  var thisYear: Int! {
    get {
      let df = DateFormatter()
      df.dateFormat = "yyyy"
      return Int(df.string(from: Date()))
    }
  }
  var age: Int {
    get {
      return (self.thisYear - self.birth) + 1
    }
  }
}

let info = UserInfo(birth: 1980)
print(info.age) // 41
```

연산 프로퍼티 set 예제

```swift
struct Position {
    var x: Double = 0.0
    var y: Double = 0.0
}

struct Size {
    var width: Double = 0.0
    var height: Double = 0.0
}

struct Rect {

  var origin = Position()

  var size = Size()

  var center: Position {
    get {
      let centerX = self.origin.x + (self.size.width / 2)
      let centerY = self.origin.y + (self.size.height / 2)
      return Position(x: centerX, y: centerY)
    }
    set(newCenter) {
      self.origin.x = newCenter.x - (size.width / 2)
      self.origin.y = newCenter.y - (size.height / 2)
    }
  }
}

let p2 = Position(x: 0.0, y: 0.0)
let s2 = Size(width: 10.0, height: 10.0)

var square = Rect(origin: p2, size: s2)
print("square.centerX = \(square.center.x), square.centerY = \(square.center.y)") // square.centerX = 5.0, square.centerY = 5.0
square.center = Position(x: 20.0, y:  20.0)
print("square.centerX = \(square.origin.x), square.centerY = \(square.origin.y)") //square.centerX = 15.0, square.centerY = 15.0
```

### 8.2.3. 프로퍼티 옵저버

프로퍼티 옵저버(Property Observer)

- 특정 프로퍼티를 관찰하다가 값이 변경되면 이를 알아차리고 반응함
- 직접 변경이든 시스템에 의해서든 변경이 이루어지면 무조건 호출
- 같은 값이 재할당 되는 경우에도 호출

프로퍼티 옵저버 종류

- willSet: 프로퍼티의 값이 변경되기 직전에 호출되는 옵저버
- didSet: 프로퍼티의 값이 변경된 직후에 호출되는 옵저버

옵저버 정의 구문

```swift
// willSet
var <프로퍼티평> : <타입> [ = <초기값> ] {
  willSet [ (<인자명>) ] {
    <프로퍼티 값이 변경되기 전에 실행할 내용>
  }
}

// didSet
var <프로퍼티평> : <타입> [ = <초기값> ] {
  didSet [ (<인자명>) ] {
    <프로퍼티 값이 변경된 후에 실행할 내용>
  }
}
```

|         | 예전 값         | 새로운 값       |
| ------- | --------------- | --------------- |
| willSet | 프로퍼티를 참조 | newValue를 참조 |
| didSet  | oldValue를 참조 | 프로퍼티를 참조 |

옵저버 예제

```swift
struct Job {
  var income: Int = 0 {
    willSet(newIncome) {
      print("Salary for this month: \(newIncome).")
    }
    didSet {
      if income > oldValue {
        print("Salary is \(income - oldValue) up.")
      } else {
        print("Salary goes down.")
      }
    }
  }
}

var job = Job(income: 1000000)
job.income = 2000000 // Salary for this month: 2000000.\nSalary is 1000000 up.
job.income = 1500000 // Salary for this month: 1500000. \nSalary goes down.
```

### 8.2.4. 타입 프로퍼티

타입 프로퍼티(Type Property)

- 인스턴스를 생성하지 않고 클래스나 구조체, 또는 열거형과 같은 객체 자체에 관련된 값을 다룸
- 저장된 값은 모든 인스턴스가 공통으로 사용
- 타입 프로퍼티는 인스턴스가 아무리 많아도 모든 인스턴스가 하나의 값을 공용으로 사용
- 타입 프로퍼티로 사용할 프로퍼티 앞에 `static` 키워드를 추가
- 구조체/클래스 상관없이 저장 프로퍼티와 연산 프로퍼티 모두 사용 가능
- 타입 프로퍼티를 정의하는 또다른 키워드인 `class`는 클래스에서 연산 프로퍼티에만 붙일 수 있는 키워드
- `class` 키워드는 구조체나 저장 프로퍼티에는 사용할 수 없음
- `class` 키워드로 상속받은 하위 클래스에서 재정의(Override) 수 있는 타입 프로퍼티가 됨

타입 프로퍼티 정의 형식 (클래스 내에서)

```swift
static let/var 프로퍼티명 = 초기값

// 또는

class let/var 프로퍼티명 : 타입 {
  get {
    return 반환값
  }
  set {
  }
}
```

타입 프로퍼티 예시

```swift
struct Foo {
  static var sFoo = "구조체 타입 프로퍼티값"

  static var cFoo: Int {
    return 1
  }
}

class Boo {
  static var sFoo = "클래스 타입 프로퍼티값"

  static var cFoo: Int {
    return 10
  }

  class var oFoo: Int {
    return 100
  }
}

print(Foo.sFoo) // 구조체 타입 프로퍼티값
Foo.sFoo = "새로운 값"
print(Foo.sFoo) // 새로운 값

print(Boo.sFoo) // 클래스 타입 프로퍼티값
print(Boo.cFoo) // 10
```

## 8.3. 메소드

### 8.3.1. 인스턴스 메소드

### 8.3.2. 타입 메소드

## 8.4. 상속

### 8.4.1. 서브클래싱

### 8.4.2. 오버라이딩

## 8.5. 타입 캐스팅

### 8.5.1. 타입 비교 연산

### 8.5.2. 타입 캐스팅 연산

### 8.5.3. Any, AnyObject

## 8.6. 초기화 구문

### 8.6.1. init 초기화 메소드

### 8.6.2. 초기화 구문의 오버라이딩

## 8.7. 옵셔널 체인

### 8.7.1. 옵셔널 타입의 문제점

### 8.7.2. 옵셔널 체인
