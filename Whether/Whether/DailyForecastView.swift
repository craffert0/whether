// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import Foundation
import SwiftUI
import WeatherKit

extension DayWeather: @retroactive Identifiable {
    public var id: Date { date }
}

struct DailyForecastView: View {
    let days: [DayWeather]

    var body: some View {
        Grid {
            ForEach(days.dropFirst()) { d in
                GridRow {
                    Text(d.date.formatted(Date.FormatStyle().weekday(.short)))
                    Image(systemName: d.symbolName)
                    Text("\(d.highTemperature.whether)/\(d.lowTemperature.whether)")
                    Text(d.condition.description)
                }
            }
        }
    }
}
