# Chapter 10. 프로토콜

프로토콜(Protocol)

- 클래스나 구조체가 어떤 기준을 만족하거나, 또는 특수한 목적을 달성하기 위해 구현해야 하는 메소드와 프로퍼티의 목록
- 다른 객체지향 언어에서 사용하는 인터페이스와 유사한 개념
- 이벤트의 효율적인 관리를 위해 대리자(delegate)를 지정하여 이벤트 처리를 위임하고, 이벤트 발생시 대리자가 콜백 메소드를 호출해주는 델리게이트 패턴(Delegate Pattern) 구현을 위해서 프로토콜 활용
- 프로토콜을 구현한 오브젝트의 메소드나 속성을 은닉하고, 프로토콜에서 선언한 명세의 내용만 제공하는 기능을 함
- 특정 기능이나 속성에 대한 설계도
- 프로토콜의 "명세": 프로토콜에 선언된 프로퍼티나 메소드의 형식
- 프로토콜의 "구현": 명세에 맞춰 실질적 내용을 작성하는 행위, 프로토콜을 상속받는 구조체나 클래스에서 구현

부모클래스를 상속받아 기능을 구현하는 것은 종적인 개념이라면, 프로토콜은 횡적인 개념이다. 프로토콜은 대상 클래스 전체를 책임지지 않으며, 단지 한 부분 또는 몇 가지 기능의 형식만을 담당한다.

## 10.1. 프로토콜의 정의

프로토콜 정의 형식

```txt
protocol <프로토콜명> {
  <구현해야 할 프로퍼티 명세1>
  <구현해야 할 프로퍼티 명세2>
  <구현해야 할 프로퍼티 명세3>
  ...
  <구현해야 할 메소드 명세1>
  <구현해야 할 메소드 명세2>
  <구현해야 할 메소드 명세3>
  ...
}
```

프로토콜을 구현할 수 있는 구현체 종류

1. 구조체(Structure)
1. 클래스(Class)
1. 열거형(Enumeration)
1. 익스텐션(Extension)

프로토콜 구현 형식

```txt
struct/class/enum/extension 객체명: 구현할 프로토콜명 {

}
```

### 10.1.1. 프로토콜 프로퍼티

프로토콜에 선언되는 프로퍼티에는 초기값을 할당할 수 없다. 연산/저장 프로퍼티의 구분도 하지 않는다.

프로토콜에 선언하는 프로퍼티의 요소

- 프로퍼티의 종류
- 이름
- 변수/상수 구분
- 타입
- 읽기 전용 여부

프로토콜 예시

```swift
protocol SomePropertyProtocol {
  var name: String { get set }
  var description: String { get }
}
```

프로퍼티 명세에는 읽기 전용 여부를 `get`, `set` 키워드로 표시

프로토콜 구현 예시

```swift
struct RubyMember: SomePropertyProtocol {
  var name = "홍길동"
  var description: String {
    return "Name: \(self.name)"
  }
}
```

### 10.1.2. 프로토콜 메소드

프로토콜 메소드 예시

```swift
protocol SomeMethodProtocol {
  func execute(cmd: String)
  func showPort(p: Int) -> String
}
```

프로토콜의 메소드는 실제 실행할 내용을 작성할 수 없기 때문에 중괄호({}) 블록을 붙일 수 없다.

프로토콜 메소드 예시

```swift
protocol SomeMethodProtocol {
  func execute(cmd: String)
  func showPort(p: Int) -> String
}

struct RubyService: SomeMethodProtocol {
  func execute(cmd: String) {
    if cmd == "start" {
      print("실행")
    }
  }

  func showPort(p: Int) -> String {
    return "Port: \(p)"
  }
}
```

프로토콜에 정의된 메소드는 구현체에서도 매개변수명까지 일치해야한다. 하지만 외부매개변수만 일치시키면 되고 내부 매개변수는 변경 가능하다.

```swift
protocol NewMethodProtocol {
    mutating func execute(cmd command: String, desc: String)
    func showPort(p: Int, memo desc: String) -> String
}

struct RubyNewService: NewMethodProtocol {
    func execute(cmd command: String, desc: String) {
        if command == "start" {
            print("\(desc)를 실행")
        }
    }

    func showPort(p: Int, memo desc: String) -> String {
        return "Port : \(p), Memo: \(desc)"
    }
}

struct RubyNewService2: NewMethodProtocol {
    func execute(cmd comm: String, desc d: String) {
        if comm == "start" {
            print("\(d)를 실행")
        }
    }

    func showPort(p: Int, memo description: String) -> String {
        return "Port: \(p), Memo: \(description)"
    }
}
```

