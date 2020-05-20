import UIKit

// 7.1.2. 함수의 호출

func incrementBy(amount: Int, numberOfTimes: Int) -> Int {
    var count = 0
    count = amount * numberOfTimes
    return count
}

incrementBy(amount: 1, numberOfTimes: 3)

func times(x: Int, y: Int) -> Int {
    return (x * y)
}

times(x: 5, y: 10) // 함수의 이름만으로 호출
times(x:y:)(5, 10) // 함수의 식별자를 사용하여 호출

// 7.1.3. 함수의 반환값과 튜플

func getIndividualInformation() -> (Int, String) {
    let height = 180
    let name = "꼼꼼한 재은씨"
    
    return (height, name)
}

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

// 7.2.1. 내부 매개변수명, 외부 매개변수명

func printHello(to name: String, welcomeMessage msg: String) {
    print("\(msg), \(name)")
}

printHello(to: "홍길동", welcomeMessage: "안녕하세요") // "안녕하세요, 홍길동\n"

// 7.2.2. 가변인자

func avg(score: Int...) -> Double {
    var total = 0
    for r in score {
        total += r
    }
    return (Double(total) / Double(score.count))
}

print(avg(score: 10,20,30,40)) // "25.0n\"

// 7.2.3. 기본값을 갖는 매개변수

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

// 7.2.4. 매개변수의 수정

//func incrementBy2(base: Int) -> Int {
//    base += 1 // Left side of mutating operator isn't mutable: 'base' is a 'let' constant
//    return base
//}

func incrementBy2(base: Int) -> Int {
    var base = base
    base += 1
    return base
}

func descAge(name: String, _ paramAge: Int) -> String {
    var name = name
    var paramAge = paramAge
    
    name = name + "씨"
    paramAge += 1
    return "\(name)의 내년 나이는 \(paramAge)세입니다."
}

descAge(name: "Tom", 20)

// 7.2.5. InOut 매개변수

func foo(paramCount: inout Int) -> Int {
    paramCount += 1
    return paramCount
}

var count = 30
print(foo(paramCount: &count))
print(count)

// 7.3.1. 일급 함수의 특성

func boo(age: Int, name: String) -> String {
    return "\(name), \(age)"
}

func boo(height: Int, nick: String) -> String {
    return "\(nick), \(height)"
}

let fn03 = boo(age:name:)
let fn04 = boo(height:nick:)

func desc() -> String {
    return "this is desc()"
}

func pass() -> () -> String {
    return desc
}

let p = pass()
p() // "this is desc()"

func incr(param: Int) -> Int {
    return param + 1
}

func broker(base: Int, function fn: (Int) -> Int) -> Int {
    return fn(base)
}

broker(base: 3, function: incr) // 4

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

divide(base: 30,
       succes: {
        () -> Void in
        print("Success")
},
       fail: {
        () -> Void in
        print("Fail")
})

// 7.3.2. 함수의 중첩

func outer(base: Int) -> String {
    func inner(inc: Int) -> String {
        return "\(inc)를 반환합니다"
    }
    let result = inner(inc: base + 1)
    return result
}
outer(base: 3) // "4를 반환합니다"

// 7.4.1. 클로저 표현식

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

var value = [1, 9, 5, 7, 3, 2]

func order(s1: Int, s2: Int) -> Bool {
    if s1 > s2 {
        return true
    } else {
        return false
    }
}

//value.sort(by: order)
//
//value.sort(by: {
//    (s1: Int, s2: Int) -> Bool in
//    if s1 > s2 {
//        return true
//    } else {
//        return false
//    }
//})

//value.sort(by: {(s1: Int, s2: Int) -> Bool in return s1 > s2})
//value.sort(by: { s1, s2 in return s1 > s2 })
//value.sort(by: { $0 > $1 })
//value.sort(by: > )

// 7.4.3. 트레일링 클로저(Trailing Closure)

//value.sort() { (s1, s2) in
//    return s1 > s2
//}

value.sort { (s1, s2) in
    return s1 > s2
}

// 7.4.4. @escaping과 @autoescape

func callback(fn: @escaping () -> Void) {
    let f = fn // 클로저를 상수 f에 대입
    f()
}

callback {
    print("Exec closure")
}

func condition(stmt: @autoclosure () -> Bool) {
    if stmt() == true {
        print("결과가 참입니다.")
    } else {
        print("결과가 거짓입니다.")
    }
}
condition(stmt: ( 4 > 2 ))

var arrs = [String]()

func addVars(fn: @autoclosure () -> Void) {
    arrs = Array(repeating: "", count: 3)
    fn()
}

addVars(fn: arrs.insert("KR", at: 1))
print(arrs) // "["", "KR", "", ""]\n"
