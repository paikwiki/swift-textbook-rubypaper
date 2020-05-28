import UIKit

for number in 0...4 {
    print("Number: \(number)")
}

let size = 8
let paddingChar = "0"
var value = "123"

for _ in 1...(size - value.count) {
    value = paddingChar + value;
}

print(value)

let n = 0

while n != 0 {
    print("This will be not printed ever.")
}

repeat {
    print("This will be printed once.")
}
while n != 0

let httpResponse = 404

outer : for i in 1...5 {
    inner : for j in 1...9 {
        if (j == 3) {
            break outer
        }
        print("\(i) * \(j) = \(i * j)")
    }
}
