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

메소드(Method)

- 클래스나 구조체, 열거형과 같은 객체 내에서 함수가 선언될 경우 이를 메소드라고 통칭
- 특정 타입의 객체 내부에서 사용하는 함수
- 함수는 독립적인 기능 구현을 목적으로 하지만 메소드는 하나의 객체 내에 정의된 다른 메소드들과 협력하여 함수적 기능을 수행함

메소드의 종류

- 인스턴스 메소드(Instance Method): 인스턴스를 생성해야 사용할 수 있는 (캡슐화된) 메소드
- 타입 메소드(Type Method)로 구분: 인스턴스를 생성하지 않아도 사용할 수 있는 메소드

클래스의 메소드와 구조체의 메소드는 수정 여부에 대한 몇 가지 항목을 제외하면 비슷한 특징을 가진다.

### 8.3.1. 인스턴스 메소드

인스턴스 메소드(Instance Method)

- 객제의 인스턴스에 대한 기능적 측면을 제공
- 인스턴스 메소드는 객체 내에서 정의된 다른 인스턴스 메소드나 인스턴스 프로퍼티에 접근 가능
- 해당 메소드가 속한 인스턴스를 통해서만 호출할 수 있음(독립적으로 호출 할 수 없음)

```swift
struct Resolution2 {
  var width = 0
  var height = 0

  func desc() -> String {
    let desc = "이 해상도는 가로 \(self.width), 세로 \(self.height)로 구성됩니다."
    return desc
  }
}

class VideoMode2 {
  var resolution = Resolution2()
  var interlaced = 0.0
  var frameRate = 0.0
  var name: String?

  func desc() -> String {
    if self.name != nil {
      let desc = "이 비디오 모드는 \(self.frameRate)의 프레임 비율로 표시됩니다."
      return desc
    }
  }
}
```

`desc()` 함수는 인스턴스 메소드이다. 메소드가 일반 함수와 다른 점

1. 구조체와 클래스의 인스턴스에 소속됨
1. 메소드 내에서 정의된 변수와 상수 뿐만 아니라 클래스 범위에서 정의된 프로퍼티도 모두 참조할 수 있음
1. self 키워드를 사용할 수 있음

```swift
class Counter {
    var count = 0

    func increment() {
        self.count += 1
    }

    func incrementBy(amount: Int) {
        self.count += amount
    }

    func reset() {
        self.count = 0
    }
}

let counter = Counter()
counter.increment() // count 1
counter.incrementBy(amount: 5) // count 6
counter.reset()
```

mutating 키워드

- 구조체나 열거형의 인스턴스 메소드 내부에서 프로퍼티 값을 수정할 때는 반드시 메소드 앞에 `mutating`이라는 키워드를 추가해야 함
- 구조체나 열거형 인스턴스를 상수로 할당받으면 `mutating` 메소드 호출 불가

```swift
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveByX(x deltaX: Double, y deltaY: Double) {
        self.x += deltaX
        self.y += deltaY
    }
}
var point = Point(x: 10.5, y: 12.0)
point.moveByX(x: 3.0, y: 4.5)
print("이제 새로운 좌표는 (\(point.x), \(point.y))입니다.")
```

클래스의 경우에는 `mutating` 키워드를 사용하지 않음

```swift
class Location {
    var x = 0.0, y = 0.0

    func moveByX(x deltaX: Double, y deltaY: Double) {
        self.x += deltaX
        self.y += deltaY
    }
}

var loc = Location()
loc.x = 10.5
loc.y = 12.0
loc.moveByX(x: 3.0, y: 4.5)

print("이제 새로운 좌표는 (\(loc.x), \(loc.y))입니다.")
```

### 8.3.2. 타입 메소드

타입 메소드(Type Method)

- 인스턴스를 생성하지 않고 클래스나 구조체 자체에서 호출할 수 있는 메소드
- 구조체나 열거형 타입에서는 타입 메소드 선언할 때 `static` 키워드 사용
- 하위 클래스에서 재정의 가능한 타입 메소드를 선언할 때는 `class` 키워드 사용

