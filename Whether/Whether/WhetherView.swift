// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI
import SwiftUtil
import WeatherKit

struct WhetherView: View {
    let w: Weather
    let home: LoadingState<HomeModel, Error>

    var body: some View {
        VStack {
            Spacer()
            CurrentWeatherView(w: w.currentWeather, h: w.hourlyForecast)
            if let m = w.minuteForecast {
                MinuteForecastView(with: m)
            }
            Spacer()
            TodayView(today: w.dailyForecast[0])
            HomeView(home: home)
            if let alerts = w.weatherAlerts {
                ForEach(alerts.pairs) {
                    WeatherAlertView(alert: $0.a)
                }
            }
            Spacer()
            DailyForecastView(days: w.dailyForecast.forecast)
            Spacer()
            Text(w.currentWeather.date.plain_time)
        }
    }
}
