//
//  DailyForecastView.swift
//  WeatherPeek
//
//  Created by kanika on 13/04/25.
//

import SwiftUI

struct DailyForecastView: View {
    let forecast: DailyForecast

    var body: some View {
        VStack(spacing: 5) {
            Text(forecast.day)
                .font(.subheadline)
                .foregroundColor(.white)
            Image(systemName: forecast.icon)
                .font(.title3)
                .foregroundColor(.yellow)
            Text("\(forecast.high)°")
                .font(.subheadline)
                .foregroundColor(.white)
            Text("\(forecast.low)°")
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding(10)
        .background(Color.white.opacity(0.05))
        .cornerRadius(8)
    }
}