```swift
class Foo2 {
  class func fooTypeMethod() {
    // code..
  }
}

let f = Foo2()
//f.fooTypeMethod() // Error
Foo2.fooTypeMethod()
```

타입 메소드 주의사항

- 타입 메소드는 객체 타입 전체에 영향을 미침
- 타입 메소드로 객체의 값을 변경하면 해당 객체 타입을 사용하는 모든 곳에서 변경이 적용
- 인스턴스 프로퍼티를 참조할 수 없음

## 8.4. 상속

상속(Inheritance)

- 한 클래스가 다른 클래스에서 정의된 프로퍼티나 메소드를 물려받아 사용하는 것

| 구분                                | 명칭1       | 명칭2       | 명칭3       |
| ----------------------------------- | ----------- | ----------- | ----------- |
| 프로퍼티와 메소드를 물려준 클래스   | 부모 클래스 | 상위 클래스 | 슈퍼 클래스 | 기본 클래스 |
| 프로퍼티와 메소드를 물려받은 클래스 | 자식 클래스 | 하위 클래스 | 서브 클래스 | 파생 클래스 |

### 8.4.1. 서브클래싱

서브클래싱(Subclassing)

- 다른 클래스를 상속받아 새로운 클래스를 정의하는 것
- 단일 상속만 지원됨
- 여러 개를 상속받는 것처럼 보이는 경우(코코아 터치 프레임워크에 있음)도 첫번째 요소만 상속이고 나머지는 '구현(Implements)`임

```swift
class <클래스 이름>: <부모 클래스> {
// 추가로 구현할 내용
}
```

서브클래싱 예제

```swift
class A {
  var name = "Class A"

  var description: String {
    return "This class name is \(self.name)."
  }

  func foo() {
    print("\(self.name)'s method foo is called.")
  }
}

let a = A()

a.name // Class A
a.description // Class A's method foo is called.
a.foo()

class B: A {
  var prop = "Class B"

  func boo() -> String {
    return "Class B prop = \(self.prop)"
  }
}

let b = B()
b.prop // Class B
b.boo() // Class B prop = Class B

b.name // Class A
b.foo() // Class A's method foo is called.

b.name = "Class C"
b.foo() // Class C's method foo is called.


class Vehicle {
  var currentSpeed = 0.0

  var description: String {
    return "시간당 \(self.currentSpeed)의 속도로 이동하고 있습니다"
  }

  func makeNoise() {
    //
  }
}

let baseVehicle = Vehicle()
baseVehicle.description // 시간당 0.0의 속도로 이동하고 있습니다

class Bicycle: Vehicle {
  var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 20.0

print("bicycle: \(bicycle.description)") // bicycle: 시간당 20.0의 속도로 이동하고 있습니다

class Tandem: Bicycle {
  var passengers = 0
}

let tandem = Tandem()

tandem.hasBasket = true
tandem.passengers = 2
tandem.currentSpeed = 14.0

print("tandem: \(tandem.description)") // tandem: 시간당 14.0의 속도로 이동하고 있습니다
```

```txt
╭────────────────╮   ╭─────────────╮   ╭──────────────╮
│ Vehicle        │ ▶︎ │ Bicycle     │ ▶︎ │ Tandem       │
╰─┬──────────────╯   ╰─┬───────────╯   ╰─┬────────────╯
  ├ currentSpeed       ╰ hasBasket       ╰ passengers
  ├ description
  ╰ makeNoise()
```

### 8.4.2. 오버라이딩

오버라이딩(Overrriding)

- 서브 클래스에서 재정의된 메소드나 프로퍼티가 부모 클래스로부터 물려받은 내용을 덮어쓰는 과정
- 자기 자신 또는 자신을 서브클래싱한 하위 클래스에만 적용됨
- `override` 키워드 사용
- `override`키워드가 있으면 상위 클래스를 순차적으로 탐색, 요소를 발견하면 오버라이딩하고 없으면 오류를 출력
- 프로퍼티를 오버라이딩 할때는 연산 프로퍼티 형태로 오버라이딩해야 함
- 저장->저장 프로퍼티, 연산->저장 프로퍼티로 오버라이딩은 허용되지 않음
- 연산 프로퍼티로 오버라이딩 하므로 get, set 구문을 모두 제공해야 함

