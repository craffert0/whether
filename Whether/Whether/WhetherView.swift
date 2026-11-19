// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI
import WeatherKit

struct WhetherView: View {
    @State var model: WhetherModel
    @State private var isWeatherDebugPresented: Bool = false

    var body: some View {
        VStack {
            Spacer()
            if let w = model.weather {
                allWhetherView(w: w)
            } else {
                noWhetherView
            }
        }
        .onShake {
            model.refresh()
        }
    }

    @ViewBuilder
    private var noWhetherView: some View {
        BigImage(systemName: model.location == nil ? "location.slash" : "bolt.slash",
                 size: 120)
        Spacer()
        HomeView(home: model.home)
    }

    @ViewBuilder
    private func allWhetherView(w: Weather) -> some View {
        CurrentWeatherView(w: w.currentWeather, h: w.hourlyForecast)
        if let m = w.minuteForecast {
            MinuteForecastView(with: m)
        }
        Spacer()
        TodayView(today: w.dailyForecast[0])
        HomeView(home: model.home)
        Spacer()
        DailyForecastView(days: w.dailyForecast.forecast)
        Spacer()
        Button(w.currentWeather.date.plain_time) {
            isWeatherDebugPresented = true
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $isWeatherDebugPresented) {
            debugView
        }
    }

    private var debugView: some View {
        TabView {
            Tab("Weather", systemImage: "sunrise") {
                WhetherDebugView(model: model)
            }
            Tab("Location", systemImage: "map") {
                LocationDebugView(model: model)
            }
        }
    }
}
