// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2026 Colin Rafferty <colin@rafferty.net>

import SwiftUI
import WeatherKit

struct DayGridRow: View {
    let day: DayWeather
    @State var isDayPresented: Bool = false

    var body: some View {
        GridRow {
            Text(day.date.formatted(Date.FormatStyle().weekday(.short)))
            Image(systemName: day.symbolName)
            Text(day.lowTemperature.whether)
            Text("/")
            Text(day.highTemperature.whether)
            Text(day.condition.description)
        }
        .onTapGesture {
            isDayPresented = true
        }.sheet(isPresented: $isDayPresented) {
            WholeDayView(day: day)
        }
    }
}