프로퍼티 오버라이딩시 허용되는 것

1. 저장 프로퍼티를 get, set 구문이 있는 연산 프로퍼티로 오버라이딩
1. get, set 구문이 모두 제공되는 연산 프로퍼티를 get, set 구문이 모두 제공되는 연산 프로퍼티로 오버라이딩
1. get 구문만 제공되는 연산 프로퍼티를 get, set 구문이 모두 제공되는 연산 프로퍼티로 오버라이딩
1. get 구문만 제공되는 연산 프로퍼티를 get 구문만 제공되는 연산 프로퍼티로 오버라이딩

프로퍼티 오버라이딩시 허용되지 않는 것

1. 저장 프로퍼티를 저장 프로퍼티로 오버라이딩
1. get, set 구문과 관계없이 연산 프로퍼티를 저장 프로퍼티로 오버라이딩
1. 저장 프로퍼티를 get 구문만 제공되는 연산 프로퍼티(=읽기 전용)로 오버라이딩
1. get, set 구문을 모두 제공하는 연산 프로퍼티를 get 구문만 제공되는 연산 프로퍼티로 오버라이딩

원칙: 프로퍼티 오버라이딩은 상위 클래스의 기능을 하위 클래스가 확장, 또는 변경하는 방식으로 진행되어야하며, 제한하는 방식으로 진행되어서는 안 된다.

```swift
class Car: Vehicle {
  var gear = 0
  var engineLevel = 0

  override var currentSpeed: Double {
    get {
      return Double(self.engineLevel * 50)
    }
    set {
      //
    }
  }
  override var description: String {
    get {
      return "Car: engineLevel=\(self.engineLevel), so currentSpeed=\(self.currentSpeed)"
    }
    set {
      print("New Value is \(newValue)")
    }
  }
}

let c = Car()

c.engineLevel = 5
c.currentSpeed // 250
c.description = "New Class Car" // New Value is New Class Car

print(c.description) // Car: engineLevel=5, so currentSpeed=250.0
```

프로퍼티 오버라이딩 과정에서 필요에 따라 프로퍼티 옵저버를 붙일 수 있다. 부모 클래스에서 프로퍼티가 상수나 읽기전용으로 선언된 게 아니라면 오버라이딩시 프로퍼티 옵저버 구문 추가 가능

```swift
class AutomationCar: Car {
  override var currentSpeed: Double {
    didSet {
      self.gear = Int(currentSpeed / 10.0) + 1
    }
  }
} // 이 함수의 동작이 이상함
```

메소드 오버라이딩

- 반환 타입을 변경할 수 없음

오버로딩(Overloading)

- 같은 메소드 이름이지만 매개변수의 변화만으로 새로운 메소드를 만들어 적재할 수 있도록 지원하는 문법
- 매개변수 타입이나 개수가 달라지면 오버로딩 문법에 의해 새로운 메소드로 인식
- 이 경우 `override` 키워드는 없어야 함

오버라이딩 방지하기

- `final` 키워드 사용

```swift
final class Vehicle {

}
```

## 8.5. 타입 캐스팅

자식 클래스는 본래의 타입 대신 부모 클래스 타입으로 선언하여 사용할 수 있다. 그 반대는 일반적으로 사용할 수 없다.

예시

```swift
class Vehicle2 {
  var currentSpeed = 0.0

  func accelerate() {
    self.currentSpeed += 1
  }
}

class Car2: Vehicle2 {
  var gear: Int {
    return Int(self.currentSpeed / 20) + 1
  }

  func wiper() {
    // wash window
  }
}

let trans: Vehicle = Car()

//let car: Car = Vehicle2() // Error

class SUV: Car2 {
  var fourWhell = false
}

let jeep: Vehicle2 = SUV()

var list = [SUV]()
list.append(SUV())

var list2 = [Vehicle2]()

list2.append(Vehicle2())
list2.append(Car2())
list2.append(SUV())
```

