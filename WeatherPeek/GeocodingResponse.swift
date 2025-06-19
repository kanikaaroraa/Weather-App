// GeocodingResponse.swift

import Foundation

struct GeocodingResponse: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String?
    let state: String?
}
