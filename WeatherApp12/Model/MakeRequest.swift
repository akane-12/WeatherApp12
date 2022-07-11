//
//  MakeRequest.swift
//  WeatherApp12
//
//  Created by cmStudent on 2022/07/09.
//

import Foundation

protocol MakeRequestType {
    
    associatedtype Responce: Decodable
    
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

struct MakeRequestToday: MakeRequestType {
    
    typealias Responce = TodayItem
    
    // Tokyoとか
    private let city: String
    
    private let apiKey = "03fe49e109ba0237c538f526d2110464"
    
    let path = "/data/2.5/weather"
    var queryItems: [URLQueryItem]?
    
    init(city: String) {
        self.city = city
        self.queryItems = [URLQueryItem.init(name: "q", value: city),
                           URLQueryItem.init(name: "appid", value: apiKey),
                           URLQueryItem.init(name: "units", value: "metric"),
                           URLQueryItem.init(name: "lang", value: "ja")]
        
    }
    
}

struct MakeRequestForcast: MakeRequestType {
    
    typealias Responce = ForecastItem
    
    // Tokyoとか
    private let city: String
    
    private let apiKey = "03fe49e109ba0237c538f526d2110464"
    
    let path = "/data/2.5/forecast"
    var queryItems: [URLQueryItem]?
    
    init(city: String) {
        self.city = city
        self.queryItems = [URLQueryItem.init(name: "q", value: city),
                           URLQueryItem.init(name: "appid", value: apiKey),
                           URLQueryItem.init(name: "units", value: "metric"),
                           URLQueryItem.init(name: "lang", value: "ja")]
    }
}