### 8.5.1. 타입 비교 연산

타입 비교 연산자: `is`

```swift
인스턴스(또는 변수, 상수) is 비교대상 타입
```

연산자의 연산 법칙

1. 연산자 왼쪽 인스턴스의 타입이 연산자 오른쪽 비교대상 타입과 일치할 경우: true
1. 연산자 왼쪽 인스턴스의 타입이 연산자 오른쪽 비교대상 타입의 하위 클래스일 경우: true
1. 그 외 - false

```swift
SUV() is SUV // true, warn: 'is' test is always true
SUV() is Car2 // true, warn: 'is' test is always true
SUV() is Vehicle2 // true, warn: 'is' test is always true

Car2() is Vehicle2 // true, warn: 'is' test is always true
Car2() is SUV // false
```

```swift
let myCar: Vehicle2 = SUV()

if myCar is SUV {
  print("myCar == SUV")
} else {
  print("myCar != SUV")
}
// myCar == SUV
```

원래 위의 코드는 false여야 하는데 true 반환됨. 이유는 타입 비교 연산자가 양쪽을 비교할 때 변수의 선언 타입이 아닌 그 안에 대입된 실제 값과 비교하기 때문이다.

타입 비교 연산자를 이용해 타입을 비교할 때는 할당된 변수가 선언된 타입이 아니라 실제 할당된 타입이 비교된다는 것에 주의해야한다.

### 8.5.2. 타입 캐스팅 연산

```swift
let someCar: Vehicle = SUV()
```

위 코드는 SUV 클래스가 할당되어 있으나 컴파일러는 Vehicle 타입으로 간주한다. 그래서 Vehicle 클래스에 선언되지 않은 프로퍼티나 메소드를 사용할 수는 없다.

someCar 상수를 이용하여 SUV() 클래스에 선언된 프로퍼티를 사용하고 싶거나 SUV 타입을 인자값으로 받는 함수에 사용하려면 "형변환"을 해야 한다.

타입 캐스팅은 캐스팅 전 타입과 캐스팅 후 타입의 상하 관계에 따라 업/다운캐스팅으로 분류

업 캐스팅(Up Casting)

- 하위 클래스 타입을 상위 클래스 타입으로 변환할 때
- 캐스팅하기 전 타입이 하위 클래스, 캐스팅한 후 타입이 상위 클래스일 때
- 캐스팅한 결과, 캐스팅하기 전 타입보다 추상화될 때
- 일반적으로 캐스팅 과정에서 오류가 발생할 가능성이 없음

다운 캐스팅(Down Casting)

- 상위 클래스 타입을 하위 클래스 타입으로 캐스팅할 때
- 캐스팅하기 전 타입이 상위 클래스, 캐스팅한 후 타입이 하위 클래스
- 캐스팅한 결과, 캐스팅하기 전 타입보다 구체화될 때
- 캐스팅 과정에서 오류 발생할 가능성이 있음
- 오류에 대한 처리 방식에 따라 옵셔널 캐스팅과 강제 캐스팅으로 나눠짐

업캐스팅은 추상화, 다운캐스팅은 구체화라고 한다. 다운캐스팅 과정에서 오류 발생하면 nil 값을 반환한다. 다운 캐스팅은 이를 고려해 옵셔널 타입을 반환하는 옵셔널 캐스팅과, 반드시 성공한다는 전제로 일반타입을 반환하는 강제 캐스팅으로 나뉨

캐스팅 형식

```swift
// Up casting
객체 as 변환할 타입

// Down casting
객체 as? 변환할 타입(결과는 옵셔널 타입)
객체 as! 변환할 타입(결과는 일반 타입)
```

업 캐스팅 예시

```swift
let anyCar: Car2 = SUV()
let anyVehicle = anyCar as Vehicle2
```

다운 캐스팅 예시

```swift
let anySUV = anyCar as? SUV
if anySUV != nil {
    print("\(anySUV!) 캐스팅 성공") // __lldb_expr_69.SUV 캐스팅 성공
}
```

타입 캐스팅은 앱 제작 과정에서 굉장히 많이 사용한다(Ex. 파운데이션 프레임워크).

