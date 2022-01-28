//
//  WeatherInformation.swift
//  weather
//
//  Created by Bumsang Kim on 2022/01/28.
//

import Foundation

// codable : JSON decodeing encoding
struct WeatherInformation: Codable {
    let weather:[Weather]
    let temporature:Temporature
    let name: String
    
    enum CodingKeys: String, CodingKey{
        case weather
        case temporature = "main"
        case name
    }
}

struct Weather: Codable {
    let id:Int
    let main:String
    let description:String
    let icon:String
}

struct Temporature: Codable {
    
    let temporature:Double
    let feelsLike:Double
    let minTemporature:Double
    let maxTemporature:Double
    
    enum CodingKeys: String, CodingKey {
        case temporature = "temp"
        case feelsLike = "feels_like"
        case minTemporature = "temp_min"
        case maxTemporature = "temp_max"
    }
}
