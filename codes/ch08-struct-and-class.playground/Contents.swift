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
            let desc = "이 \(self.name!) 비디오 모드는 \(self.frameRate)의 프레임 비율로 표시됩니다."
            return desc
        } else {
            let desc = "이 비디오 모드는 \(self.frameRate)의 프레임 비율로 표시됩니다."
            return desc
        }
    }
}

var res2 = Resolution2()
res2.width

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

// 8.3.2. 타입 메소드

class Foo2 {
    class func fooTypeMethod() {
        // code..
    }
}

let f = Foo2()
//f.fooTypeMethod() // Error
Foo2.fooTypeMethod()

// ---------
// 8.4. 상속
// ---------

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

// 8.4.1. 서브클래싱

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

// 8.4.2. 오버라이딩

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

class AutomationCar: Car {
    override var currentSpeed: Double {
        didSet {
            self.gear = Int(currentSpeed / 10.0) + 1
        }
    }
} // 이 함수의 동작이 이상함

class Bike: Vehicle {
    override func makeNoise() {
        print("빠밤")
    }
}

let bk = Bike()
bk.makeNoise()

// --------------
// 8.5. 타입 캐스팅
// --------------

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

// 8.5.1. 타입 비교 연산

SUV() is SUV // true
SUV() is Car2 // true
SUV() is Vehicle2 // true

Car2() is Vehicle2 // true
Car2() is SUV // false

let myCar: Vehicle2 = SUV()

if myCar is SUV {
    print("myCar == SUV")
} else {
    print("myCar != SUV")
}

// 8.5.2. 타입 캐스팅 연산

let anyCar: Car2 = SUV()
let anyVehicle = anyCar as Vehicle2

let anySUV = anyCar as? SUV
if anySUV != nil {
    print("\(anySUV!) 캐스팅 성공") // __lldb_expr_75.SUV 캐스팅 성공
}

// 8.5.3. Any, AnyObject

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

// --------------
// 8.6. 초기화 구문
// --------------

// 8.6.1. init 초기화 메소드

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

// 8.6.2. 초기화 구문의 오버라이딩

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

// --------------
// 8.7. 옵셔널 체인
// --------------

// 8.7.1. 옵셔널 타입의 문제점

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

// 8.7.2. 옵셔널 체인

if let name = startup?.ceo?.name {
    print("CEO is \(name)")
}

print(startup?.ceo?.woman) // Optional(false)
