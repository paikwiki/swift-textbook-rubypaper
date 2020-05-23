import UIKit
// ======================
// Chapter 9. 열거형과 익스텐션
// ======================

// --------------------------
// 9.1. 열거형
// --------------------------

// 9.1.1. 열거형의 정의

enum Direction {
    case north
    case south
    case east, west
}

let N = Direction.north
let S = Direction.south
let E = Direction.east
let W = Direction.west

//var directionToHead = Direction.west
var directionToHead: Direction = Direction.west
directionToHead = .east

var directionToTail: Direction = .east

switch directionToHead {
case Direction.north :
    print("north")
case Direction.south :
    print("south")
case Direction.east :
    print("east")
case Direction.west :
    print("west")
}
// east

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

// 9.1.2. 멤버와 값의 분리

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

enum Rank: Int {
    case one = 1
    case two, three, four, five
}

Rank.one.rawValue // 1
Rank.two.rawValue // 2
Rank.three.rawValue // 3
Rank.four.rawValue // 4
Rank.five.rawValue // 5

enum ImageFormat {
    case JPEG
    case PNG(Bool)
    case GIF(Int, Bool)
}

var newImage = ImageFormat.PNG(true)
newImage = .GIF(256, false)

// 9.1.3. 열거형의 활용

// --------------------------
// 9.2. 익스텐션
// --------------------------

// 9.2.1. 익스텐션과 연산 프로퍼티

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

// 9.2.2. 익스텐션과 메소드

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
d.repeatRun {
    print("hello2")
}

extension Int {
    mutating func square() {
        self = self * self
    }
}

var value = 3
value.square()
// 9.2.3. 익스텐션을 활용한 코드 정리
