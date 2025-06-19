//
//  OneCallToCurrentWeatherConverter.swift
//  WeatherPeek
//
//  Created by kanika on 16/04/25.
//

import Foundation

struct OneCallToCurrentWeatherConverter {
    static func convert(from oneCall: OneCallResponse) -> CurrentWeatherResponse? {
        guard let current = oneCall.current else {
            return nil
        }

        return CurrentWeatherResponse(
            weather: current.weather.map {
                CurrentWeatherResponse.Weather(
                    id: $0.id,
                    main: $0.main,
                    description: $0.description,
                    icon: $0.icon
                )
            },
            main: CurrentWeatherResponse.Main(
                temp: current.temp,
                feels_like: nil, // Not directly available in One Call current
                temp_min: nil,   // Not directly available in One Call current
                temp_max: nil,   // Not directly available in One Call current
                humidity: current.humidity
            ),
            wind: current.wind_speed != nil ? CurrentWeatherResponse.Wind(speed: current.wind_speed, deg: current.wind_deg) : nil,
            name: nil // City name is in the root of OneCallResponse
        )
    }
}
