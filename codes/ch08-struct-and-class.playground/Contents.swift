import UIKit
// ======================
// Chapter 8. 구조체와 클래스
// ======================

// --------------------------
// 8.1. 구조체와 클래스의 기본 개념
// --------------------------

// 8.1.1. 정의 구문

// 8.1.2. 메소드와 프로퍼티

struct Resolution {
    var width = 0
    var height = 0
    
    func desc() -> String {
        return "Resolution Struct"
    }
}

class VideoMode {
    var interlaced = false
    var frameRate = 0.0
    var name : String?
    
    var res = Resolution()
    
    func desc() -> String {
        return "VideoMode Class"
    }
}

// 8.1.3. 인스턴스

let insRes = Resolution()
let insVMode = VideoMode()

let width = insRes.width
print("insRes 인스턴스의 width 값은 \(width)입니다.")

let vMode = VideoMode()
print("vMode 의 width 값은 \(vMode.res.width)입니다.")

vMode.name = "Sample"
vMode.res.width = 1280

print("\(vMode.name!) 인스턴스의 width 값은 \(vMode.res.width)입니다.")

// 8.1.4. 초기화

let defaultRes = Resolution(width: 1024, height: 768)

// 8.1.5. 구조체의 값 전달 방식 : 복사에 의한 전달

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd

cinema.width = 2048
print("cinema 인스턴스의 width 값은 \(cinema.width)입니다.")
print("hd 인스턴스의 width 값은 \(hd.width)입니다.")

//hd.width = 4096 Cannot assign to property: 'hd' is a 'let' constant

// 8.1.6. 클래스의 값 전달 방식 : 참조에 의한 전달

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

let vs = VideoMode()
let ds = VideoMode()

if (vs === ds) {
    print("vs === ds")
} else {
    print("vs !== ds")
}
// vs !== ds

// ------------
// 8.2. 프로퍼티
// ------------

// 8.2.1. 저장 프로퍼티

class User {
    var name: String
    
    init() {
        self.name = ""
    }
}

struct FixedLengthRange {
    var startValue: Int
    let length: Int
}

struct FlexibleLengthRange {
    let startValue: Int
    var length: Int
}

var rangeOfFixedIntegers = FixedLengthRange(startValue: 0, length: 3)

rangeOfFixedIntegers.startValue = 4

var rangeOfFlexibleIntegers = FlexibleLengthRange(startValue: 0, length: 3)

rangeOfFlexibleIntegers.length = 5

var variablesOfInstance = FixedLengthRange(startValue: 3, length: 4)

variablesOfInstance.startValue = 0

let constantsOfInstance = FixedLengthRange(startValue: 3, length: 4)

//constantsOfInstance.startValue = 0 // Cannot assign to property: 'constantsOfInstance' is a 'let' constant

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

class PropertyInit {
    
    var value01: String! = {
        print("value01 execute")
        return "Value01"
    }()
    
    let value02: String! = {
        print("value02 execute")
        return "value02"
    }()
    
    lazy var value03: String! = {
        print("value03 execute")
        return "value03"
    }()
}

let s = PropertyInit() // "value01 execute\nvalue02 execute"
s.value01
s.value02
s.value03

// 8.2.2. 연산 프로퍼티

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

// 8.2.3. 프로퍼티 옵저버

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

// 8.2.4. 타입 프로퍼티

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

// ----------
// 8.3. 메소드
// ----------

// 8.3.1. 인스턴스 메소드

// 8.3.2. 타입 메소드

// ---------
// 8.4. 상속
// ---------

// 8.4.1. 서브클래싱

// 8.4.2. 오버라이딩

// --------------
// 8.5. 타입 캐스팅
// --------------

// 8.5.1. 타입 비교 연산

// 8.5.2. 타입 캐스팅 연산

// 8.5.3. Any, AnyObject

// --------------
// 8.6. 초기화 구문
// --------------

// 8.6.1. init 초기화 메소드

// 8.6.2. 초기화 구문의 오버라이딩

// --------------
// 8.7. 옵셔널 체인
// --------------

// 8.7.1. 옵셔널 타입의 문제점

// 8.7.2. 옵셔널 체인

