# Chapter 5. 집단 자료형

- Array(배열): 일련번호로 구분되는 순서에 따라 데이터가 정렬된 목록 형태의 자료형
- Set(집합): 중복되지 않은 유일 데이터들이 모인 집합 형태의 자료형
- Tuple(튜플): 종류에 상관없이 데이터들을 모은 자료형. 수정 및 삭제를 할 수 없음
- Dictionary(딕셔너리): 배열과 유사하나 일련번호 대신 키(key)를 사용하며 키-값으로 연관된 데이터들이 순서 없이 모인 자료형

- 튜플을 제외한 나머지는 저장하는 모든 데이터의 타입이 동일해야 함
- 실제 개발시에는 이 데이터 타입뿐 아니라 파운데이션 프레임워크 레벨에서 제공하는 자료형까지 모두 이용할 수 있음

## 배열

- 모든 타입의 아이템을 저장할 수 있지만, 하나의 배열에 저장하는 아이템 타입은 모두 같아야 함
- 선언시 배열에 저장할 아이템 타입을 명시해야 함
- 배열은 동적으로 크기 확장 가능

배열의 개수를 구하는 속성: `.count`

```swift
var cities = ["Seoul", "New York", "LA", "Santiago"]
cities.count // result: 4
```

`for i in 0..<cities.count`로 반복문을 구현하면 성능 저하가 있음. `cities.count`를 매번 계산하기 때문. `var lenth = cities.count`로 대입하여 사용하는 것이 성능에 유리함

배열의 순회 특성(Iterator)을 활용해서 `for row in cities {}`도 가능하다.

순회 특성 이용시 인덱스를 가져오는 방법

```swift
for row in cities {
  let index = cities.index(of: row)
  print("\(index!)번째 배열 원소는 \(row)입니다")
}
```

제네릭(Generic): 배열 등을 정의할 때 사용 시점에서 < > 기호를 사용하여 배열 내부에서 사용할 아이템 타입을 지정하는 문법

```swift
Array < item type > ()
```

- 문자열 배열의 선언 및 초기화: `var cities = Array<String>()`
- 문자열 배열을 선언: `var cities : Array<String>`

문자열 배열만 선언할 경우, 메모리 공간을 할당받지 않은 상태. 할당 받기 위해서는 아래의 구문이 필요함.

```swift
cities = Array()
```

배열을 선언하는 또다른 형식

```swift
[ item type ]()
```

- 문자열 배열의 선언 및 초기화: `var cities = [String]()`
- 문자열 배열을 선언: `var cities : [String]`

배열이 비어있는지 체크할 경우, `.count`를 체크하는 것도 가능하지만 `.isEmpty` 사용을 권함

배열 아이템 동적 추가 방법

- `append(_:)`: 배열의 맨 뒤에 추가.
- `insert(_:at:)`: `at`에 추가될 위치 입력
- `append(contentsOf:)`: 배열의 맨 뒤에 여러 개의 아이템을 추가. 메소드의 인자값은 항상 배열이어야 함

범위 연산자를 이용한 인덱스 참조

```swift
var alphabet = ["a", "b", "c", "d", "e"]

alphabet[0..2] // ["a", "b", "c"]
alphabet[2..3] // ["c", "d"]
alphabet[1..<3] // ["b", "c"]
```

범위연산자로 배열에 아이템을 삽입하기

```swift
alphabet[1...2] = ["1", "2", "3"]
// ["a", "1", "2", "3", "d", "e"]
```

"b"와 "c"는 삭제되고 "1", "2", "3"이 삽입됨

파운데이션 프레임워크의 배열

- NSArray: 수정이 필요 없는 배열에 사용
- NSMutableArray: 수정이 필요한 배열에 사용

둘다 데이터의 타입에 상관없이 저장 가능. 타입이 명확하게 정해지지 않은 불특정형 집합 데이터나 여러 종류의 값이 섞여 있는 집합 데이터를 처리할 때에는 위 두 개를 활용

## 집합

집합은 내부적으로 해시(Hash) 연산의 결과값을 이용하여 데이터를 저장하므로 집합에 저장할 데이터 타입은 해시 연산을 할 수 있는 타입이어야 함

