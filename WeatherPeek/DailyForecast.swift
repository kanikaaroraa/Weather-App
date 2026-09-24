//
//  DailyForecast.swift
//  WeatherPeek
//
//

import SwiftUI

struct DailyForecast: Identifiable {
    let id = UUID()
    let day: String
    let icon: String
    let high: Int
    let low: Int
}
