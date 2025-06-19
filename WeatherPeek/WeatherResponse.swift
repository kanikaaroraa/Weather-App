//
//  WeatherResponse.swift
//  WeatherPeek
//
//  Created by kanika on 13/04/25.
//

import Foundation

struct WeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
}

struct Weather: Codable {
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int? // Make humidity optional initially
}

// You might need to extend your WeatherResponse to include wind data
extension WeatherResponse {
    var wind: Wind? {
        return nil // Replace with actual wind data if available in your current response
    }
    var mainWithHumidity: MainWithHumidity {
        return MainWithHumidity(temp: main.temp, temp_min: main.temp_min, temp_max: main.temp_max, humidity: main.humidity ?? 0)
    }
}

struct MainWithHumidity: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double? // Make speed optional initially
}