집합을 정의하는 방법1

```swift
var genres : Set = ["Classic", "Rock", "Balad"]
```

`Set`을 타입 어노테이션으로 지정해줘야 배열이 아닌 집합으로 정의됨. 빈 배열일 경우에는 `Set<String>`처럼 타입도 추가적으로 선언해야 함

집합을 정의하는 방법2: 빈 집합을 정의하기

```swift
Set < item type > ()
```

집합의 속성들

- `insert(_:)`
- `remove(_:)`
- `contains(_:)`: 아이템 유무 확인
- `isEmpty`
- `count`

집합 순회 탐색

`for~in` 구문의 활용. 순서가 필요할 경우 `sort()` 메소드 사용

```swift
for g in genres.sorted() {
  print("\(g)")
}
```

집합의 연산

- `intersection(_:)`: 교집합
- `symmetricDifference(_:)`: 교집합을 뺀 나머지의 집합
- `union(_:)`: 합집합
- `subtract(_:)`: 차집합(한쪽 집합에서 다른쪽 집합을 빼는 연산)

```swift
var oddDigits : Set = [1, 3, 5, 7, 9]
let evenDigits : Set = [0, 2, 4, 6, 8]
let primeDigits : Set = [2, 3, 5, 7]

oddDigits.intersection(evneDigits).sorted()
// [ ]
oddDigits.symmetricDifference(primeDigits).sorted()
// [1, 2, 9]
oddDidigs.union(evenDigits).sorted()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

oddDigits.subtract(primeDigits)
oddDigits.sorted()
// [1, 9]
```

부분집합과 포함관계 판단 연산

- `isSubset(of:)`: 주어진 집합의 값 전체가 특정 집합에 포함되는지 판단
- `isSuperset(of:)`: 주어진 집합이 특정 집합의 모든 값을 포함하는지 판단
- `isStrictSubset(of:)`와 `isStrictSuperset(of:)`: 위의 함수와 동일하게 동작하지만 두집합이 서로 같은 경우의 결과갑이 다름. 정확히 부분 또는 상위집합일때만 true를 반환
- `isDisjoint(with:)`: 두 집합의 공통 값이 없을 때 true, 하나라도 있다면 false

```swift
let A : Set = [1, 3, 5, 7, 9]
let B : Set = [3, 5]
let C : Set = [3, 5]
let D : Set = [2, 4, 6]

B.isSubset(of: A) // true
A.isSuperSet(of: B) // true
C.isStrictSubset(of: A) // true
C.isStrictSubset(of: B) // false
A.isDisjoint(with: d) // true
```

배열에서 중복된 값을 제거한 후 배열로 반환하고 싶을 때 아래처럼 할 수 있음

```swift
var A = [4, 2, 5 ,1, 7, 4, 9, 11, 3, 5, 4]

let B = Set(A) // 집합
A = Array(B) // 중복이 제거된 배열
// [2, 4, 9, 5, 7, 3, 1, 11]
```

`A = Array(Set(A))` 한줄로도 표현 가능

중복을 제거해야하는 프로그램(한사람이 한번씩만 응모에 참여할 수 있는 프로그램처럼)에서 집합을 사용해서 관리하면 편리하다.

## 튜플

여러 가지 타입의 아이템을 저장할 수 있지만, 일단 선언되고 나면 상수적 성격을 띠므로 더 이상 값을 추가하거나 삭제하는 등의 변경이 불가능하다. 즉 타입과 관계없이 다양하게 저장할 수 있지만 오직 최초에 선언된 상태의 아이템만 사용할 수 있고 수정이나 삭제 추가 등 변경할 수 없는 것이 특징이다.

튜플 형식

```swift
( <tuple item1>, <tuple item2>, ...)
```

```swift
let tupleValue = ("a", "b", 1, 2.5, true)

tupleValue.0 // "a"
tupleValue.1 // "b"
tupleValue.2 // 1
tupleValue.3 // 2.5
tupleValue.4 // true
```

타입 정의가 가능함

```swift
var tpl01 : (Int, Int) = (100, 200)
var tpl02 : (Int, String, Int) = (100, "a", 200)
var tpl03 : (String) = ("sample string")
```

