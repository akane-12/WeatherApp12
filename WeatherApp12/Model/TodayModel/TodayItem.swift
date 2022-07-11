//
//  TodayItem.swift
//  WeatherApp12
//
//  Created by cmStudent on 2022/07/09.
//

import Foundation

struct TodayItem: Decodable {
    
    let weather: [Weather]
    struct Weather: Decodable {
        let description: String
        let icon: String
    }
    
    let main: Main
    struct Main: Decodable {
        let temp: Double
        let humidity: Int
    }

    let name: String

    
    
}
