//
//  ForecastToCurrentWeatherConverter.swift
//  WeatherPeek
//
//

import Foundation

struct ForecastToCurrentWeatherConverter {
    static func convert(from wind: ForecastResponse.Wind) -> CurrentWeatherResponse.Wind? {
        return CurrentWeatherResponse.Wind(speed: wind.speed, deg: wind.deg)
    }
}