### 8.5.3. Any, AnyObject

Any, AnyObject

- 상속 관계에 있지 않은 클래스 간에 타입 캐스팅을 할 수 있는 타입
- 무엇이든 다 받아들일 수 있는 범용 타입
- 가장 추상화된 클래스로 상속 관계가 직접 성립하지는 않으나 가장 상위 클래스라고 할 수 있음
- "어쨌거나 클래스이기만 하면 된다"

```swift
var allCar: AnyObject = Car()
allCar = SUV()

func move(_ param: AnyObject) -> AnyObject {
    return param
}
move(Car())
move(Vehicle())

var list3 = [AnyObject]()
list3.append(Vehicle2())
list3.append(Car2())
list3.append(SUV())

let obj: AnyObject = SUV()

if let suv = obj as? SUV {
    print("\(suv) 캐스팅이 성공하였습니다.") // __lldb_expr_75.SUV 캐스팅이 성공하였습니다.
}
```

```swift
var value: Any = "Sample String"
value = 3
value = false
value = [1, 3, 5, 7, 9]
value = {
    print("함수가 실행됩니다")
}

func name(_ param: Any) {
    print("\(param)")
}
name(3) // Int
name(false) // Bool
name([1,3,5,7,9]) // Array
name {
    print(">>>")
} //(Function)

var rows = [Any]()
rows.append(3)
rows.append(false)
rows.append([1,3,5,7,9])
rows.append {
    print(">>>")
}
```

Any 특징

- 극단적으로 추상화된 타입이어서, Any 타입에 할당된 객체가 사용할수 있는 프로퍼티나 메소드는 아예 제공되지 않음
- Any라는 타입으로 정의하면 모든 값을 제한 없이 할당할 수 있으나 값을 이용해 할 수 있는 것은 거의 없음
- 정적인 타입을 동적인 타입으로 바꾸는 결과를 초래함
- 컴파일러가 오류를 잘 잡아내지 못함

## 8.6. 초기화 구문

초기화

- 인스턴스를 생성해서 메모리 공간을 할당받는 과정
- 모든 저장 프로퍼티는 인스턴스 생성 과정에서 초기화되어야 하며 이를 위해 초기값이 지정돼야 함

구조체의 멤버와이즈 초기화 구문

- 구조체 내부에 선언된 모든 저장 프로퍼티를 일괄로 외부의 값으로 초기활할 수 있는 구문
- 클래스에는 멤버와이즈 초기화 구문이 제공되지 않음

클래스의 초기화

- 외부에서 프로퍼티의 초기값을 지정하려면 형식과 내용을 직접 정의해서 사용해야 함
- 초기화 메소드(생성자(Constructor)) 필요

### 8.6.1. init 초기화 메소드

초기화 메소드 형식

```swift
init(<매개변수>: <타입>, <매개변수> : <타입>, ...) {
  // 매개변수 초기화
  // 인스턴스 생성시 처리할 내용
}
```

스위프트 초기화 메소드의 특성

1. 초기화 메소드의 이름은 `init`으로 통일
1. 매개변수의 개수, 이름, 타입은 임의로 정의할 수 있다.
1. 매개변수의 이름과 개수, 타입이 서로 다른 여러 개의 초기화 메소드를 정의할 수 있다(오버로딩 가능).
1. 정의된 초기화 메소드는 직접 호출되기도 하지만 대부분 인스턴스 생성시 간접 호출된다.

```swift
struct Resolution3 {
  var width = 0
  var height = 0

  init(width: Int) {
    self.width = width
  }
}

class VideoMode3 {
  var resolution = Resolution(width: 2048)
  var interlaced = false
  var frameRate = 0.0
  var name: String?

  init(interlaced: Bool, frameRate: Double) {
    self.interlaced = interlaced
    self.frameRate = frameRate
  }
}

let resolution = Resolution3.init(width: 4096)
let videoMode = VideoMode3.init(interlaced: true, frameRate: 40.0)
```

init 메소드에 기본 매개변수값 지정

