//
//  ForecastToCurrentWeatherConverter.swift
//  WeatherPeek
//
//  Created by kanika on 16/04/25.
//

import Foundation

struct ForecastToCurrentWeatherConverter {
    static func convert(from wind: ForecastResponse.Wind) -> CurrentWeatherResponse.Wind? {
        return CurrentWeatherResponse.Wind(speed: wind.speed, deg: wind.deg)
    }
}