프로토콜에서의 `mutating`

- 구조체, 열거형 내의 메소드가 프로퍼티를 변경하는 경우, 메소드 앞에 반드시 `mutating` 키워드를 붙여 프로퍼티 값을 수정하는 메소드임을 표시하도록 강제. 그러므로 구조체 내의 메소드가 프로토콜에서 선언된 메소드라면 반드시 프로토콜에도 `mutating`이 붙어 있어야 함

프로토콜에서 메소드 선언에 `mutating` 키워드가 붙지 않는 경우는 두 가지중 하나로 해석 가능

1. 구조체나 열거형 등 값 타입의 객체에서 내부 프로퍼티의 값을 변경하기를 원치 않을 때
1. 주로 클래스를 대상으로 간주하고 작성된 프로토콜일 때

만약 프로토콜에 `mutating`이 있어도 실제 구현에서 변경이 없다면 `mutating`을 생략해도 오류가 발생하지 않는다.

| 프로토콜 | 구조체   | 결과  |
| -------- | -------- | ----- |
| mutating | mutating | OK    |
| mutating | -        | OK    |
| -        | mutating | ERROR |
| -        | -        | OK    |

클래스는 참조 타입의 객체이므로 메소드 내부에서 프로퍼티를 수정하더라도 `mutating` 키워드가 필요 없다.

타입 메소드나 타입 프로퍼티를 프로토콜에 정의할 때는 프로토콜의 각 선언 앞에 `static` 키워드를 붙인다. 클래스에서 타입 메소드를 선언할 때 사용하는 `class`는 프로토콜에서 사용할 수 없다.

프로토콜에서 static으로 선언했어도 실제 클래스 구현에서는 `static`과 `class` 키워드를 선택해서 사용 가능하다. 단, 구조체나 열거형은 무조건 `static`을 사용해야한다.

```swift
protocol someTypeProperty {
    static var defaultValue: String { get set }
    static func getDefaultValue() -> String
}

struct TypeStruct: someTypeProperty {
    static var defaultValue = "default"

    static func getDefaultValue() -> String {
        return defaultValue
    }
}

class ValueObject: someTypeProperty {
    static var defaultValue = "default"
    class func getDefaultValue() -> String {
        return defaultValue
    }
}
```

### 10.1.3. 프로토콜과 초기화 메소드

프로토콜에서 초기화 메서드 선언 예시

```swift
protocol SomeInitProtocol {
  init()
  init(cmd: String)
}
```

프로토콜의 초기화 메소드 관련 주의사항

- 구현되는 초기화 메소드의 이름과 매개변수명은 프로토콜의 명세에 작성한 것과 완전히 일치해야 함
- 프로토콜 명세에 선언된 초기화 메소드는 그것이 기본 제공되는 초기화 메소드일지라도 직접 구현해야 함
- 클래스에서 초기화 메소드를 구현할 때는 `required` 키워드를 붙여야 함

상속을 통해 초기화 메소드를 물려받았다 할지다로 구현해야할 프로토콜 명세에 동일한 초기화 메소드가 선언되어 있다면 이를 다시 구현해야 함

```swift
protocol Init {
  init()
}

class Parent {
  init() {
  }
}

class Child: Parent, Init {
  override required init() {
  }
}
```

연산 프로퍼티의 경우에는 `override` 키워드만 필요함

```swift
protocol Init2 {
  func getValue()
}

class Parent2 {
  func getValue() {
  }
}

class Child2: Parent2, Init2 {
  override func getValue() {
  }
}
```

상속시 프로토콜의 개수에는 제한이 없다. 선언 순서는 상관 없으나 각 프로토콜에서 구현해야 하는 내용은 모두 구현해야 한다.

## 10.2. 타입으로서의 프로토콜

프로토콜은 자료형으로 사용할 수 있다. 프로토콜을 상위 클래스 타입으로 간주하여 사용할 수 있다.

