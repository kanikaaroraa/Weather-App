//
//  DailyForecast.swift
//  WeatherPeek
//
//  Created by kanika on 13/04/25.
//

import SwiftUI

struct DailyForecast: Identifiable {
    let id = UUID()
    let day: String
    let icon: String
    let high: Int
    let low: Int
}
