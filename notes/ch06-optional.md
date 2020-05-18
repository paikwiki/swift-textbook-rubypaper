# Chapter 6. 옵셔널

- 언어 차원에서 프로그램의 안전성을 높이기 위에 사용하는 개념
- nil을 사용할 수 있는 타입과 사용할 수 없는 타입을 구분하고, 사용할 수 있는 타입을 가리켜 옵셔널 타입이라고 함

nil

- 값이 없음을 의미하는 특수한 값
- nil은 값으로 처리할 수 없는, 무엇인가 문제가 발생했을 때 이를 의미하기 위해 사용하기도 함
- "오류가 발생할 가능성"이 있다면 모두 옵셔널 타입으로 정의

```swift
let capital = ["KR": "Seoul", "CN": "Beijing", "JP": "Tokyo"]
capital["ko"] // nil

let num = Int("Swift") // nil
```

- 일반 자료형과 함수의 반환값은 '값이 없음'을 뜻하는 nil 값을 저장할 수 없음
- 함수는 처리 과정에서 실패하면 nil을 반환하는데 일반 자료형에는 nil을 저장할 수 없으므로 오류가 발생함
- 옵셔널 타입으로 선언된 자료형은 nil 값을 저장할 수 있음
- `Int(<바꿀문자열>)`의 반환 타입은 옵셔널 타입으로 정의

옵셔널 타입의 반환 타입

1. nil이 아닌 값
2. nil 값

2번 nil이 아닌 값은 옵셔널이라는 객체로 둘러싸인 상태로 반환

옵셔널 래핑(Optional Wrapping)

- 옵셔널 타입이란 반환하고자 하는 값을 옵셔널 객체로 다시 한 번 감싼 형태
- 옵셔널 언래핑(Optional Unwrapping)을 통해 옵셔널 타입을 해제하고 실제 값을 추출해서 사용해야 함
- 결과가 nil일 경우에는 옵셔널 타입을 해제해선 안됨

## 6.1. 옵셔널 타입 선언과 정의

```swift
// Optional Int type
var optInt : Int?

// Optional String type
var optStr : String?

// Optional Double type
var optDouble : Double?

// Optional Array type
var optArr : [String]?

// Optional Dictionalry type
var optDic : Dictionary<String, String>?
var optDic2 : [String:String]?

// Optional Class type
var optClass : AnyObject?
```

- 옵셔널 타입으로 자료형을 선언하면 자동으로 nil로 초기화
- 값을 대입할 때는 일반 변수처럼 생각하고 다루어도 무방함

## 6.2. 옵셔널 값 처리

```swift
// (x) : 옵셔널 타입은 결합 연산 또는 더하기 연산이 가능한 데이터 타입이 아님
Int("123") + Int("123")

// (x) : Int?와 Int는 서로 다른 타입으므로 연산이 불가능함
Int("123") + 30
```

옵셔널 언래핑(Optional Unwrapping)

- 옵셔널 객체를 해제하고 내부에 있는 값을 추출하는 과정

옵셔널 해제 방법

- 명시적 해제
  - 강제 해제: 옵셔널 타입의 값 뒤에 `!` 기호를 붙여줌
  - 비강제 해제: 옵셔널 바인딩(조건식 대신 옵셔널 값을 일반 변수나 상수에 할당하는 구문을 사용하는 방식)
- 묵시적 해제
  - 컴파일러에 의한 자동 해제
  - !연산자를 사용한 자동 해제

```swift
// 강제해제
var optInt: Int? = 3
print("\(optInt)") // result: Optional(3)
print("\(optInt!)") // result: 3
```

아래의 경우 옵셔널 값이 nil이면 `!`연산자 때문에 오류 발생

```swift
Int("swift")! + 30 // 오류
```

옵셔널 변수/상수를 안전하게 사용하려면 옵셔널 값이 nil인지 확인해야 함

### 6.2.1. 옵셔널 강제 해제

```swift
var str = "Swift"
var intFromStr = Int(str)

if intFromStr != nil {
  print("값이 변환됐습니다. 변환된 값은 \(intFromStr!)입니다.")
} else {
  print("값 변환에 실패하였습니다")
}
```

### 6.2.2. 옵셔널 바인딩

옵셔널 바인딩(Optional binding)

- 조건식 대신 옵셔널 값을 일반 변수나 상수에 할당하는 구문을 사용하는 방식

```swift
var str = "Swift"

if let intFromStr = Int(str) {
  print("값이 변환됐습니다. 변환된 값은 \(intFromStr)입니다")
} else {
  print("값 변환에 실패했습니다")
}

func intStr(str: String) {

  guard let intFromStr = Int(str) else {
    print("값 변환에 실패했습니다")
    return
  }

  print("값이 변환됐습니다. 변환된 값은 \(intFromStr)입니다")
}
```

### 6.2.3. 컴파일러에 의한 옵셔널 자동 해제

명시적으로 강제 해제를 하지 않아도 컴파일러에서 자동으로 옵셔널을 해제헤 주는 경우

- 옵셔널 객체의 값을 비교 연산자를 사용하여 비교하는 경우, 한쪽이 옵셔널, 다른 한쪽이 일반 타입이라면 자동으로 옵셔널 타입을 해제하여 비교 연산을 수행

```swift
let tempInt = Int("123")

tempInt == 123            // true
tempInt == Optional(123)  // true
tempInt! == 123           // true
tempInt! == Optional(123) // true
```

### 6.2.4. 옵셔널의 묵시적 해제

옵셔널 변수 선언시 `?` 대신 `!`를 사용하면 묵시적 해제를 할 수 있음

```swift
var str: String? = "Swift Optional"
print(str) // result: Optional("Swift Optional")

var str2: String! = "Swift Optional"
print(str) // result: Swift Optional
```

- 변수의 값이 nil이 될 가능성이 있다면 묵시적 옵셔널 해제를 사용하지 않아야 한다.
- 즉, "형식상 옵셔널로 정의해야 하지만, 실제로 사용할 때에는 절대 nil 값이 대입될 가능성이 없는 변수일 때" 사용

예시

```swift
var value: Int! = Int("123")
```

옵셔널 체인(Optional Chain) 예시

```swift
// Objective-C
if (myDelegate != nil) {
  if ([myDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
    [myDelegate scrollViewDidScroll:myScrollView];
  }
}

// Swift
myDelegate?.scrollViewDidScroll?(myScrollView)
```
