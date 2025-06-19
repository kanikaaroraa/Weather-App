//
//  WeatherDetailRow.swift
//  WeatherPeek
//
//  Created by kanika on 13/04/25.
//

import SwiftUI

struct WeatherDetailRow: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.caption)
            Text(value)
                .font(.subheadline)
        }
    }
}
