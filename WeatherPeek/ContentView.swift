//
//  ContentView.swift
//  WeatherPeek
//
//  Created by kanika on 13/04/25.
//

import SwiftUI
import Charts

struct ContentView: View {
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: Date())
    }
    @FocusState private var cityFieldIsFocused: Bool
    @State private var cityName = ""
    @State private var currentWeather: CurrentWeatherResponse?
    @State private var dailyForecasts: [DailyForecast] = []
    @State private var hourlyForecasts: [ForecastResponse.ForecastItem] = [] // Updated to ForecastItem

    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.1, blue: 0.12)
                .ignoresSafeArea()

            VStack {
                if currentWeather == nil {
                    VStack(spacing: 20) {
                        Text("🌤️ Weather Peek")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        ZStack(alignment: .leading) {
                            if cityName.isEmpty && !cityFieldIsFocused {
                                Text("Enter city name")
                                    .foregroundColor(.white.opacity(0.7))
                                    .padding(.leading, 30)
                            }
                            TextField("", text: $cityName)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(12)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .focused($cityFieldIsFocused)
                        }

                        Button("Get Weather.") {
                            fetchCoordinates(for: cityName)
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    .padding()
                    .frame(maxHeight: .infinity, alignment: .top)
                } else if let weatherData = currentWeather {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Weather")
                                        .foregroundColor(.yellow)
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                    Text(formattedDate())
                                    Text(weatherData.weather.first?.main ?? "-")
                                }
                                Spacer()
                                Text("\(weatherData.main.temp ?? 0, specifier: "%.0f")°C")
                                    .font(.system(size: 60, weight: .light))
                            }
                            .foregroundColor(.white)
                            .padding(.bottom)

                            HStack {
                                WeatherDetailRow(label: "Humidity", value: "\(weatherData.main.humidity ?? 0)%")
                                Spacer()
                                WeatherDetailRow(label: "Wind", value: "\(String(format: "%.1f", weatherData.wind?.speed ?? 0)) km/h")
                                Spacer()
                                WeatherDetailRow(label: "City", value: weatherData.name ?? "-")
                            }
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.bottom)

                            Text("Next Few Days.")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.bottom, 5)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(dailyForecasts) { forecast in
                                        DailyForecastView(forecast: forecast)
                                    }
                                }
                            }
                            .padding(.bottom)

                            VStack(alignment: .leading) {
                                Text("Temperature Outlook.")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 5)
                                if !hourlyForecasts.isEmpty {
                                    HourlyForecastGraphView(hourlyForecasts: hourlyForecasts)
                                } else {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white.opacity(0.1))
                                        .frame(height: 150)
                                        .overlay(
                                            Text("Hourly forecast data not available.")
                                                .foregroundColor(.white.opacity(0.6))
                                                .multilineTextAlignment(.center)
                                                .padding()
                                        )
                                }
                            }
                        }
                        .padding()
                    }
                    .transition(.opacity.animation(.easeInOut(duration: 0.3)))
                }
            }
        }
        .onAppear {
            dailyForecasts = [
                DailyForecast(day: "Sun", icon: "sun.max.fill", high: 36, low: 22),
                DailyForecast(day: "Mon", icon: "sun.max.fill", high: 37, low: 24),
                DailyForecast(day: "Tue", icon: "sun.max.fill", high: 38, low: 26),
                DailyForecast(day: "Wed", icon: "sun.max.fill", high: 40, low: 26),
                DailyForecast(day: "Thu", icon: "sun.max.fill", high: 41, low: 26),
                DailyForecast(day: "Fri", icon: "cloud.sun.fill", high: 41, low: 26),
                DailyForecast(day: "Sat", icon: "sun.max.fill", high: 39, low: 24),
                DailyForecast(day: "Sun", icon: "sun.max.fill", high: 39, low: 23),
            ]
        }
    }

    func fetchCoordinates(for city: String) {
        let apiKey = "9f83635066530dd883d7e2a4aca01bcf" // **REPLACE WITH YOUR ACTUAL API KEY**
        let cityEscaped = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(cityEscaped)&limit=1&appid=\(apiKey)"

        print("Geocoding URL: \(urlString)")

        guard let url = URL(string: urlString) else {
            print("Invalid URL for geocoding")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching coordinates: \(error?.localizedDescription ?? "Unknown")")
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode([GeocodingResponse].self, from: data)
                if let firstResult = decodedResponse.first {
                    let latitude = firstResult.lat
                    let longitude = firstResult.lon
                    print("Coordinates for \(city): Latitude \(latitude), Longitude \(longitude)")
                    fetchForecast(latitude: latitude, longitude: longitude) // Call the new forecast function
                } else {
                    print("City not found.")
                }
            } catch {
                print("Error decoding geocoding response: \(error)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Problematic JSON: \(jsonString)")
                }
            }
        }.resume()
    }

    func fetchForecast(latitude: Double, longitude: Double) {
        let apiKey = "9f83635066530dd883d7e2a4aca01bcf" // **REPLACE WITH YOUR ACTUAL API KEY**
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"

        print("Forecast API URL: \(urlString)")

        guard let url = URL(string: urlString) else {
            print("Invalid URL for forecast data")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching forecast data: \(error?.localizedDescription ?? "Unknown")")
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
                print("Forecast API Data: \(decodedResponse)")
                DispatchQueue.main.async {
                    // Extract hourly data for today (you might need to refine this)
                    let now = Date()
                    let timeIntervalForNext24Hours: TimeInterval = 24 * 3600

                    self.hourlyForecasts = decodedResponse.list.filter { item in
                        let itemDate = Date(timeIntervalSince1970: item.dt)
                        return itemDate > now && itemDate < now.addingTimeInterval(timeIntervalForNext24Hours)
                    }
                    // You might want to update currentWeather from the forecast data as well (e.g., the first item)
                    if let firstForecast = decodedResponse.list.first {
                        self.currentWeather = CurrentWeatherResponse(
                            weather: firstForecast.weather.map {
                                CurrentWeatherResponse.Weather(id: $0.id, main: $0.main, description: $0.description, icon: $0.icon)
                            },
                            main: CurrentWeatherResponse.Main(
                                temp: firstForecast.main.temp,
                                feels_like: firstForecast.main.feels_like,
                                temp_min: firstForecast.main.temp_min,
                                temp_max: firstForecast.main.temp_max,
                                humidity: firstForecast.main.humidity
                            ),
                            wind: ForecastToCurrentWeatherConverter.convert(from: firstForecast.wind),
                            name: decodedResponse.city.name
                        )
                    }
                }
            } catch {
                print("Error decoding forecast response: \(error)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Problematic JSON (Forecast): \(jsonString)")
                }
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response Status Code (Forecast): \(httpResponse.statusCode)")
            }
        }.resume()
    }

    // Removed fetchOneCallWeather

    func getWeatherSymbol(for condition: String) -> String {
        switch condition.lowercased() {
        case "clear":
            return "sun.max.fill"
        case "clouds":
            return "cloud.fill"
        case "rain":
            return "cloud.rain.fill"
        case "thunderstorm":
            return "cloud.bolt.rain.fill"
        case "drizzle":
            return "cloud.drizzle.fill"
        case "snow":
            return "snow"
        case "mist", "fog", "haze":
            return "cloud.fog.fill"
        default:
            return "questionmark"
        }
    }
}

#Preview {
    ContentView()
}
