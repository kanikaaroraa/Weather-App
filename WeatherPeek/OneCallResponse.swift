// OneCallResponse.swift

import Foundation

struct OneCallResponse: Codable {
    let lat: Double?
    let lon: Double?
    let timezone: String?
    let timezone_offset: Int?
    let current: CurrentWeather?
    let hourly: [HourlyWeather]?
    let daily: [DailyWeather]?
    let name: String?

    struct CurrentWeather: Codable {
        let temp: Double
        let humidity: Int
        let wind_speed: Double?
        let wind_deg: Int?
        let pop: Double? // Probability of precipitation (0 to 1)
        let weather: [Weather]
    }

    struct HourlyWeather: Codable {
        let dt: TimeInterval // Unix timestamp
        let temp: Double
        let weather: [Weather]
        // Add other hourly data you might need (e.g., weather icon)
    }

    struct DailyWeather: Codable {
        let dt: Int? // Unix timestamp
        let temp: Temp
        let weather: [Weather]
        let pop: Double?

        struct Temp: Codable {
            let day: Double
            let min: Double
            let max: Double
            let night: Double
            let eve: Double
            let morn: Double
        }
    }

    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
}
