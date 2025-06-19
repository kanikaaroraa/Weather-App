//
//  HourlyForecastGraphView.swift
//  WeatherPeek
//
//  Created by kanika on 16/04/25.
//

import SwiftUI
import Charts

struct HourlyForecastGraphView: View {
    let hourlyForecasts: [ForecastResponse.ForecastItem]

    var body: some View {
        Chart {
            ForEach(hourlyForecasts, id: \.dt) { forecast in
                LineMark(
                    x: .value("Time", Date(timeIntervalSince1970: forecast.dt)),
                    y: .value("Temperature", forecast.main.temp)
                )
            }
        }
        .frame(height: 150)
    }
}

#Preview {
    let sampleForecastData: [ForecastResponse.ForecastItem] = [
        ForecastResponse.ForecastItem(dt: TimeInterval(Date().timeIntervalSince1970), main: ForecastResponse.Main(temp: 25.0, feels_like: 24.5, temp_min: 24.0, temp_max: 26.0, pressure: 1012, sea_level: 1012, grnd_level: 1000, humidity: 60, temp_kf: nil), weather: [ForecastResponse.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01d")], clouds: ForecastResponse.Clouds(all: 0), wind: ForecastResponse.Wind(speed: 5.0, deg: 270, gust: nil), visibility: 10000, pop: 0.0, sys: ForecastResponse.Sys(pod: "d"), dt_txt: "2025-04-16 22:00:00"),
        ForecastResponse.ForecastItem(dt: TimeInterval(Date().timeIntervalSince1970 + 3 * 3600), main: ForecastResponse.Main(temp: 26.5, feels_like: 26.0, temp_min: 25.5, temp_max: 27.5, pressure: 1011, sea_level: 1011, grnd_level: 999, humidity: 65, temp_kf: nil), weather: [ForecastResponse.Weather(id: 802, main: "Clouds", description: "scattered clouds", icon: "03d")], clouds: ForecastResponse.Clouds(all: 40), wind: ForecastResponse.Wind(speed: 6.0, deg: 280, gust: nil), visibility: 10000, pop: 0.2, sys: ForecastResponse.Sys(pod: "d"), dt_txt: "2025-04-17 01:00:00"),
        ForecastResponse.ForecastItem(dt: TimeInterval(Date().timeIntervalSince1970 + 6 * 3600), main: ForecastResponse.Main(temp: 28.0, feels_like: 27.5, temp_min: 27.0, temp_max: 29.0, pressure: 1010, sea_level: 1010, grnd_level: 998, humidity: 70, temp_kf: nil), weather: [ForecastResponse.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01d")], clouds: ForecastResponse.Clouds(all: 0), wind: ForecastResponse.Wind(speed: 7.0, deg: 290, gust: nil), visibility: 10000, pop: 0.1, sys: ForecastResponse.Sys(pod: "n"), dt_txt: "2025-04-17 04:00:00"),
        ForecastResponse.ForecastItem(dt: TimeInterval(Date().timeIntervalSince1970 + 9 * 3600), main: ForecastResponse.Main(temp: 27.0, feels_like: 26.5, temp_min: 26.0, temp_max: 28.0, pressure: 1009, sea_level: 1009, grnd_level: 997, humidity: 75, temp_kf: nil), weather: [ForecastResponse.Weather(id: 801, main: "Clouds", description: "few clouds", icon: "02n")], clouds: ForecastResponse.Clouds(all: 20), wind: ForecastResponse.Wind(speed: 5.5, deg: 300, gust: nil), visibility: 10000, pop: 0.0, sys: ForecastResponse.Sys(pod: "n"), dt_txt: "2025-04-17 07:00:00"),
        ForecastResponse.ForecastItem(dt: TimeInterval(Date().timeIntervalSince1970 + 12 * 3600), main: ForecastResponse.Main(temp: 25.5, feels_like: 25.0, temp_min: 24.5, temp_max: 26.5, pressure: 1008, sea_level: 1008, grnd_level: 996, humidity: 80, temp_kf: nil), weather: [ForecastResponse.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01n")], clouds: ForecastResponse.Clouds(all: 0), wind: ForecastResponse.Wind(speed: 4.0, deg: 310, gust: nil), visibility: 10000, pop: 0.0, sys: ForecastResponse.Sys(pod: "n"), dt_txt: "2025-04-17 10:00:00"),
    ]
    return HourlyForecastGraphView(hourlyForecasts: sampleForecastData)
}
