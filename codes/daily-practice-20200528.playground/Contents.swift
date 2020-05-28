import UIKit

var str = "Swift"
var intFromStr = Int(str)

if intFromStr != nil {
  print("값이 변환됐습니다. 변환된 값은 \(intFromStr!)입니다.")
} else {
  print("값 변환에 실패하였습니다")
}

func intStr(str: String) {

  guard let intFromStr = Int(str) else {
    print("값 변환에 실패했습니다")
    return
  }

  print("값이 변환됐습니다. 변환된 값은 \(intFromStr)입니다")
}

intStr(str: str)

typealias infoResult = (Int, Character, String)

func getUserInformation3() -> infoResult {
    let type: Character = "A"
    let height = 180
    let name = "꼼꼼한 재은씨"
    
    return (height, type, name)
}

var uInfo3 = getUserInformation3()
uInfo3.0
uInfo3.1
uInfo3.2

func foo(paramCount: inout Int) -> Int {
    paramCount += 1
    return paramCount
}

var count = 30
print(foo(paramCount: &count))
print(count)
