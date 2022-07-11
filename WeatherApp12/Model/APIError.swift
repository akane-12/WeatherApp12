//
//  ApiError.swift
//  WeatherApp12
//
//  Created by cmStudent on 2022/07/09.
//

import Foundation

enum APIError: Error {
    case urlError
    case responseError
    case jsonError
}