- 상수나 변수, 그리고 프로퍼티의 타입으로 사용할 수 있음
- 함수, 메소드 혹은 초기화 구문에서 매개변수 타입이나 반환 타입으로 프로토콜을 사용할 수 있음
- 배열이나 사전, 혹은 다른 컨테이너의 타입으로 사용할 수 있음

```swift
protocol Wheel {
  func spin()
  func hold()
}

class Bicycle: Wheel {
  var moveState = false

  func spin() {
    self.pedal()
  }

  func hold() {
    self.pullBreak()
  }

  func pedal() {
    self.moveState = true
  }

  func pullBreak() {
    self.moveState = false
  }
}

let trans = Bicycle()
trans.moveState
trans.pedal()
trans.pullBreak()
trans.spin()
trans.hold()

let trans2: Wheel = Bicycle()
trans2.spin()
trans2.hold()
```

두 개의 프로토콜 타입으로 인스턴스를 할당받는 예시

```swift
protocol A {
  func doA()
}

protocol B {
  func doB()
}

class Impl: A, B {
  func doA() {
  }

  func doB() {
  }

  func desc() -> String {
    return "Class instance method"
  }
}

var ipl: A & B = Impl()
ipl.doA()
ipl.doB()
```

`A & B`는 두 프로토콜을 모두 포함하는 오브젝트 타입이라는 의미다.

## 10.3. 델리게이션

프로토콜 타입으로 선언된 값을 사용한다는 것은, 여기에 할당된 오브젝트가 구체적으로 어떤 기능을 갖추고 있는지는 상관없다는 뜻이다.

델리게이션(Delegation)

- 델리게이트 패턴과 연관되는 아주 중요한 개념
- 특정 기능을 다른 오브젝트에 위임하고, 그에 따라 필요한 시점에서 메소드의 호출만 받는 패턴

델리게이션 예시

```swift
protocol FuelPumpDelegate {
    func lackFuel()
    func fullFuel()
}

class FuelPump {
  var maxGage: Double = 100.0
  var delegate: FuelPumpDelegate? = nil

  var fuelGage: Double {
    didSet {
      if oldValue < 10 {
        self.delegate?.lackFuel()
      } else if oldValue == self.maxGage {
        self.delegate?.fullFuel()
      }
    }
  }

  init(fuelGage: Double = 0) {
    self.fuelGage = fuelGage
  }

  func startPump() {
    while (true) {
      if (self.fuelGage > 0) {
        self.jetFuel()
      } else {
        break
      }
    }
  }

  func jetFuel() {
    self.fuelGage -= 1
  }
}

class Car: FuelPumpDelegate {
  var fuelPump = FuelPump(fuelGage: 100)

  init() {
    self.fuelPump.delegate = self
  }

  func lackFuel() {
  }

  func fullFuel() {
  }

  func start() {
    fuelPump.startPump()
  }
}
```

프로토콜을 사용하여 델리게이션을 구현하는 이유

- 클래스가 단일 상속만을 지원하기 때문
- 구현 개수에 제한이 없는 프로토콜을 이용하여 필요한 기능 단위별 객체를 작성함

## 10.4. 프로토콜의 활용

### 10.4.1. 확장 구문과 프로토콜

익스텐션에서 프로토콜 구현 형식

```txt
extension <기존 객체> : <구현할 프로토콜1>, <구현할 프로토콜2> ... {
  // 프로토콜 요소에 대한 구현 내용
}
```

익스텐션의 프로토콜 적용 예시

```swift
class Woman {
  var name: String?

  init(name: String = "Jane") {
    self.name = name
  }
}

protocol Job {
  func doWork()
}

extension Woman: Job {
  func doWork() {
    print("\(self.name!) works.")
  }
}

let woman = Woman(name: "Dev")
woman.doWork()
```

### 10.4.2. 프로토콜의 상속

프로토콜 상속 예시

```swift
protocol C: A, B {
  func doC()
}

class ABC: C {
  func doA() {
  }
  func doB() {
  }
  func doC() {
  }
}

let abc: C = ABC()
// abc.doA(), abc.doB(), abc.doC()

let a: A = ABC()
// a.doA()

let ab: A & B = ABC()
// ab.doA(), ab.doB()

let abc2: A & B & C = ABC()
// abc2.doA(), abc2.doB(), abc2.doC()

abc is C // true
abc is A & B // true
abc is A // true
abc is B // true
a is C // true
a is B // true
ab is C // true
abc2 is A & B & C // true
```

