// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI
import WeatherKit

struct TodayView: View {
    let today: DayWeather
    @State var isDayPresented: Bool = false

    var body: some View {
        Group {
            if Calendar.current.component(.hour, from: Date.now) < 18 {
                DayView("Today", for: today.restOfDayForecast!)
            } else {
                DayView("Overnight", for: today.overnightForecast)
            }
        }
        .onTapGesture {
            isDayPresented = true
        }.sheet(isPresented: $isDayPresented) {
            WholeDayView(day: today)
        }
    }
}
