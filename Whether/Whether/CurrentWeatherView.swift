// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI
import WeatherKit

struct CurrentWeatherView: View {
    var w: CurrentWeather
    @State private var isDetailPresented: Bool = false

    init(with w: CurrentWeather) {
        self.w = w
    }

    var body: some View {
        VStack {
            BigImage(systemName: w.symbolName)
            Button {
                isDetailPresented = true
            } label: {
                Text(w.temperature.whether).font(.largeTitle)
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $isDetailPresented) {
                detailView
            }
        }
    }

    private var detailView: some View {
        Grid {
            HStack {
                Image(systemName: w.symbolName)
                    .scaledToFit()
                Text(w.condition.description)
            }
            GridRow {
                Text("Temperature")
                Text(w.temperature.whether)
            }
            GridRow {
                Text("Feels like")
                Text(w.apparentTemperature.whether)
            }
            GridRow {
                Text("Dew point")
                Text(w.dewPoint.whether)
            }
            GridRow {
                Text("Wet Bulb")
                Text(w.wetBulb.whether)
            }
            GridRow {
                Text("Humidity")
                Text("\(w.humidity.percentage)%")
            }
        }
    }
}
