# Chapter 11. 오류 처리

스위프트에서 오류를 처리하는 두 가지 방법

- 옵셔널 이용
- 오류 처리 구문 이용

오류 처리 구문

- 반환값 타입이나 코드의 흐름과 상관없이 오류를 던질 수 있도록 하는 구문
- 객체지향 언어 대다수에서 채택하고 있는 구문 방식

## 11.1. 오류 처리 구문

객체지향 언어들은 오류 발생시 함수나 메소드에서 오류를 '반환(returns)'하는 것이 아니라 '던지는(throws)' 처리를 할 수 있도록 지원한다. 오류를 반환하려면 함수의 반환 타입과 일치해야 하지만, 오류를 던지는 것은 함수의 반환 타입과 일치하지 않아도 된다. 이렇게 하면 함수/메소드의 반환 타입을 건드리지 않고도 효율적으로 오류 정보를 전달할 수 있다.

엄밀히 따지면, 오류 처리(Error Handling)보다는 예외 처리(Exception Handling)라는 이름으로 더 많이 사용되며 오류와 예외는 차이가 있는 개념이지만 편의상 오류로 부르기로 한다.

### 11.1.1. 오류 타입 정의하기

오류 타입으로 사용하는 타입: 열거형

- Error라는 프로토콜을 구현해야함
- Error은 아무 기능도 정의되지 않은 빈 프로토콜
- 프로토콜을 구현했다는 사실 자체가 중요하기 때문에 빈 프로토콜 이용

에러 프로토콜 구현 예시

```swift
enum DateParseError: Error {
  case overSizeString // 입력 데이터의 크기가 필요 크기보다 크다.
  case underSizeString // 입력 데이터의 크기가 필요 크기보다 작다.
  case incorrectFormat(part: String) // 입력 데이터의 형식이 맞지 않다.
  case incorrectData(part: String) // 입력 데이터의 값이 올바르지 않다.
}
```

### 11.1.2. 오류 던지기

오류를 던질 수 있는 함수나 메소드는 오류 객체를 외부로 던질 수 있다는 것을 컴파일러에게 알려주기 위해 정의 구문을 작성할 때 throws 키워드를 추가한다.

정의 구문 예시

```swift
func canThrowErrors() throws -> String
func cannotThrowErrors() -> String
```

클로저에서 오류 객체를 던질 수 있게 하는 예시

```swift
{() throws -> String in
  ...
}
```

오류 던지기 예시

```swift
import Foundation

struct Date {
  var year: Int
  var month: Int
  var date: Int
}

func parseDate(param: NSString) throws -> Date {
  guard param.length == 10 else {
    if param.length > 10 {
      throw DateParseError.overSizeString
    } else {
      throw DateParseError.underSizeString
    }
  }
  var dateResult = Date(year: 0, month: 0, date: 0)

  if let year = Int(param.substring(with: NSRange(location: 0, length: 4))) {
    dateResult.year = year
  } else {
    throw DateParseError.incorrectFormat(part: "year")
  }

  if let month = Int(param.substring(with: NSRange(location: 5, length: 2))) {
    guard month > 0 && month < 13 else {
      throw DateParseError.incorrectData(part: "month")
    }
    dateResult.month = month
  } else {
    throw DateParseError.incorrectFormat(part: "month")
  }

  if let date = Int(param.substring(with: NSRange(location: 8, length: 2))) {
    guard date > 0 && date < 32 else {
      throw DateParseError.incorrectData(part: "date")
    }
    dateResult.date = date
  } else {
    throw DateParseError.incorrectFormat(part: "date")
  }

  return dateResulte
}
```

`parseDate`를 호출할 때는 `try` 키워드를 활용해야 한다.

```swift
try parseDate(param: "2020-02-28")
```

### 11.1.3. 오류 객체 잡아내기

`do` ~ `catch` 형식

```swift
do {
  try <오류를 던질 수 있는 함수>
} catch <오류 타입1> {
  // code
} catch <오류 타입2> {
  // code
} catch <오류 타입3> {
  // code
}
```

예시

```swift
func getPartsDate(date: NSString, type: String) {
  do {
    let date = try parseDate(param: date)

    switch type {
    case "year" :
      print("\(date.year) year")
    case "month" :
      print("\(date.month) month")
    case "date" :
      print("\(date.date) date")
    default :
      print("입력값에 해당하는 날짜 정보가 없습니다.")
    }
  } catch DateParseError.overSizeString {
    print("overSizeString")
  } catch DateParseError.underSizeString {
    print("underSizeString")
  } catch DateParseError.incorrectFormat(let part) {
    print("wrong: \(part)")
  } catch DateParseError.incorrectData(let part) {
    print("wrong: \(part)")
  } catch {
    print("알 수 없는 오류")
  }
}

getPartsDate(date: "2015-12-31", type: "year") // 2015 year
getPartsDate(date: "2015-12-31", type: "month") // 12 month
getPartsDate(date: "2015-13-31", type: "month") // wrong: month
getPartsDate(date: "2015-12-40", type: "date") // wrong: date
```

오류를 일부러 던지지 않게 하고 싶을 때는 `try!` 키워드를 사용한다.

```swift
let date = try! parseDate(param: "2015-09-31")
print("\(date)")
```

안정성 높은 앱을 제작하려면 오류 처리 구문을 적절히 사용하여 예측할 수 있는 오류를 미리 잡아내고, 그에 대한 대응 코드를 작성해두는 과정이 필요하다.