`tpl03`은 문자열 변수로 선언됨. 하나의 아이템만 있는 튜플을 아이템 타입의 일반 자료형이 된다.

튜플의 아이템을 개별 변수나 상수로 각각 할당하는 바인딩(Binding) 방식의 구문 제공

```swift
let tupleValue:(String, Character, Int, Float, Bool) = ("a", "b", 1, 2.5, true)
let (a, b, c, d, e) = tupleValue

// a -> "a"
// b -> "b"
// c -> 1
// d -> 2.5
// e -> true
```

튜플은 접근시 대괄호([]) 대신 점(.)으로 연결해 사용한다는 점에서 배열과 차이가 있음. 튜플은 인덱스 속성만 제공하므로 크기를 계산하거나 순회할 수 없음. 튜플은 다양한 값을 반환할 때 편리함

```swift
func getTupleValue() -> (String, String, Int) {
  return ("t", "v", 100)
}

let (a, b, c) = getTupleValue()
// 모두 필요하지 않을 경우 _를 사용할 수 있음. 반환개수는 반드시 일치해야 함
// let (a, b, _) = getTupleValue()
```

## 딕셔너리

고유 키(key)와 그에 대응하는 값(Value)을 연결하여 데이터를 저장하는 자료형

딕셔너리 정의 형식

```swift
[ key: data, key : data, ... ]
```

딕셔너리 주의사항

- 하나의 키에는 하나의 데이터
- 키는 중복 불가, 중복시 수정이 발생해 기존 키에 연결된 데이터가 제거
- 하나의 딕셔너리내의 데이터 타입은 모두 같아야 함
- 아이템에는 순서가 없으나 키에는 내부적으로 순서가 있음. for~in 구문 사용 가능
- 키의 타입은 제한이 없으나 해시(Hash) 연산이 가능해야 함

딕셔너리 예시

```swift
var capital = ["KR":"SEOUL", "EN":"LONDON", "FR":"PARIS"]

capital["KR"] // "SEOUL"
capital["FR"] // "PARIS"
```

딕셔너리 선언 형식1

```swift
Dictionary < keyType, dataType > ()
```

딕셔너리 선언 형식2

```swift
[ keyType : dataType ]()
```

딕셔너리에 아이템 추가

```swift
var newCapital = [String:String]()
newCapital["JP"] = "Tokyo"
```

딕셔너리에 아이템 추가(메소드 사용하기)

```swift
<dictionaryObject>.updateValue(<data>, forKey: <key>)
```

아이템 추가 예시

```swift
newCapital.updateValue("Seoul", forKey: "KR")
// "KR" : "Seoul" 데이터가 추가된 후 nil 반환
```

딕셔너리 아이템 삭제하기

```swift
newCapital["KR"] = nil
```

딕셔너리 아이템 삭제하기(메소드 사용)

```swift
newCapital.removeValue(forKey: "KR")
```

딕셔너리로부터 값을 호출할 때 없는 키를 호출할 가능성이 있으므로 특별한 형식으로 반환해줌

```swift
Optional("Sapporo")
```

다양한 객체지향 프로그래밍에서 오류 처리를 위해 애용되는 에러 캐치(Error Catch)를 대신할 목적으로 도입한 개념으로서, 아키텍처 차원의 안정성을 제공하기 위한 것.

딕셔너리 순회

```swift
for row in newCapital {
  let (key, value) = row
}
```

딕셔너리를 위처럼 순회하면 `key`와 `value`가 한 쌍으로 담긴 튜플이 `row`에 대입된다. 아래처럼도 가능함

```swift
for (key, value) in newCapital {
  // key와 value 사용
}
```

## 최종 정리

- 배열: 순서있는 데이터를 저장할 때 사용. 중복데이터 저장 가능. 데이터는 인덱스로 관리됨
- 집합: 순서 없는 데이터. 중복값 허용 안됨
- 딕셔너리: 순서 없는 데이터를 키-값 형태로 저장. 중복된 값을 저장할 수 있으나 중복된 키를 사용할 순 없음
- 튜플: 데이터를 나열해서 소괄호로 묶어 사용하며, 내부적으로 순서가 있지만, 순회 처리 불가. 서로 다른 타입의 데이터 저장 가능
