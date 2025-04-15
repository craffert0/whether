// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI

struct WhetherView: View {
    @State var homeStore: HomeStore
    @State var model = WhetherModel()

    var body: some View {
        VStack {
            Spacer()
            if let w = model.weather {
                CurrentWeatherView(with: w.currentWeather)
                if let m = w.minuteForecast {
                    MinuteForecastView(with: m)
                }
                Spacer()
                TodayView(today: w.dailyForecast[0])
                HomeView(store: homeStore)
                Spacer()
                DailyForecastView(days: w.dailyForecast.forecast)
                Spacer()
                Text(w.currentWeather.date.formatted(
                    Date.FormatStyle()
                        .hour(
                            .conversationalDefaultDigits(amPM: .abbreviated))
                        .minute()))
            } else {
                Text("no location 😢")
                HomeView(store: homeStore)
            }
            if model.authorized {
                Button("Refresh") { model.refresh() }
            }
        }
    }
}
