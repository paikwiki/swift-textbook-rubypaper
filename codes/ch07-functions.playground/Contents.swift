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