`as` 연산자는 `is` 연산자와 달리 제한된 범위 내에서 타입을 캐스팅할 수 있도록 해준다. 제한된 범위는 다음과 같다.

1. 실제로 할당된 인스턴스 타입
1. 인스턴스가 구현한 프로토콜 타입
1. 클래스가 상속을 받았을 경우 모든 상위 클래스
1. 프로토콜 타입이 상속을 받았을 경우 모든 상위 프로토콜

상위 타입으로의 캐스팅은 문제가 되지 않으나 하위 타입으로 캐스팅할 경우, 일반 캐스팅 연산자가 아닌 옵셔널 타입으로 캐스팅 결과를 반환하는 옵셔널 캐스팅(`as?`) 연산자나 캐스팅 실패 가능성을 감안하고서라도 일반 타입으로 캐스팅하는 강제 캐스팅(`as!`) 연산자 중에서 선택해야 한다.

```swift
protocol Machine {
  func join()
}

protocol Wheel2: Machine {
  func lotate()

  init(name: String, currentSpeed: Double)
}

class Vehicle2 {
  var currentSpeed = 0.0
  var name = ""

  init(name: String, currentSpeed: Double) {
    self.name = name
    self.currentSpeed = currentSpeed
  }
}

class Car2: Vehicle2, Wheel2 {
  required override init(name: String, currentSpeed: Double = 0.0) {
    super.init(name: name, currentSpeed: currentSpeed)
  }

  func join() {
  }

  func lotate() {
    print("\(self.name)의 바퀴가 회전합니다.")
  }
}

class Carpet: Vehicle2, Machine {
  func join() {
  }
}

var translist = [Vehicle2]()
translist.append(Car2(name: "car", currentSpeed: 10.0))
translist.append(Carpet(name: "carpet", currentSpeed: 15.0))

for trans in translist {
  if let obj = trans as? Wheel2 {
    obj.lotate()
  } else {
    print("\(trans.name)의 하위 타입 변환이 실패했습니다.")
  }
}

// car의 바퀴가 회전합니다.
// carpet의 하위 타입 변환이 실패했습니다.
```

### 10.4.3. 클래스 전용 프로토콜

클래스 전용 프로토콜을 만들 때는 `class` 키워드를 사용한다.

클래스 전용 프로토콜 예시

```swift
protocol SomeClassOnlyProtocol: class {
  // code
}
```

- `mutating` 키워드 사용 불가(클래스에서는 사용할 필요가 없으므로)
- static 키워드는 제약없이 사용 가능

프로토콜이 다른 클래스를 상속받는 예시

```swift
protocol SomeClassOnlyProtocol: class, Wheel, Machine {
  // code
}
```

### 10.4.4. optional

프로토콜 구현시 메소드를 선택적으로 구현할 수 있도록 할 수 있다.

선택적 요청(Optional Requirement)

- 프로토콜의 개별 요소에 `optional`키워드를 사용하여 프로퍼티나 메소드, 초기화 구문 앞에 표시
- 프로토콜 앞에 `@objc` 표시(파운데이션 프레임워크에 정의된 어노테이션의 일종으로 이것이 붙은 코드나 객체를 오브젝티브-C 코드에서도 참조할 수 있도록 노출함을 의미)
- `@objc` 어노테이션이 붙은 프로토콜은 구조체나 열거형 등에서 구현할 수 없음. 클래스만 구현

```swift
import Foundation

@objc protocol MsgDelegate {
  @objc optional func onRecieve(new:Int)
}

class MsgCenter {
  var delegate: MsgDelegate?
  var newMsg: Int = 0

  func msgCheck() {
    if newMsg > 0 {
      self.delegate?.onRecieve?(new: self.newMsg)
      self.newMsg = 0
    }
  }
}

class Watch: MsgDelegate {
  var msgCenter: MsgCenter?

  init(msgCenter: MsgCenter) {
    self.msgCenter = msgCenter
  }

  func onRecieve(new: Int) {
    print("\(new) masseges")
  }
}
```

위에서 메소드의 결과값이 옵셔널이 아니라 메소드 자체가 옵셔널이므로 메소드와 괄호 사이에 `?` 연산자가 필요하다.
