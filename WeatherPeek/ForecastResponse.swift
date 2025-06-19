//
//  ForecastResponse.swift
//  WeatherPeek
//
//  Created by kanika on 16/04/25.
//

import Foundation

struct ForecastResponse: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [ForecastItem]
    let city: CityInfo

    struct ForecastItem: Codable {
        let dt: TimeInterval // Unix timestamp
        let main: Main
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let visibility: Int
        let pop: Double // Probability of precipitation
        let sys: Sys
        let dt_txt: String // Date and time in "YYYY-MM-DD HH:MM:SS" format
    }

    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let sea_level: Int
        let grnd_level: Int
        let humidity: Int
        let temp_kf: Double?
    }

    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    struct Clouds: Codable {
        let all: Int
    }

    struct Wind: Codable {
        let speed: Double
        let deg: Int
        let gust: Double?
    }

    struct Sys: Codable {
        let pod: String // Part of the day (n/d)
    }

    struct CityInfo: Codable {
        let id: Int
        let name: String
        let coord: Coordinates
        let country: String
        let population: Int
        let timezone: Int
        let sunrise: TimeInterval
        let sunset: TimeInterval
    }

    struct Coordinates: Codable {
        let lat: Double
        let lon: Double
    }
}
