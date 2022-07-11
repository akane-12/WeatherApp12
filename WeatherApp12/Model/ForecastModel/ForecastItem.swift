//
//  ForecastItem.swift
//  WeatherApp12
//
//  Created by cmStudent on 2022/07/09.
//

import Foundation

struct ForecastItem: Decodable {
    
    
    
    let list: [List]
    struct List: Decodable {
        
        
        let main: Main
        struct Main: Decodable {
            
            
            let temp: Double
            let humidity: Int
        }
        
        let weather: [Weather]
        struct Weather: Decodable {
            
            
            let description: String
            let icon: String
        }
        
        let dtTxt: String
    }
    
    let city: City
    struct City: Decodable {
        
        
        let name: String
    }

    
    
    
    
}

// じかん
//let dateFormatter = DateFormatter()
////dateFormatter.calender = Calender(identifier: .gregorian)
////dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//dateFormatter.locale  = Locale(identifier: "ja_JP")
//// dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
//dateFormatter.timeZone = TimeZone(identifier: "JST")
//
//dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
//
//let date = dateFormatter.date(from: "2022-07-09 15:00:00 +0000")
//let dateNow = Date()
//
//print(date!)
//print(dateNow)
//print(dateFormatter.string(from: date!))
//print(dateFormatter.string(from: dateNow))