```swift
class VideoMode {
  var name: String?

  init(name: String = "") {
    self.name = name
  }
}
```

### 8.6.2. 초기화 구문의 오버라이딩

`super.init` 구문

- 부모 클래스의 기본 초기화 구문에서 프로퍼티를 초기화 했을 경우 자식 클래스에서 기본 초기화 구문을 오버라이딩함으로써 부모 클래스 프로퍼티의 초기화 누락 방지
- 오버라이딩된 초기화 구문 내부에 `super.init` 작성

```swift
class Base {
  var baseValue: Double
  init(inputValue: Double) {
    self.baseValue = inputValue
  }
}

class ExBase: Base {
  override init(inputValue: Double) {
    super.init(inputValue: 10.5)
  }
}
```

초기화 구문 델리게이션(Initializer Delegation)

- 연쇄적으로 오버라이딩된 자식 클래스의 초기화 구문에서 부모 클래스의 초기화 구문에 대한 호출이 발생하는 것
- 기본 초기화 구문을 제외한 나머지 초기화 구문을 오버라이딩 할 때는 반드시 부모 클래스의 초기화 구문을 호출해서 델리게이션 처리를 해줘야 함

부모 클래스에 기본 초기화 구문만 정의되어 있거나, 아예 명시적으로 정의되지 않은 상태에서 자식 클래스가 오버라이딩 할때는 `super.init()` 구문을 호출하지 않아도 호출된다. 이때는 자식클래스부터 역순으로 초기화 구문이 실행된다.

## 8.7. 옵셔널 체인

### 8.7.1. 옵셔널 타입의 문제점

값을 쓰려면 옵셔널 체크를 계속 해야한다.

예시

```swift
struct Human {
  var name: String?
  var woman: Bool = true
}

var girl: Human? = Human(name: "Jane", woman: true)

if girl != nil {
  if girl!.name != nil {
    print("name is \(girl!.name!)") // name is Jane
  }
}

if let g = girl {
  if let name = g.name {
    print("name is \(name)") // name is Jane
  }
}

struct Company {
  var ceo: Human?
  var companyName: String?
}
var startup: Company? = Company(ceo: Human(name: "나대표", woman: false), companyName: "루비페이퍼")

if let company = startup {
  if let ceo = company.ceo {
    if let name = ceo.name {
      print("CEO is \(name)")
    }
  }
}
```

### 8.7.2. 옵셔널 체인

옵셔널 체인(Optional Chain)

- 옵셔널 타입으로 정의된 값이 하위 프로퍼티나 메소드를 가지고 있을 때, 이 요소들을 if 구문을 쓰지 않고도 간결하게 사용할 수 있는 코드를 작성하기 위해 도입
- 객체가 nil인 상황에서 안전성 검사를 하지 않고 메소드나 프로퍼티를 호출하더라도 오류가 발생하지 않을 수 있는 문법을 옵셔널 스타일을 이용하여 구현

옵셔널 타입의 startup 변수 하위의 ceo 프로퍼티를 참조하는 코드

```swift
startup?.ceo
```

이름을 참조하려면?

```swift
startup?.ceo?.name
```

```swift
if let name = startup?.ceo?.name {
    print("CEO is \(name)")
}
```

옵셔널 체인의 특징

1. 옵셔널 체인으로 참조된 값은 무조건 옵셔널 타입으로 반환된다.
1. 옵셔널 체인 과정에서 옵셔널 타입들이 여러번 겹쳐 있더라도 중첩되지 않고 한 번만 처리된다.

```swift
print(startup?.ceo?.woman) // Optional(false)
```

옵셔널 체인으로 여러번 반복된다 해도 결과는 하나의 옵셔널 객체로만 반환

- 옵셔널 체인 구문: `someCompany?.getCEO()?.name`
- 옵셔널 강제 해제: `someCompany!.getCEO()!.name`

모양은 비슷하지만, 강제 해제 연산자의 결과는 일반 타입이다. 옵셔널 체인은 nil이어도 오류가 발생하지 않지만, 옵셔널 강제 해제를 사용하면 nil일 경우 런타임 오류가 발생한다.
