import UIKit
// ======================
// Chapter 10. 프로토콜
// ======================


// --------------------------
// 10.1. 프로토콜의 정의
// --------------------------

// 10.1.1. 프로토콜 프로퍼티

protocol SomePropertyProtocol {
  var name: String { get set }
  var description: String { get }
}

struct RubyMember: SomePropertyProtocol {
    var name = "홍길동"
    var description: String {
        return "Name: \(self.name)"
    }
}

// 10.1.2. 프로토콜 메소드

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

protocol MService {
    mutating func execute(cmd: String)
    func showPort(p: Int) -> String
}

struct RubyMService: MService {
    var paramCommand: String?
    
    mutating func execute(cmd: String) {
        self.paramCommand = cmd
        if cmd == "start" {
            print("실행합니다.")
        }
    }
    
    func showPort(p: Int) -> String {
        return "Port: \(p), now command: \(self.paramCommand!)"
    }
}

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

// 10.1.3. 프로토콜과 초기화 메소드

protocol SomeInitProtocol {
    init()
    init(cmd: String)
}

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

struct MultImplemet: NewMethodProtocol, SomeInitProtocol {
    var cmd: String
    
    init() {
        self.cmd = "default"
    }
    
    init(cmd: String) {
        self.cmd = cmd
    }
    
    mutating func execute(cmd: String, desc: String) {
        self.cmd = cmd
        if cmd == "start" {
            print("start")
        }
    }
    
    func showPort(p: Int, memo desc: String) -> String {
        return "Port: \(p), Memo: \(desc)"
    }
}

// --------------------------
// 10.2. 타입으로서의 프로토콜
// --------------------------

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
// --------------------------
// 10.3. 델리게이션
// --------------------------

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
// --------------------------
// 10.4. 프로토콜의 활용
// --------------------------

// 10.4.1. 확장 구문과 프로토콜

// 10.4.2. 프로토콜의 상속

// 10.4.3. 클래스 전용 프로토콜

// 10.4.4. optional
