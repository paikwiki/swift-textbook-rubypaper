import UIKit

// ====================
// Chapter 11. 오류 처리
// ====================

// -----------------
// 11.1. 오류 처리 구문
// -----------------

// 11.1.1. 오류 타입 정의하기

enum DateParseError: Error {
    case overSizeString
    case underSizeString
    case incorrectFormat(part: String)
    case incorrectData(part: String)
}

// 11.1.2. 오류 던지기

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
    
    return dateResult
}

try parseDate(param: "2020-02-28")

// 11.1.3. 오류 객체 잡아내기

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

let date = try! parseDate(param: "2015-09-31")
print("\(date)")
